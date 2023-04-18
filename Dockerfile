FROM golang:alpine AS gobuild

# build app
WORKDIR /build
COPY app/ ./ 
RUN go build -o ./xyz-demo

# copy build output into runtime container
FROM alpine:latest
WORKDIR /app
COPY --from=gobuild /build/xyz-demo ./

# create non-root user and change ownership of /app directory
RUN addgroup xyzcorp && \
adduser xyzcorp -DH -G xyzcorp && \
addgroup xyzcorp users && \
chown -R xyzcorp:xyzcorp /app/

# switch to non-root user and launch binary
USER xyzcorp
CMD ["./xyz-demo"]
