package main

import (
	"database/sql"
	"log"

	"github.com/ranggaAdiPratama/simplebank/api"
	db "github.com/ranggaAdiPratama/simplebank/db/sqlc"

	_ "github.com/lib/pq"
)

const (
	dbDriver      = "postgres"
	dbSource      = "postgresql://rangga:mitsuha@localhost:5432/simple_bank?sslmode=disable"
	serverAddress = "127.0.0.1:8000"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)

	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)

	server := api.NewServer(store)

	err = server.Start(serverAddress)

	if err != nil {
		log.Fatal("cannot start server:", err)
	}
}
