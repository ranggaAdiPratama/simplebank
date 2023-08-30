createdb:
	docker exec -it postgres16 createdb --username=rangga --owner=rangga simple_bank

dropdb:
	docker exec -it postgres16 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable" -verbose down

postgres:
	docker run --name postgres16 -p 5432:5432 -e POSTGRES_USER=rangga -e POSTGRES_PASSWORD=mitsuha -d postgres

sqlc:
	docker run --rm -v F:\go\simplebank:/src -w /src kjconroy/sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb dropdb migrateup migratedown postgres sqlc test
