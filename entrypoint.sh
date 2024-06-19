#!/usr/bin/env bash

cd /home/runner

git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules \
    https://github.com/comfyanonymous/ComfyUI.git 2>/dev/null || \
    (cd /home/runner/ComfyUI && git pull)

cd /home/runner/ComfyUI/custom_nodes

git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules \
    https://github.com/ltdrdata/ComfyUI-Manager.git 2>/dev/null || \
    (cd /home/runner/ComfyUI/custom_nodes/ComfyUI-Manager && git pull)

git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules \
    https://github.com/WASasquatch/was-node-suite-comfyui.git 2>/dev/null || \
    (cd /home/runner/ComfyUI/custom_nodes/was-node-suite-comfyui && git pull)

git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules \
    https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git 2>/dev/null || \
    (cd /home/runner/ComfyUI/custom_nodes/ComfyUI_Comfyroll_CustomNodes && git pull)

git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules \
    https://github.com/SeargeDP/SeargeSDXL.git 2>/dev/null || \
    (cd /home/runner/ComfyUI/custom_nodes/SeargeSDXL && git pull)

git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules \
    https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git 2>/dev/null || \
    (cd /home/runner/ComfyUI/custom_nodes/ComfyUI-VideoHelperSuite && git pull)

export PATH="${PATH}:/home/runner/.local/bin"
export PYTHONPYCACHEPREFIX="/home/runner/.cache/pycache"

cd /home/runner

python3 -m venv --system-site-packages .

python3 /home/runner/ComfyUI/main.py --listen --port 8188 ${CLI_ARGS}
