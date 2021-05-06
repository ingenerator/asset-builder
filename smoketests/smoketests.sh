#!/bin/bash
set -o errexit
set -o nounset

# Build absolute path to this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TMPDIR=$(mktemp -d -t asset-smoketests-XXXXXXXXXX)

echo "Running asset build"
cd $DIR
docker run --rm -v "$PWD":/workspace $DOCKER_IMAGE compile-assets

echo "Verify built file list"
find "compiled/" -type f | sort > "$TMPDIR/built-files.txt"
diff "$DIR/expected/filelist.txt" "$TMPDIR/built-files.txt"

echo "Verify built CSS"
diff --ignore-trailing-space "$DIR/compiled/site.css" "$DIR/expected/site.css"

echo "Verify minified JS"
set +o errexit
node "compiled/base_js.min.js" > "$TMPDIR/base_js_out.txt"
node_exit=$?
set -o errexit
if [ "$node_exit" -ne 0 ] ; then
  echo "Running built JS failed with code $node_exit"
  cat "$TMPDIR/base_js_out.txt"
  exit 1
fi

diff --ignore-all-space "$DIR/expected/base_js_out.txt" "$TMPDIR/base_js_out.txt"

echo "Test it fails on jshint failure"
set +o errexit
docker run --rm -v "$PWD":/workspace "$DOCKER_IMAGE" jshint:invalid_js > "$TMPDIR/jshint-output.txt"
jshint_exit=$?
set -o errexit

if [ "$jshint_exit" -eq 0 ] ; then
  echo "Expected jshint failure, got incorrect exit code 0"
  cat "$TMPDIR/jshint-output.txt"
  exit 1
fi

echo "-> jshint correctly failed with code $jshint_exit"
echo "-> Checking for correct output"
diff "$DIR/expected/jshint_fail_output.txt" "$TMPDIR/jshint-output.txt"

echo "**********************"
echo ":) All tests passed :)"
echo "**********************"
