# There are a few Dockerfile restrictions when using Github Actions
# See: https://docs.github.com/en/actions/creating-actions/dockerfile-support-for-github-actions

FROM debian:bullseye-slim
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ARG NIGHTLY_TOOLCHAIN_VERSION=nightly-2022-03-10
ARG ESP_IDF_VERSION=v4.4.1
ARG ESP_BOARD=esp32s3
ARG XTENSA_TOOLCHAIN_VERSION=1.64.0.0

RUN apt-get update \
    && apt-get install -y git curl gcc clang ninja-build libudev-dev unzip xz-utils \
    python3 python3-pip python3-venv libusb-1.0-0 libssl-dev pkg-config libtinfo5  libpython2.7 \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts

ENV PATH=${PATH}:$HOME/.cargo/bin


ADD https://github.com/esp-rs/rust-build/releases/download/v${XTENSA_TOOLCHAIN_VERSION}/install-rust-toolchain.sh \
    install-rust-toolchain.sh

RUN bash install-rust-toolchain.sh \
    --extra-crates "ldproxy cargo-espflash" \
    --build-target "${ESP_BOARD}" \
    --nightly-version "${NIGHTLY_TOOLCHAIN_VERSION}" \
    --esp-idf-version "${ESP_IDF_VERSION}" \
    --minified-esp-idf "YES" \
    --export-file  ${HOME}/export-esp.sh
# Activate ESP-IDF and Xtensa Rust toolchain environment
RUN echo "source ${HOME}/export-esp.sh" >> ~/.bashrc

# RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
#     --default-toolchain ${NIGHTLY_VERSION} -y --profile minimal \
#     && $HOME/.cargo/bin/rustup component add rust-src --toolchain ${NIGHTLY_VERSION} \
#     && $HOME/.cargo/bin/rustup target add riscv32imc-unknown-none-elf

# RUN $HOME/.cargo/bin/cargo install cargo-espflash ldproxy \
#     && $HOME/.cargo/bin/cargo install web-flash --git https://github.com/bjoernQ/esp-web-flash-server \
#     && RUSTFLAGS="--cfg tokio_unstable" $HOME/.cargo/bin/cargo install wokwi-server --git https://github.com/MabezDev/wokwi-server --locked

# RUN mkdir -p ${HOME}/.espressif/frameworks/ \
#     && git clone --branch ${ESP_IDF_VERSION} -q --depth 1 --shallow-submodules \
#     --recursive https://github.com/espressif/esp-idf.git \
#     ${HOME}/.espressif/frameworks/esp-idf \
#     && python3 ${HOME}/.espressif/frameworks/esp-idf/tools/idf_tools.py install cmake \
#     && ${HOME}/.espressif/frameworks/esp-idf/install.sh ${ESP_BOARD} \
#     && rm -rf .espressif/dist \
#     && rm -rf .espressif/frameworks/esp-idf/docs \
#     && rm -rf .espressif/frameworks/esp-idf/examples \
#     && rm -rf .espressif/frameworks/esp-idf/tools/esp_app_trace \
#     && rm -rf .espressif/frameworks/esp-idf/tools/test_idf_size
# ENV IDF_TOOLS_PATH=${HOME}/.espressif
# RUN echo "source ${HOME}/.espressif/frameworks/esp-idf/export.sh > /dev/null 2>&1" >> ~/.bashrc
CMD "/bin/bash"
