# Note: gitpod/workspace-base image references older version of CMake, it's necessary to install newer one
FROM  gitpod/workspace-base
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ARG CONTAINER_USER=gitpod
ARG CONTAINER_GROUP=gitpod
ARG NIGHTLY_VERSION=nightly-2022-03-10
ARG ESP_IDF_VERSION=v4.4.1
ARG ESP_BOARD=esp32c3
ARG XTENSA_TOOLCHAIN_VERSION=1.64.0.0
RUN sudo install-packages git curl gcc clang ninja-build libudev-dev \
    python3 python3-pip libusb-1.0-0 libssl-dev pkg-config libtinfo5 libpython2.7
USER ${CONTAINER_USER}
WORKDIR /home/${CONTAINER_USER}
ENV PATH=${PATH}:/home/${CONTAINER_USER}/.cargo/bin
ADD --chown=${CONTAINER_USER}:${CONTAINER_GROUP} \
    https://github.com/esp-rs/rust-build/releases/download/v${XTENSA_TOOLCHAIN_VERSION}/install-rust-toolchain.sh \
    install-rust-toolchain.sh
RUN chmod a+x install-rust-toolchain.sh \
    && ./install-rust-toolchain.sh \
    --extra-crates "ldproxy cargo-espflash cargo-generate sccache" \
    --build-target "${ESP_BOARD}" \
    --nightly-version "${NIGHTLY_TOOLCHAIN_VERSION}" \
    --esp-idf-version "${ESP_IDF_VERSION}" \
    --minified-esp-idf "YES" \
    --export-file  ${HOME}/export-esp.sh
