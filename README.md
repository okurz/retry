# retry ![](https://github.com/okurz/retry/workflows/ci/badge.svg)

A simply retry tool in plain POSIX sh.


## How to use

Simply call

```
retry $cmd
```

to execute `$cmd` and on failure retry multiple times with some waiting time
between calls. Multiple command line parameters exist to tweak execution.

It is possible to specify no waiting time if desired:

```
retry -s 0 $cmd
```

If it is necessary to specify command line parameters to `$cmd` separate the
arguments with `--` like this:

```
retry -- $cmd --my-argument -X 3
```

Often it is desired to command the execution with a timeout. This can be done
with the `timeout` command from [GNU
coreutils](https://www.gnu.org/software/coreutils/) already present on many
systems. Either use with a global timeout:

```
timeout 10 retry $cmd
```

to execute `$cmd` with retrying but only wait up to 10s in total. Or with a
timeout per execution:

```
retry -- timeout 10 $cmd
```

## Contribute

This project lives in https://github.com/okurz/retry

Feel free to add issues in github or send pull requests.

### Rules for commits

* For git commit messages use the rules stated on
  [How to Write a Git Commit Message](http://chris.beams.io/posts/git-commit/) as
  a reference

If this is too much hassle for you feel free to provide incomplete pull
requests for consideration or create an issue with a code change proposal.

### Local testing

#### Functional testing

This is done with the [Test::More bash
library](https://github.com/ingydotnet/test-more-bash).
It will be automatically cloned.


To execute tests call

```
make test
```

#### Style checks

```
make checkstyle
```

## License

This project is licensed under the MIT license, see LICENSE file for details.
