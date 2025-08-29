APP=danbooru-tag
APP_EXECUTABLE="./bin/$(APP)"

.SILENT:

quality: fmt vet 

fmt:
	go fmt ./...

vet:
	go vet ./...

tidy: quality
	go mod tidy

## Test
test: tidy
	go test -v ./... -coverprofile=coverage.out

coverage: test
	go tool cover -html=coverage.out
## Build
build:
	mkdir -p bin/
	go build -o $(APP_EXECUTABLE)
	@echo "Build done"

run: build
	chmod +x $(APP_EXECUTABLE)
	$(APP_EXECUTABLE)

.PHONY: clean
clean:
	go clean
	rm -rf bin/
	rm -f ./coverage.out

.PHONY: all test build
all: 
	@-$(MAKE) -s test
	@-$(MAKE) -s build

