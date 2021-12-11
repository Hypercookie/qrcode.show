FROM alpine:latest as builder

LABEL maintainer="jannes"

RUN apk add rust
RUN apk add cargo
RUN apk add git
RUN git clone https://github.com/Hypercookie/qrcode.show qrcode
RUN cd qrcode && cargo build --release
RUN apk add ca-certificates tzdata

FROM alpine:latest
RUN apk add libgcc
EXPOSE 8080
COPY --from=builder /qrcode/target/release/axum-server axum-server
CMD ["./axum-server"]

