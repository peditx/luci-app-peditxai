#!/bin/sh

API_KEY=$(uci get peditxai.settings.api_key)
MESSAGE=$(echo "$QUERY_STRING" | sed -n 's/.*message=\([^&]*\).*/\1/p' | sed 's/%20/ /g')

curl -X POST "https://api.deepseek.com/v1/chat" \
     -H "Authorization: Bearer $API_KEY" \
     -H "Content-Type: application/json" \
     -d "{\"message\": \"$MESSAGE\"}"
