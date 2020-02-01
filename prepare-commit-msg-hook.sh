#!/bin/bash
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
  ## There is already some code in the commit. For example from ammending or applying. Nothing to be done.
  exit 0
fi

if [[ "$COMMIT" =~ ^Merge[[:space:]]branch[[:space:]] ]]; then
  ## Let's not modify automated messages
 exit 0
fi

## Get code from branch
CODE=$(echo $BRANCH_NAME | sed -E "s/^([A-Z]+-[0-9]+).*/\1/")
sed -i -e "1s/^/[$CODE] /" $1
