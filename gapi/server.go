package gapi

import (
	"fmt"

	db "github.com/ranggaAdiPratama/simplebank/db/sqlc"
	"github.com/ranggaAdiPratama/simplebank/pb"
	"github.com/ranggaAdiPratama/simplebank/token"
	"github.com/ranggaAdiPratama/simplebank/util"
)

// Server serves gRPC requests for our banking service
type Server struct {
	config util.Config
	pb.UnimplementedSimpleBankServer
	store      db.Store
	tokenMaker token.Maker
}

// NewServer creates a new gRPC server
func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewPasetoMaker(config.TokenSymetricKey)

	if err != nil {
		return nil, fmt.Errorf("Cannot create token maker: %w", err)
	}

	server := &Server{
		config:     config,
		store:      store,
		tokenMaker: tokenMaker,
	}

	return server, nil
}
