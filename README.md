# Doctor Dignity
<p align="center">


DISCLAIMER - Do not take any advice from Doctor Dignity seriously yet. This is a work in progress and taking any advice seriously could result in serious injury or even death. 

<img src="https://i.imgur.com/18jVWiV.png" width="400" height="400">
</p>

## Overview
Doctor Dignity is a Large Language Model that can pass the US Medical Licensing Exam. This is an open-source project with a mission to provide everyone their own private doctor. Doctor Dignity is a version of Meta's [Llama2](https://ai.meta.com/llama/) 7 billion parameter Large Language Model that was fine-tuned on a Medical Dialogue Dataset, then further improved using Reinforcement Learning & Constitutional AI. Since the model is only 3 Gigabytes in size, it fits on any local device, so there is no need to pay an API to use it. It's free, made for offline usage which preserves patient confidentiality, and it's available on iOS, Android, and Web. Pull requests for feature additions and improvements are encouraged.

## Dependencies
- [Numpy](https://numpy.org/install/)           (Use matrix math operations)
- [PyTorch](https://pytorch.org/)         (Build Deep Learning models)
- [Datasets](https://huggingface.co/docs/datasets/index)        (Access datasets from huggingface hub)
- [Huggingface_hub](https://huggingface.co/docs/huggingface_hub/v0.5.1/en/package_reference/hf_api) (access huggingface data & models) 
- [Transformers](https://huggingface.co/docs/transformers/index)    (Access models from HuggingFace hub)
- [Trl](https://huggingface.co/docs/trl/index)             (Transformer Reinforcement Learning. And fine-tuning.)
- [Bitsandbytes](https://github.com/TimDettmers/bitsandbytes)    (makes models smaller, aka 'quantization')
- [Sentencepiece](https://github.com/google/sentencepiece)       (Byte Pair Encoding scheme aka 'tokenization')
- [OpenAI](https://openai.com)          (Create synthetic fine-tuning and reward model data)
- [TVM](https://tvm.apache.org/)             (Tensor Virtual Machine, converts onnx model to efficient cross-platform use)
- [Peft](https://huggingface.co/blog/peft)            (Parameter Efficient Fine Tuning, use low rank adaption (LoRa) to fine-tune)
- [Onnx](https://onnx.ai/)            (Convert trained model to universal format)



## Installation

Install all dependencies in one line using [pip](https://pip.pypa.io/en/stable/installation/)

```bash
pip install numpy torch datasets huggingface_hub transformers trl bitsandbytes sentencepiece openai tvm peft onnx
```

## iOS QuickStart v2

1. Clone this repository
```bash
git clone https://github.com/llSourcell/Doctor-Dignity
```
2. Download the Weights
```bash
mkdir -p dist/prebuilt
git clone https://github.com/mlc-ai/binary-mlc-llm-libs.git dist/prebuilt/lib
cd dist/prebuilt
git lfs install
wget --no-check-certificate 'https://drive.google.com/file/d/1MLy8BDhuTTcXqagzLFMA07JDzqjQYUTB/view?pli=1'
cd ../..
```
3. Build the Tensor Virtual Machine Runtime
```bash
git submodule update --init --recursive
pip install apache-tvm
cd ./ios
pip install --pre --force-reinstall mlc-ai-nightly mlc-chat-nightly -f https://mlc.ai/wheels 
./prepare_libs.sh
```
** Find the right version of MLC LLM for your system [here](https://mlc.ai/package/)
4. Add Weights to Xcode
```bash
cd ./ios
open ./prepare_params.sh # make sure builtin_list only contains "RedPajama-INCITE-Chat-3B-v1-q4f16_1"
./prepare_params.sh
```
5. Open Xcode Project and run! 


## DIY Training

In order to train the model, you can run the training.ipynb notebook locally or remotely via a cloud service like Google Colab Pro. The training process requires a GPU, and if you don't have one then the most accessible option i found was using Google Colab [Pro](https://colab.research.google.com/signup) which costs $10/month. The total training time for Doctor Dignity including supervised fine-tuning of the initial LLama model on custom medical data, as well as further improving it via Reinforcement Learning from Constitional AI Feedback took 24 hours on a paid instance of Google Colab. If you're interested in learning more about how this process works, details are in the training.ipynb notebook. 

#### Cloud Training

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/llSourcell/DoctorGPT/blob/main/llama2.ipynb)
click here: https://colab.research.google.com/github/llSourcell/Doctor-Dignity/blob/main/llama2.ipynb

#### Local Training

```bash
git clone https://github.com/llSourcell/Doctor-Dignity.git
jupyter training.ipynb
```
Get jupyter [here](https://jupyter.org/install)

## Usage  https://huggingface.co/llSourcell/medllama2_7b

There are 2 huggingface repos, one which is quantized for mobile and one that is not.

#### Old iOS app 
   
- Step 1: [Download](https://github.com/mlc-ai/mlc-llm/tree/main/ios) the iOS Machine Learning Compilation Chat Repository
- Step 2: Follow the [installation steps](https://mlc.ai/mlc-llm/docs/deploy/ios.html) 
- Step 3: Once the app is running on your iOS device or simulator, tap "add model variant"
- Step 4: Enter the URL for the latest Doctor Dignity model to download it: [https://huggingface.co/llSourcell/doctorGPT_mini] (https://huggingface.co/llSourcell/doctorGPT_mini)
- Step 5: Tap 'Add Model' and start chatting locally, inference runs on device. No internet connection needed!

#### Android app (TODO)

- Step 1: [Download](https://github.com/mlc-ai/mlc-llm/tree/main/android) the Android Machine Learning Compilation Chat Repository
- Step 2: Follow the [installation steps]([https://mlc.ai/mlc-llm/docs/deploy/ios.html](https://mlc.ai/mlc-llm/docs/deploy/android.html)) 
- Step 3: Tap "add model variant"
- Step 4: Enter the URL for the latest Doctor Dignity model to download it: [https://huggingface.co/llSourcell/doctorGPT_mini](https://huggingface.co/llSourcell/doctorGPT_mini)
- Step 5: Tap 'Add Model' and start chatting locally! No internet needed. 

#### Web (TODO)

As an experiment in Online Learning using actual human feedback, i want to deploy the model as a Flask API with a React front-end. In this case, anyone can chat with the model at this URL. After each query, a human can rate the model's response. This rating is then used to further improve the model's performance through reinforcement learning. to run the app, download [flask](https://flask.palletsprojects.com/en/2.3.x/) and then you can run:

```bash
flask run
```

Then visit localhost:3000 to interact with it! You can also deploy to [vercel](https://vercel.com/templates/ai)

## Credits

Meta, MedAlpaca, Apache, MLC Chat & OctoML 

