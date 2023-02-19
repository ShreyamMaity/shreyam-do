FROM ubuntu:22.04

WORKDIR /pkg

COPY . .

ARG PACKAGE_NAME
ARG PACKAGE_VERSION
ENV SNAPCRAFT_DISABLE_REMOTE_PARTS=true

RUN chmod 755 /pkg/DEBIAN/postinst
RUN mkdir -p /packages && \
    dpkg-deb --build /pkg /packages/${PACKAGE_NAME}_${PACKAGE_VERSION}.deb

CMD cp /packages/*.deb /build 
