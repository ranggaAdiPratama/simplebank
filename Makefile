DB_URL=postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable
GRPC_PORT=9000

createdb:
	docker exec -it postgres16 createdb --username=rangga --owner=rangga simple_bank

db_docs:
	dbdocs build doc/db.dbml

db_schema:
	dbml2sql --postgres -o doc/schema.sql doc/db.dbml

dropdb:
	docker exec -it postgres16 dropdb simple_bank

evans:
	evans --host localhost --port ${GRPC_PORT} -r repl

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migrateup1:
	migrate -path db/migration -database "$(DB_URL)" -verbose up 1

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

migratedown1:
	migrate -path db/migration -database "$(DB_URL)" -verbose down 1

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/ranggaAdiPratama/simplebank/db/sqlc Store

postgres:
	docker run --name postgres16 --network bank-network -p 5432:5432 -e POSTGRES_USER=rangga -e POSTGRES_PASSWORD=mitsuha -d postgres

proto:
	rm -f pb/*.go
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
    --go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	--grpc-gateway_out=pb --grpc-gateway_opt=paths=source_relative \
    proto/*.proto

server:
	go run main.go

sqlc:
	docker run --rm -v F:\go\simplebank:/src -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb db_docs db_schema dropdb evans migrateup migrateup1 migratedown migratedown1 mock postgres proto server sqlc test

# migrate create -dir db/migration -ext sql -seq add_user_detail
