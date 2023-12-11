## [Understanding git rebase and the "golden rule"](https://stackoverflow.com/questions/46656240/understanding-git-rebase-and-the-golden-rule)

There really is no single, simple, universal rule that works for everyone in every situation.  "Never rebase anything" is a simple rule and does work, but is not for everyone.  There's a somewhat more complicated rule that always works: ***Rebase is OK as long as everyone who has the original commits is willing to switch to the new copies.***

### Description

What you—and everyone you work with—need to know is that Git treats *commits* as quite precious, and works pretty hard to make sure you never lose any; but *branch names* are much less important.  Branch names act as pointers, pointing to specific commits.  The branch names let Git *find* the commits, but it's the *commits* that matter.  When you use `git rebase`, you are telling Git to *copy* some existing (old) commits to some new ones.  The new ones get new "true names" (see below).  There are a lot of reasons to copy old commits to new ones, including the fact that no commit can *ever* change.  Once it's made, it's (mostly) permanent and unchangeable.

You can do one thing to make a commit seem to go away: you can stop using it entirely.  Once no one has used it for a long time, and it has no name and no way to find it, it really does go away.  But commits are precious, so this takes a while.  (The actual mechanism behind this is the *reflog*, which you can read more about elsewhere.)

### A simple progression

Now, commits have big ugly hash IDs as their "true names".  These names are very hard to work with: what's the relative relationship of `d35688db19c9ea97e9e2ce751dc7b47aee21636b` to `4d7268b888d7bb6d675340ec676e4239739d0f6d`, for instance?  Who knows, they're just big ugly numbers, seemingly random.  These are the names that Git really cares about, but not the ones we mere humans use: we use names like `master` or `v2.14`.

This is where branch (and tag) names come in.  Git lets us choose a branch name, like `master`, to use to identify `d35688db19c9ea97e9e2ce751dc7b47aee21636b` for a while.  Eventually we add a *new* commit to the master branch, and the new commit gets a new, different big ugly true name—and Git *changes* our `master` to map it to the new name.  Here's a simple illustration, in a repository that starts out with just three commits:

    A <-B <-C   <--master

The name `master` "points to" commit `C` (where `C` stands in for, say `c0193fa8...`—some big ugly hash ID, anyway).  The branch name holds the current branch-tip hash ID, as a service that Git does automatically.  We say "points to" because Git will follow the name to the ID to obtain the commit.  Commit `C`, in turn, points to—stores the hash ID of—commit `B`, and commit `B` points to commit `A`.  Since commit `A` is the very first one ever made, it does not point anywhere: it is a *root commit*.  This is how Git knows where to stop.

To add a new commit now, you work in the repository work tree, edit files, `git add`, and `git commit`.  Git now writes a new commit—let's call it `D`—which points back to `C`, and *changes the name `master`* to point to your newest commit:

    A--B--C--D   <-- master

(The internal arrows always point backwards, newer commits to older, so there is no real need to keep drawing them.  They get hard to draw in more complicated diagrams.)

### Merges

This works quite well as long as the only thing you ever do is *add new commits*, because Git is built around this whole idea of adding new commits.  If, as in your example, Charles and Taylor both add new commits to some branch(es), and then either one of them, or any third party, goes to get your new commits, Git is capable of adding your commits and their commits together.  If the additions are straightforward:

    A--B--C--D--E--F   <-- master

then the name `master` just keeps moving right as new commits get added on towards the right.  If the additions are done in parallel, Git must add a "merge commit" to record *both* of the newer commits.  Say, for instance, that Charles adds `E` and Taylor adds `F`, with neither working any faster than the other, so that we get this:

               E
              /
    A--B--C--D
              \
               F

Now we have a problem: `master` can only point to *one* commit.  If we pick `E`, we can't handle `F`.  If we pick `F`, we lose `E`.  The merge work-flow handles this by adding, atop `E` and `F`, one new commit `G` that points back to *both* `E` *and* `F`:

               E
              / \
    A--B--C--D   G   <-- master
              \ /
               F

This works fine, but over time you get a lot of merge bubbles that serve only to record the fact that people worked in parallel.  While this is the correct, true history of the project, it is full of useless detail.  This is where rebasing comes in.  Let's take a look at how this works.

### Rebase

Rebase *copies* some commits, and then—at least ideally—you and everyone else who has the originals all *stop using the original commits*.  Instead, you—and everyone else—use the shiny new commits.

Suppose, for instance, we have this:

               E   <-- origin/master
              /
    A--B--C--D
              \
               F   <-- master

