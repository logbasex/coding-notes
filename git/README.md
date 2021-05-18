# Config

```
man git config
touch ~/.gitconfig
```
- https://gist.github.com/pksunkara/988716

## Viewing unpushed commit

```shell
git log --branches --not --remotes
git cherry -v
```
## [Git revert to previous commit](https://stackoverflow.com/questions/4114095/how-do-i-revert-a-git-repository-to-a-previous-commit)

```shell script
git reset --hard <commidId> && git push --force

Be careful with the --force flag as it removes all the subsequent commits after the selected commit without the option to recover them.
```

Further reading [here](https://stackoverflow.com/a/3338774/10393067).

- Remove origin
    ```shell script
    git remote remove origin
    ```

## [Search commit](https://stackoverflow.com/questions/2928584/how-to-grep-search-committed-code-in-the-git-history)
Search in any revision, any file 

    git rev-list --all | xargs git grep <regexp>
    
Search working tree for text matching regular expression regexp:

    git grep <regexp>

Search working tree for lines of text matching regular expression regexp1 or regexp2:

    git grep -e <regexp1> [--or] -e <regexp2>
 
Search working tree for lines of text matching regular expression regexp1 and regexp2, reporting file paths only:

    git grep -l -e <regexp1> --and -e <regexp2>

Search working tree for files that have lines of text matching regular expression regexp1 and lines of text matching regular expression regexp2:

    git grep -l --all-match -e <regexp1> -e <regexp2>

Search working tree for changed lines of text matching pattern:

    git diff --unified=0 | grep <pattern>

Search all revisions for text matching regular expression regexp:

    git grep <regexp> $(git rev-list --all)

Search all revisions between rev1 and rev2 for text matching regular expression regexp:

    git grep <regexp> $(git rev-list <rev1>..<rev2>)


## List all developer on a project

    git shortlog --summary --numbered --email
    

## Git fetch and pull

Rebase and autostash

    git pull --rebase --autostash    

## Cheat sheet
- https://gist.github.com/chrismccoy/8775224
