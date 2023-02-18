FROM ubuntu:22.04

RUN apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /pkg

COPY . .

ARG PACKAGE_NAME
ARG PACKAGE_VERSION

RUN chmod 755 /pkg/DEBIAN/postinst
RUN mkdir -p /packages && \
    dpkg-deb --build /pkg /packages/${PACKAGE_NAME}_${PACKAGE_VERSION}.deb

CMD cp /packages/*.deb /build
