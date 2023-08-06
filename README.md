# Doctor GPT
<p align="center">

<img src="https://i.imgur.com/18jVWiV.png" width="400" height="400">
</p>

## Overview
DoctorGPT is a Large Language Model that can pass the US Medical Licensing Exam. This is an open-source project with a mission to provide everyone their own private doctor. DoctorGPT is a version of Meta's [Llama2](https://ai.meta.com/llama/) 7 billion parameter Large Language Model that was fine-tuned on a Medical Dialogue Dataset, then further improved using Reinforcement Learning & Constitutional AI. Since the model is only 3 Gigabytes in size, it fits on any local device, so there is no need to pay an API to use it. It's free, made for offline usage which preserves patient confidentiality, and it's available on iOS, Android, and Web. Let's *actually* disrupt healthcare.

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
- [TVM](https://tvm.apache.org/)             (Tensor Virtual Machine, converts onnx model to effiicent cross-platform use)
- [Peft](https://huggingface.co/blog/peft)            (Parameter Efficient Fine Tuning, use low rank adaption (LoRa) to fine-tune)
- [Onnx](https://onnx.ai/)            (Convert trained model to universal format)

## Installation

Install all dependencies in one line using [pip](https://pip.pypa.io/en/stable/installation/)

```bash
pip install numpy torch datasets huggingface_hub transformers trl bitsandbytes sentencepiece openai tvm peft onnx
```

## Training

In order to train the model, you can run the training.ipynb notebook locally or remotely via a cloud service like Google Colab Pro. The training process requires a GPU, and if you don't have one then the most accessible option i found was using Google Colab [Pro](https://colab.research.google.com/signup) which costs $10/month. The total training time for DoctorGPT including supervised fine-tuning of the initial LLama model on custom medical data, as well as further improving it via Reinforcement Learning from Constitional AI Feedback took 24 hours on a paid instance of Google Colab. If you're interested in learning more about how this process works, details are in the training.ipynb notebook. 

#### Cloud Training

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/path/to/your/notebook)

#### Local Training

```bash
jupyter training.ipynb
```
Get jupyter [here](https://jupyter.org/install)

## Using DoctorGPT

1. iOS

```bash
git clone https://github.com/username/repository.git
cd iOS
```
  
2. Android

```bash
git clone https://github.com/username/repository.git
cd android
```

3. Web

```bash
git clone https://github.com/username/repository.git
cd Web
```

## Contributions

## Credits

Meta, MedAlpaca, Apache, & OctoML 
