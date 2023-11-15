postgres:
	docker run --name vasans-postgres --network vasans-bank-network -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=Vasan297Ichizoku -d postgres

createdb:
	docker exec -it vasans-postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it vasans-postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:Vasan297Ichizoku@localhost:5433/simple_bank?sslmode=disable" -verbose up

migrateupone:
	migrate -path db/migration -database "postgresql://root:Vasan297Ichizoku@localhost:5433/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:Vasan297Ichizoku@localhost:5433/simple_bank?sslmode=disable" -verbose down

migratedownone:
	migrate -path db/migration -database "postgresql://root:Vasan297Ichizoku@localhost:5433/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

proto:
	rm -f pb/*.go
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
	--go-grpc_out=pb --go-grpc_opt=paths=source_relative \
	--grpc-gateway_out=pb --grpc-gateway_opt=paths=source_relative \
	proto/*.proto

mock:
	mockgen -package mockdb -destination db/mock/store.go pavanvasan.com/simplebank/db/sqlc Store

evans:
	evans --host localhost --port 9090 -r repl

redis:
	docker run --name redis -p 6379:6379 -d redis:7-alpine

.PHONY: createdb dropdb postgres migrateup migratedown migrateupone migratedownone sqlc test server proto mock evans redis
