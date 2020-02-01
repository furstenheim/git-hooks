#!/bin/bash
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
if [ -z "$BRANCH_NAME" ]; then
    echo "Not a git repo"
    exit 1
fi

## Get code from branch
CODE=$(echo $BRANCH_NAME | sed -E "s/^([A-Z]+-[0-9]+).*/\1/")
sed -i -e "1s/^/[$CODE] /" $1
