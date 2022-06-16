#!/usr/bin/env bash

set -e

dir=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)

TEST_MORE_PATH=$dir/../test-more-bash
BASHLIB="`
    find $TEST_MORE_PATH -type d |
    grep -E '/(bin|lib)$' |
    xargs -n1 printf "%s:"`"
PATH=$BASHLIB$PATH

source bash+ :std
use Test::More
plan tests 12

PATH=$dir/..:$PATH

ok "$(retry)" 'retry without parameter is ok'
like "$(retry --help)" usage: 'retry help is shown'
ok $? 'calling help returns success'
set +e; out=$(retry --unknown-option 2>&1); rc=$?; set -e
is $rc 1 'calling with unknown option returns failure'
like "$out" 'unrecognized option.*usage:' 'retry help is shown for unknown option'
ok "$(retry true)" 'successful command returns success'
is "$(retry true)" '' 'successful command does not show any output by default'
set +e; out=$(retry -s 0 false 2>&1); rc=$?; set -e
like "$out" 'Retrying up to 3 more.*Retrying up to 1' 'failing command retries'
is $rc 1 'failing command returns no success'
set +e; out=$(retry -s 1 -e -r 2 false 2>&1); rc=$?; set -e
like "$out" 'sleeping 1s.*sleeping 2s' 'sleep amount doubles'
is $rc 1 'failing command returns no success'
set +e; out=$(retry -s 0 -r 1 -- sh -c 'echo -n .; false' 2>/dev/null); set -e
is "$out" '..' 'specified number of tries (1+retries)'
