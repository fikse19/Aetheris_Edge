FROM golang:1.23-alpine AS builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o orchestrator .

FROM alpine:3.20
RUN addgroup -S securegroup && adduser -S secureuser -G securegroup
WORKDIR /home/secureuser
COPY --from=builder /app/orchestrator .
USER secureuser
EXPOSE 8080/udp
ENTRYPOINT ["./orchestrator"]
