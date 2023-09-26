# build stage
FROM golang:1.20-alpine3.18 AS builder
WORKDIR /app
COPY . .
RUN go build -o main main.go

# run stage
FROM alpine:3.18
WORKDIR /app
COPY --from=builder /app/main .

EXPOSE 8000
CMD [ "/app/main" ]
