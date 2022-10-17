# Base image
ARG VARIANT=bullseye-slim
FROM debian:${VARIANT}
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
# Arguments
ARG CONTAINER_USER=esp
ARG CONTAINER_GROUP=esp
ARG NIGHTLY_TOOLCHAIN_VERSION=nightly-2022-03-10
ARG ESP_IDF_VERSION=v4.4.1
ARG ESP_BOARD=esp32s3
ARG XTENSA_TOOLCHAIN_VERSION=1.64.0.0
# The following variable must also be present during container run time:
ENV ESP_IDF_VERSION=v4.4.1
RUN apt-get update \
    && apt-get install -y git curl gcc clang ninja-build libudev-dev unzip xz-utils \
    python3 python3-pip python3-venv libusb-1.0-0 libssl-dev pkg-config libtinfo5  libpython2.7 \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

ENV PATH=${PATH}:$HOME/.cargo/bin


ADD https://github.com/esp-rs/rust-build/releases/download/v${XTENSA_TOOLCHAIN_VERSION}/install-rust-toolchain.sh \
    install-rust-toolchain.sh

RUN bash install-rust-toolchain.sh \
    --extra-crates "ldproxy cargo-espflash web-flash" \
    --build-target "${ESP_BOARD}" \
    --nightly-version "${NIGHTLY_TOOLCHAIN_VERSION}" \
    --esp-idf-version "${ESP_IDF_VERSION}" \
    --minified-esp-idf "YES" \
    --export-file  ${HOME}/export-esp.sh
# Activate ESP-IDF and Xtensa Rust toolchain environment
RUN echo "source ${HOME}/export-esp.sh" >> ~/.bashrc

RUN git clone -b esp32s3 https://github.com/SergioGasquez/espressif-trainings.git espressif-trainings \
    && rm -rf espressif-trainings/book \
    && rm espressif-trainings/intro/hardware-check/Cargo.toml

COPY Cargo.toml espressif-trainings/intro/hardware-check/Cargo.toml

# Fetch
COPY fetch.sh /home/esp/
RUN bash fetch.sh

# Copy compilation script
COPY compile.sh /home/esp/
RUN mkdir -p /home/esp/build-in /home/esp/build-out
