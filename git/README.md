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