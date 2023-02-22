## [An Absolute Beginner's Guide to Using npm](https://nodesource.com/blog/an-absolute-beginners-guide-to-using-npm/)
> `npm init`
> 
> Generate **package.json** file
## [Do I need both package-lock.json and package.json?](https://stackoverflow.com/questions/45052520/do-i-need-both-package-lock-json-and-package-json)

**package-lock.json**: records the exact version of each installed package which allows you to re-install them. Future installs will be able to build an identical dependency tree.

**package.json**: records the minimum version you app needs. If you update the versions of a particular package, the change is not going to be reflected here.

----
## [package.json vs package-lock.json: do you need both?](https://dev.to/salothom/package-json-vs-package-lock-json-do-you-need-both-1mjf)

### package.json

If your project uses node package manager (NPM) you will have a `package.json` file somewhere in your code base.

The `package.json` file records the minimum version of different dependencies that your app needs. When a collaborator on the code does **npm install** the dependency versions installed will be those dictated in the `package.json` or a higher/more recent reversion. If you update the versions of a particular package, the change is not necessarily going to be reflected here.

The package.json file is used for more than just dependencies. It also is used to define project properties, descriptions, and license information.

```json

{
  "name": "My-Home-Page",
  "version": "1.0.0",
  "license": "UNLICENSED",
  "author": "Sarah",
  "description": "Sarah's Homepage",
  "keywords": [
    "Home Page",
    ""
  ],
  "homepage": "https://myHomePage.com",
  "repository": {
    "type": "git",
    "url": "https://github.com/YOURREPO"
  },
  "scripts": {
    "start": "gulp startlocal",
  },
  "engines": {
    "node": "^10.2.0",
    "npm": "~6.5.0"
  },
  "dependencies": {
    "angular": "1.8.0",
    "angular-material": "1.4.20",
    "c3": "0.6.11",
    "d3": "3.6.6",
    "jquery": "3.6.7",
    "md5": "2.0.2",
  }
```

If you look in the example package.json there are `^` and `~`. The `^` before the dependency version tells npm that if someone clones the project and runs `npm install` it should install the **latest minor version**. If it has a `~` it will update to the **latest patch version**. This can sometimes cause issues since the collaborators on the same project might all be on different dependency versions.

### package-lock.json

Where the `package.json` file is used for a handful of different things, the `package-lock.json` file is solely used to "lock" dependencies to a specific version number, including minor and patch versions. It will ignore the `^` and the `~` of the `package.json` file. This file keeps track of the the exact version of each installed package which means that future installs will be able to build an identical dependency tree.

This is important in some large application spaces with many dependencies. Some dependency versions do not play well with each other, so making sure to "lock in" the versions prevents a lot of issues from occurring. This is especially useful when there are multitudes of individuals collaborating on one code base. In this way, collaborators who npm install 6 months apart will be looking at the same versions getting installed

### So you don't need both?

Here's the short answer:
Do you need both package-lock.json and package.json? No.
Do you need the package.json? Yes.
Can you have a project with only the package-lock.json? No.

### Should I keep both?

There's a good chance you should! Especially if you keep up with dependency upgrades as needed. It helps to generate the same results on every environment, which will make work flow with many collaborators much easier.

You will want to commit the changes to the package-lock.json as well, so that in deployment npm will be grabbing the same packages as it was grabbing in your local/test environments.

## Semantic Versioning ([Semver](https://semver.org/))

> **MAJOR.MINOR.PATCH**
> 
> 0.7.3

- **MAJOR** : Thay đổi (hay còn gọi là breaking changes) khi những API cũ không còn tương thích nữa . VD : gọi là 2.0.0 khi các api từ bản 1.0.0 không còn dùng được nữa.
- **MINOR**: Thay đổi khi thêm những tính năng mới tuy nhiên những API từ phiên phản trước đó vẫn có thể dùng trong phiên bản này. VD: Phiên bản 1.1.0 thêm một số tính năng tuy nhiên những API từ phiên bản 1.0.0 vẫn được giữ nguyên
- **PATCH**: Phiên bản thay đổi khi có những fix bug cho những phiên bản trước đó và API hoàn toàn vẫn tương thích với các phiên bản cũ.