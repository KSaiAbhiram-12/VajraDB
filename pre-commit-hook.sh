
#!/bin/bash

set -e

echo "=> VajraDB: Running SQL Safety Checks..."

STAGED_SQL_FILES=$(git diff --cached --name-only --diff-filter=ACM -- '*.sql')

if [ -n "$STAGED_SQL_FILES" ]; then
  while IFS= read -r FILE; do
    [ -z "$FILE" ] && continue

    echo "Checking: $FILE"

    if ! cargo run --quiet --manifest-path "$(dirname "$0")/local-agent/Cargo.toml" -- verify "$FILE"; then
      echo "VajraDB: Commit blocked. SQL verification failed in $FILE."
      exit 1
    fi
  done <<< "$STAGED_SQL_FILES"

  echo "VajraDB: SQL checks passed."
else
  echo "VajraDB: No staged SQL files found."
fi

exit 0
