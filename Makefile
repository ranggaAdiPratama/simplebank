createdb:
	docker exec -it postgres16 createdb --username=rangga --owner=rangga simple_bank

dropdb:
	docker exec -it postgres16 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/ranggaAdiPratama/simplebank/db/sqlc Store

postgres:
	docker run --name postgres16 --network bank-network -p 5432:5432 -e POSTGRES_USER=rangga -e POSTGRES_PASSWORD=mitsuha -d postgres

server:
	go run main.go

sqlc:
	docker run --rm -v F:\go\simplebank:/src -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb dropdb migrateup migrateup1 migratedown migratedown1 mock postgres server sqlc test

# migrate create -dir db/migration -ext sql -seq add_user_detail
