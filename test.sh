#!/bin/bash
TOTAL_FAILURES=0
## Make sure that our mock overrides git
PATH=$(pwd)/test:$PATH
function testCase () {
    echo "$1" > ./test/.test-branch
    echo "$2" > ./test/.test-commit
    ./prepare-commit-msg-hook.sh ./test/.test-commit

    RESULT=$(cat ./test/.test-commit)
    if [ "$RESULT" != "$3" ]; then
        TOTAL_FAILURES=$(($TOTAL_FAILURES + 1))
        echo "Expected $3 got $RESULT"
    fi
}

testCase GLEE-313-my-first-branch "Such an awesome commit" "[GLEE-313] Such an awesome commit"
testCase OPP-4313-my-first-branch "Such an awesome commit" "[OPP-4313] Such an awesome commit"
testCase my-branch-has-no-code "Sad commit" "Sad commit"
testCase GLEE-313-my-first-branch "[GLEE-313] Commit to be amended, so it already has code" "[GLEE-313] Commit to be amended, so it already has code"
testCase GLEE-313-my-first-branch "Merge branch master into 'GLEE-313-my-first-branch'" "Merge branch master into 'GLEE-313-my-first-branch'"


ANSI_RESET='\e[39m'
ANSI_RED='\e[31m'
ANSI_GREEN='\e[32m'

if [ "$TOTAL_FAILURES" -eq 0 ]; then
    echo -e ${ANSI_GREEN}Success!!${ANSI_RESET}
else
    echo -e  ${ANSI_RED}Failure. $TOTAL_FAILURES tests failed.${ANSI_RESET}
fi
exit $TOTAL_FAILURES

