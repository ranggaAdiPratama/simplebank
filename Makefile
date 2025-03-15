createdb:
	docker exec -it postgres17 createdb --username=rangga --owner=rangga simple_bank

dropdb:
	docker exec -it postgres17 dropdb --username=rangga simple_bank

migratedown:
	migrate -path db/migration -database "postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable" -verbose down

migrateup:
	migrate -path db/migration -database "postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable" -verbose up

postgres:
	docker run --name postgres17 -p 5432:5432 -e POSTGRES_USER=rangga -e POSTGRES_PASSWORD=mitsuha -d postgres:17-alpine

.PHONY: createdb dropdb migratedown migrateup postgres