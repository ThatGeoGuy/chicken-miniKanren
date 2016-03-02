# CHICKEN miniKanren

This repository provides the [canonical miniKanren
implementation](https://github.com/miniKanren/miniKanren), wrapped as an egg
for CHICKEN Scheme. The egg also includes extensions originally provided by
Alex Shinn and modified to work with this version of miniKanren, which
represent code and relations from *The Reasoned Schemer* (Dan Friedman, William
Byrd, and Oleg Kiselyov, MIT Press.).

**Note**: This repository is mirrored on both
[Bitbucket](https://bitbucket.org/ThatGeoGuy/chicken-minikanren/) and
[Github](https://github.com/ThatGeoGuy/chicken-miniKanren). To avoid
duplication of effort, please submit issues via Bitbucket. I have enabled
anonymous issue reporting in case you do not wish to create a Bitbucket account
for the sake of uploading an issue.

## From the miniKanren implementation

Canonical miniKanren implementation.

Implements the language described in the paper:

William E. Byrd, Eric Holk, and Daniel P. Friedman. miniKanren, Live and Untagged: Quine Generation via Relational Interpreters (Programming Pearl). To appear in the Proceedings of the 2012 Workshop on Scheme and Functional Programming, Copenhagen, Denmark, 2012.

### CORE LANGUAGE

**Logical operators:**

==
fresh
conde

**Interface operators:**

run
run\*

### EXTENDED LANGUAGE

**Constraint operators:**

=/=
symbolo
numbero
absento
