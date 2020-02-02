#!/bin/bash

## This scripts assumes that:
##   * You use a ticketing system where tickets have an id of the shape [A-Z]+-[0-9]+. For example, GLEE-313
##   * You name all your feature branches by $TICKET-description. For example, GLEE-313-my-first-feature
##
## Under those two assumptions (which are relatively common), this hook will prepend the code of the commit to all messages.

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
if [ -z "$BRANCH_NAME" ]; then
    echo "Not a git repo"
    exit 1
fi

if [[ ! "$BRANCH_NAME" =~ ^[A-Z]+-[0-9]+ ]]; then
  ## Branch is not following team convention. This could happen for example in master. Nothing to be done
  exit 0
fi

COMMIT=$(cat $1)
if [[ "$COMMIT" =~ ^\[[A-Z]+-[0-9]+\] ]]; then
  ## There is already some code in the commit. For example from amending or applying. Nothing to be done.
  exit 0
fi

if [[ "$COMMIT" =~ ^Merge[[:space:]]branch[[:space:]] ]]; then
  ## Let's not modify automated merge messages
 exit 0
fi

## Get code from branch
CODE=$(echo $BRANCH_NAME | sed -E "s/^([A-Z]+-[0-9]+).*/\1/")
sed -i -e "1s/^/[$CODE] /" $1
