<!-- Shamelessly copied a great deal of this from the Flame repository

https://github.com/flame-engine/flame

MIT License

Copyright (c) 2021 Blue Fire

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

 -->

# Contribution Guidelines

**Note:** If these contribution guidelines are not followed your issue or PR might be closed, so please read these instructions carefully.


## Contribution types


### Bug Reports

- If you find a bug, please first report it using [Github issues].
  - First check if there is not already an issue for it; duplicated issues will be closed.


### Bug Fix

- If you'd like to submit a fix for a bug, please read the [How To](#how-to-contribute) for how to
   send a Pull Request.
- Indicate on the open issue that you are working on fixing the bug and the issue will be assigned
   to you.
- Write `Fixes #xxxx` in your PR text, where xxxx is the issue number (if there is one).
- Include a test that isolates the bug and verifies that it was fixed.


### New Features

- If you'd like to add a feature to the library that doesn't already exist, feel free to describe the feature in a new [GitHub issue].
- If you'd like to implement the new feature, please wait for feedback from the project maintainers
   before spending too much time writing the code. In some cases, enhancements may not align well
   with the project future development direction.
- Implement the code for the new feature and please read the [How To](#how-to-contribute).


### Documentation & Miscellaneous

- If you have suggestions for improvements to the documentation, tutorial or examples (or something
   else), we would love to hear about it.
- As always first file a [Github issue].
- Implement the changes to the documentation, please read the [How To](#how-to-contribute).


## How To Contribute

### Requirements

For a contribution to be accepted:

- Format the code using `dart format .`;
- Lint the code with the proper tool;
- Check that all tests pass;
- Documentation should always be updated or added (if applicable);
- Examples should always be updated or added (if applicable);
- Tests should always be updated or added (if applicable);
- The PR title should start with a [conventional commit] prefix (`feat:`, `fix:` etc).

If the contribution doesn't meet these criteria, a maintainer will discuss it with you on the issue or PR. You can still continue to add more commits to the branch you have sent the Pull Request from and it will be automatically reflected in the PR.


## Open an issue and fork the repository

- If it is a bigger change or a new feature, first of all
   [file a bug or feature report][GitHub issue], so that we can discuss what direction to follow.
- [Fork the project][fork guide] on GitHub.
- Clone the forked repository to your local development machine
   (e.g. `git clone git@github.com:<YOUR_GITHUB_USER>/omesh.git`).


### Performing changes

- Create a new local branch from `main` (e.g. `git checkout -b my-new-feature`)
- Make your changes (try to split them up with one PR per feature/fix).
- When committing your changes, make sure that each commit message is clear
 (e.g. `git commit -m 'Make mesh gradients look decent'`).
- Push your new branch to your own fork into the same remote branch
 (e.g. `git push origin my-username.my-new-feature`, replace `origin` if you use another remote.)


### Open a pull request

Go to the [pull request page][PRs] and in the top
of the page it will ask you if you want to open a pull request from your newly created branch.

The title of the pull request should start with a [conventional commit] type.

Allowed types are:

- `fix:` -- patches a bug and is not a new feature;
- `feat:` -- introduces a new feature;
- `docs:` -- updates or adds documentation or examples;
- `test:` -- updates or adds tests;
- `refactor:` -- refactors code but doesn't introduce any changes or additions to the public API;
- `perf:` -- code change that improves performance;
- `build:` -- code change that affects the build system or external dependencies;
- `ci:` -- changes to the CI configuration files and scripts;
- `chore:` -- other changes that don't modify source or test files;
- `revert:` -- reverts a previous commit.

If you introduce a **breaking change** the conventional commit type MUST end with an exclamation
mark (e.g. `feat!: Remove the position argument from PositionComponent`).

Examples of PR titles:

- feat: Maake mesh gradients great again
- fix(#123): Fix this bug on the issue # 123
- docs: Make documentation decent
- test: Add some tests to that feature


[GitHub issue]: https://github.com/renancaraujo/omesh/issues
[GitHub issues]: https://github.com/renancaraujo/omesh/issues
[fork guide]: https://docs.github.com/en/get-started/quickstart/contributing-to-projects
[conventional commit]: https://www.conventionalcommits.org
[PRs]: https://github.com/renancaraujo/omesh/pulls



