curl -X POST localhost:3008/backlog/post_to_google_chat \
-H 'Content-Type: application/json;' \
-d '{"content": {
"id":"1",
"summary":"テスト課題",
"comment":"対応完了しました。",
"status":   {"id":"4", "name":"完了"},
"priority": {"id":"3", "name":"中"}
} }'