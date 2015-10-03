#!/bin/bash
COMMIT_MSG='
#!/bin/sh
BRANCH=`git branch | grep '^\*' | cut -b3-`
FILE=`cat "$1"`
echo $(cat "$1") " --skip-ci" > "$1"
'
echo -e "$COMMIT_MSG" > .git/hooks/commit-msg

chmod a+x .git/hooks/commit-msg
