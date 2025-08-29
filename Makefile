APP=danbooru-tag
APP_EXECUTABLE="./bin/$(APP)"


quality:
	make fmt
	make vet

fmt:
	go fmt ./...

vet:
	go vet./...

tidy:
	go mod tidy

## Test
test:
	make tidy
	go test -v ./... -coverprofile=coverage.out

coverage:
	make test
	go tool cover -html=coverage.out
## Build
build:
	mkdir -p bin/
	go build -o $(APP_EXECUTABLE)
	@echo "Build done"

run:
	make build
	chmod +x $(APP_EXECUTABLE)
	$(APP_EXECUTABLE)

clean:
	go clean
	rm -rf bin/

.PHONY: all test build vendor

all:
	make quality
	make test
	make build
