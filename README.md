Start here: 


Make sure that you have nvidia-container-runtime enabled for builds.   

sudo apt-get install nvidia-container-runtime   

Edit/create the /etc/docker/daemon.json with content:  

```
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
         } 
    },
    "default-runtime": "nvidia" 
}
```
```
docker run --gpus=2 --network host -it -v $PWD:/code  envision3d:latest 
to Be run in the container
```
git clone https://github.com/PKU-YuanGroup/Envision3D.git
cd /code/Envision3D/pretrained_models/ && git clone https://huggingface.co/pytttttt/Envision3D && cp -r ./Envision3D/* . && rm -rf ./Envision3D
cd /code/Envision3D/pretrained_models/ && git clone https://huggingface.co/clay3d/omnidata && cp omnidata/* . && rm -rf omnidata
cd /code/Envision3D 
CUDA_VISIBLE_DEVICES=1 python3.10 process_img.py example_imgs/pumpkin.png processed_imgs/ --size 256 --recenter
CUDA_VISIBLE_DEVICES=1 python3.10 gen_s1.py --config cfgs/s1.yaml  validation_dataset.filepaths=['pumpkin.png'] validation_dataset.crop_size=224
CUDA_VISIBLE_DEVICES=1 python3.10 gen_s2.py --config cfgs/s2.yaml  validation_dataset.scene=pumpkin
cd instant-nsr-pl/
python3.10 launch.py --config configs/neuralangelo-pinhole-wmask-opt.yaml --gpu 0 --train dataset.scene=pumpkin
```


