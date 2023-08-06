# Doctor GPT
<p align="center">

<img src="https://i.imgur.com/18jVWiV.png" width="400" height="400">
</p>

DoctorGPT is a Large Language Model that can pass the US Medical Licensing Exam. This is an open-source project with a mission to provide everyone their own private doctor. DoctorGPT believes in

- Free Access 
- Offline Usage 
- Patient Confidentiality
- Cross Platform Availability 
- Self Improvement

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

Install all dependencies in one line using python's [pip](https://pip.pypa.io/en/stable/installation/)

```bash
pip install numpy torch datasets huggingface_hub transformers trl bitsandbytes sentencepiece openai tvm peft onnx
```

## Training DoctorGPT

DoctorGPT is a version of Meta's [Llama2](https://ai.meta.com/llama/) 7 billion parameter Large Language Model that was fine-tuned on a Medical Dialogue Dataset, then further improved using Reinforcement Learning & Constitutional AI. 

#### Cloud Training

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/path/to/your/notebook)

#### Local Training with a [jupyter](https://jupyter.org/install) notebook

```bash
jupyter training.ipynb
```

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
