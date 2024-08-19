



FROM nvidia/cuda:12.3.2-devel-ubuntu22.04


RUN mkdir /code
RUN apt-get update && apt-get install -y wget git git-lfs python3.10 python3-pip 

RUN cd /code && rm -rf Envision3D && git clone https://github.com/PKU-YuanGroup/Envision3D.git && cd /code/Envision3D && pip install -r req.txt && pip install carvekit --no-deps

RUN cd /code/Envision3D/pretrained_models && rm -rf ./Envision3D && git clone https://huggingface.co/pytttttt/Envision3D && mv Envision3D/* . && rm -rf ./Envision3D
RUN apt-get update && apt-get install ffmpeg libsm6 libxext6  -y
COPY ./process_img.py /code 
COPY ./Demo-Tank.png /code
RUN ls /code/Envision3D/pretrained_models/
RUN python3.10 -m pip install pytorch-lightning xformers
RUN apt-get install cmake -y

RUN cd /tmp && git clone --recursive https://github.com/nvlabs/tiny-cuda-nn && cd tiny-cuda-nn && cmake . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo && cmake --build build --config RelWithDebInfo -j --verbose
RUN cd /tmp/tiny-cuda-nn && cd bindings/torch python3.10 setup.py install
RUN cd /code/Envision3D/instant-nsr-pl && python3.10 -m pip install -r requirements.txt
RUN python3.10 -m pip install trimesh



