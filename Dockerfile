FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go install github.com/air-verse/air@latest

RUN go build -o main .

FROM golang:1.23

WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /go/bin/air /usr/local/bin/air

CMD ["air"]
