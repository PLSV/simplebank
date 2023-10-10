postgres:
	docker run --name vasans-postgres -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=Vasan297Ichizoku -d postgres

createdb:
	docker exec -it vasans-postgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it vasans-postgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:Vasan297Ichizoku@localhost:5433/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:Vasan297Ichizoku@localhost:5433/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go pavanvasan.com/simplebank/db/sqlc Store

.PHONY: createdb dropdb postgres migrateup migratedown sqlc test server mock
