FROM public.ecr.aws/ubuntu/ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer="apsoyka@protonmail.com"

RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt update && \
    apt install --no-install-recommends --yes \
    python3-full python3-pip python3-wheel python3-setuptools python3-dev python3-gdbm python3-opencv python3-pil python3-tk python3-numpy \
    cython3 build-essential gcc g++ make ffmpeg x264 x265 git git-lfs bash libglib2.0-0 libharfbuzz-dev libfribidi-dev libxcb1-dev \
    libtiff5-dev libjpeg8-dev libopenjp2-7-dev zlib1g-dev libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --break-system-packages \
    torch torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/cu121 \
    --extra-index-url https://pypi.org/simple

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --break-system-packages \
    triton xformers

RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --break-system-packages \
    -r https://raw.githubusercontent.com/comfyanonymous/ComfyUI/master/requirements.txt \
    -r https://raw.githubusercontent.com/ltdrdata/ComfyUI-Manager/main/requirements.txt \
    -r https://raw.githubusercontent.com/WASasquatch/was-node-suite-comfyui/main/requirements.txt \
    -r https://raw.githubusercontent.com/Kosinkadink/ComfyUI-VideoHelperSuite/main/requirements.txt

RUN printf 'CREATE_MAIL_SPOOL=no' >> /etc/default/useradd && \
    mkdir -p /home/runner /home/scripts && \
    groupadd runner && \
    useradd runner -g runner -d /home/runner && \
    chown runner:runner /home/runner

COPY --chown=runner:runner entrypoint.sh /entrypoint.sh
COPY --chown=runner:runner extra_model_paths.yaml /extra_model_paths.yaml

USER runner:runner
WORKDIR /home/runner
EXPOSE 8188
ENV CLI_ARGS="" PATH=/home/runner/bin:$PATH
ENTRYPOINT [ "/entrypoint.sh" ]