The name for commit `E` is `origin/master`, and the name for commit `F` is `master`, *in Taylor's repository*.  (Taylor, remember, made `F`.)

Taylor is the only programmer who has commit `F`.

Taylor now has the option—it's an option, not a requirement—to *copy* commit `F` to a newer, shinier `F'`, with at least one difference: `F'` will point back not to `D`, but to `E`.

(Taylor's new `F'` should have at least one *other* difference: he should pick up whatever work Charles did in `E`, too.)

If Taylor were to run:

    git rebase origin/master

his Git would find a list of commits to copy that would list just commit `F`.  It would then copy `F` to `F'` built atop `E`:

                 F'  <-- [temporary]
                /
               E   <-- origin/master
              /
    A--B--C--D
              \
               F   <-- master

Now comes the tricky part: Taylor's Git will *move* Taylor's `master` to point to the copied commit, abandoning the original `F`.  The result is the same graph, but with the names moved:

                 F'  <-- master
                /
               E   <-- origin/master
              /
    A--B--C--D
              \
               F   [abandoned]

Since `F` is now abandoned—it has no obvious name—Git stops showing it.  The commit is still there, because commits are (mostly) permanent and (entirely) unchanging, but eventually it will go away, because Taylor was the only one who had it, and he's changed his `master` name so that `master` no longer *finds* it.  Starting from `master`, his Git finds `F'`, then `E`, then `D`, then `C`, and so on—it never sees the original `F` any more.

If we stop drawing `F` entirely, and `git push` the new commit `F'` so that everyone else can see it now, we get:

    A--B--C--D--E--F'   <-- master, origin/master

(we've updated `origin/master` because we pushed `F'` so now `origin`'s `master` also points to `F'`, and Taylor's Git knows this and has adjusted his `origin/master` correspondingly).

### The monkey wrench

But suppose now that Taylor pushes `F` before he rebases.  Let's say he makes `F` on branch `feature`, rather than on `master`, so that he has this before he rebases:

               E   <-- origin/master
              /
    A--B--C--D   <-- master
              \
               F   <-- feature

By pushing `F` to `feature` on `origin`, Taylor creates a branch `origin` in another Git.  Taylor's own Git remembers this by making a new name, `origin/feature`, also pointing to `F`:

               E   <-- origin/master
              /
    A--B--C--D   <-- master
              \
               F   <-- feature, origin/feature

Now if Taylor does the same rebase as before, he gets the same `F'` as before, but this time there *is* a name for `F`:

                 F'  <-- feature
                /
               E   <-- origin/master
              /
    A--B--C--D   <-- master
              \
               F   <-- origin/feature

Since the other Git repository at `origin` has a name `feature` pointing to `F`, anyone else, such as Charles, can pick up commit `F`.

Now, remember, commits are precious.  Branch names can change, but the commits are permanent and unchanging, so if Charles has `F`, and Taylor pushes `F'`, *Charles still has commit `F`.*

If Charles knows what he's doing, and knows what Taylor is doing too, Charles can have *his* Git forget about `F`, by moving whatever branch name(s) give him access to `F`.  Once Charles has abandoned `F`, and Taylor has abandoned `F`, *and everyone else who has `F` has abandoned `F`*, then—and only then—can `F` eventually, really go away.

Hence, the rule for using `git rebase` is actually this: *Rebase is OK as long as everyone who has the originals is willing to switch over to the shiny new commits.*  If you—or Taylor—is the *only one* who has the originals, that's much easier.  If you have copied those original commits into other repositories, there are many more people who have to tell their Gits to switch over.

### To merge, or to rebase? That is the question

Merging is easier, because merging means "add a commit that merges".  You may have to do some work during the merge action (the merge-as-a-verb), but once you do, it's done; Git makes a merge commit that records not one but *two* previous commits, and the new commit gets added on, which every Git automatically knows how to handle.

But this clutters up your history with useless information.  Rebasing is more work—copy possibly many commits, and get everyone who had the old ones to switch to the new ones.  There are more chances for error during this process.  Worse, each copy step is, in effect, another merge-as-a-verb.  Once it's all done, though, you have a shiny, clean-looking history, as though you knew exactly where you were going when you started, and never made any false moves.  It's so much easier to see what happened—or rather, what you want people to *think* happened, which is not the same as what actually happened.

It's up to you (and everyone) to decide which to do.  Sometimes rebasing is easy and good.  Sometimes it is hard and good.  Sometimes it is too hard, or not a good idea because it obscures too much real history that really does—or might—matter.  You must make this judgment now: will this matter in the future?  If you rebase now, will your job be easier tomorrow, next month, or next year ... or will it be harder, or the same?