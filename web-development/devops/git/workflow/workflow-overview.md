## [5 Git Workflows you can use to deliver better code](https://medium.com/@svikashk/5-git-workflows-you-can-use-to-deliver-better-code-9b8c84e0135f)

I haven’t met a developer who looked at a conflict message and did not pull their hair strands with frustration.

Trying to resolve each merge conflict is one of those things that every developer hates. Especially if it hits you when you’re gearing up for a production deploy!

This is where having the right Git workflow set up can do a world of good for your [development workflow](https://zepel.io/blog/simple-software-development-workflow/?utm_source=medium&utm_medium=text&utm_campaign=git-workflow).

Of course, having the right git workflow will not solve all your problems. But it’s a step in the right direction. After all, with every team working remotely, the need to build features together without having your codebase getting disrupted is critical.

How you set it up depends on the project you’re working on, the release schedules your team has, the size of the team, and more!

In this article, we’ll walk you through 5 different git workflows, their benefits, their cons, and when you should use them. Let’s jump in!

## 1\. Basic Git Workflow

The most basic git workflow is the one where there is only one branch — the master branch. Developers commit directly into it and use it to deploy to the staging and production environment.

![Basic git workflow](https://gist.github.com/assets/22516811/fe89aa71-d6f7-4135-a5ef-f4a2700f9d7f)

This workflow isn’t usually recommended unless you’re working on a side project and you’re looking to get started quickly.

Since there is only one branch, there really is no process over here. This makes it effortless to get started with Git. However, some cons you need to keep in mind when using this workflow are:

1.  Collaborating on code will lead to multiple conflicts.
2.  Chances of shipping buggy software to production is higher.
3.  Maintaining clean code is harder.

## 2\. Git Feature Branch Workflow

The Git Feature Branch workflow becomes a must have when you have more than one developer working on the same codebase.

Imagine you have one developer who is working on a new feature. And another developer working on a second feature. Now, if both the developers work from the same branch and add commits to them, it would make the codebase a huge mess with plenty of conflicts.

![git workflow with feature branch](https://gist.github.com/assets/22516811/ac5c61e9-40ca-4fc8-b33c-47bd9c5eda34)

To avoid this, the two developers can create two separate branches from the master branch and work on their features individually. When they’re done with their feature, they can then merge their respective branch to the master branch, and deploy without having to wait for the second feature to be completed.

The Pros of using this workflow is, the git feature branch workflow allows you to collaborate on code without having to worry about code conflicts.

## 3\. Git Feature Workflow with Develop Branch

This workflow is one of the more popular workflows among developer teams. It’s similar to the Git Feature Branch workflow with a develop branch that is added in parallel to the master branch.

In this workflow, the master branch always reflects a production-ready state. Whenever the team wants to deploy to production they deploy it from the master branch.

![git workflow with develop and feature branch](https://gist.github.com/assets/22516811/aff3bdfd-dad4-4f64-9196-0761af2d19d5)

The develop branch reflects the state with the latest delivered development changes for the next release. Developers create branches from the develop branch and work on new features. Once the feature is ready, it is tested, merged with develop branch, tested with the develop branch’s code in case there was a prior merge, and then merged with master.

The advantage of this workflow is, it allows teams to consistently merge new features, test them in staging, and deploy to production. While maintaining code is easier, it can get a little tiresome for some teams since it can feel like going through a tedious process.

## 4\. Gitflow Workflow

The gitflow workflow is very similar to the previous workflow we discussed combined with two other branches — the release branch and the hot-fix branch.

## The hot-fix branch

The hot-fix branch is the only branch that is created from the master branch and directly merged to the master branch instead of the develop branch. It is used only when you have to quickly patch a production issue. An advantage of this branch is, it allows you to quickly deploy a production issue without disrupting others’ workflow or without having to wait for the next release cycle.

Once the fix is merged into the master branch and deployed, it should be merged into both develop and the current release branch. This is done to ensure that anyone who forks off develop to create a new feature branch has the latest code.

## The release branch

The release branch is forked off of develop branch after the develop branch has all the features planned for the release merged into it successfully.

No code related to new features is added into the release branch. Only code that relates the release is added to the release branch. For example, documentation, bug fixes, and other tasks related to this release are added to this branch.

Once this branch is merged with master and deployed to production, it’s also merged back into the develop branch, so that when a new feature is forked off of develop, it has the latest code.

![gitflow git workflow](https://gist.github.com/assets/22516811/b2e53208-f835-4ac4-ae35-367479a295d4)

This workflow was first published and made popular by [Vincent Driessen](http://nvie.com/posts/a-successful-git-branching-model/) and since then it has been widely used by organizations that have a scheduled release cycle.

Since the git-flow is a wrapper around Git, you can install git-flow in your current repository. It’s a straightforward process and it doesn’t change anything in your repository other than creating branches for you.

To install on a Mac machine, execute `brew install git-flow` in your terminal.

To install on a Windows machine, you’ll need to [download and install the git-flow](https://git-scm.com/download/win). After the installation is done, run `git flow init` to use it in your project.

## 5\. Git Fork Workflow

The Fork workflow is popular among teams who use open-source software.

The flow usually looks like this:

1.  The developer forks the open-source software’s official repository. A copy of this repository is created in their account.
2.  The developer then clones the repository from their account to their local system.
3.  A remote path for the official repository is added to the repository that is cloned to the local system.
4.  The developer creates a new feature branch is created in their local system, makes changes, and commits them.
5.  These changes along with the branch are pushed to the developer’s copy of the repository on their account.
6.  A pull request from the branch is opened to the official repository.
7.  The official repository’s manager checks the changes and approves the changes to get merged into the official repository.

## Your own workflow!

The git workflows I’ve shown in this article are examples of some of the popular and best working workflows for the development team. Some teams create a branch for Staging and it works perfectly for them.