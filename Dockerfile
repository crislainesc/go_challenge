FROM golang:alpine AS builder

WORKDIR /app

COPY . .

RUN apk add --no-cache upx

RUN cd cmd && \
  go build -ldflags="-s -w" -o /app/main && \
  upx --best /app/main

FROM scratch

WORKDIR /

COPY --from=builder /app / 

ENTRYPOINT [ "./main" ]


