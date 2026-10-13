# VajraDB
SQL migration safety checks with Ed25519 signature verification and an audit ledger


frontend:        cd frontend && npm install && npm run dev
server-gateway:  cd server-gateway && go mod tidy && go run .
local-agent:     cd local-agent && cargo run -- verify file.sql
