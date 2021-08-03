FROM golang as builder

WORKDIR /app

COPY . /app

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o server ./cmd/server/*


FROM scratch

COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /app/server /

EXPOSE 8080
CMD ["/server"]
