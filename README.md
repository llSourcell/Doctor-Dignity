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
- [Datasets](https://huggingface.co/docs/datasets/index)        (Access datasets from huggingface hub)
- huggingface_hub (access huggingface data & models) 
- numpy           (Use matrix math operations)
- PyTorch         (Build Deep Learning models)
- Transformers    (Access models from HuggingFace hub)
- trl             (Transformer Reinforcement Learning. And fine-tuning.)
- Bitsandbytes    (makes models smaller, aka 'quantization')
- tiktoken        (Data enncoding scheme aka 'tokenization')
- OpenAI          (Create synthetic fine-tuning and reward model data)
- TVM             (Tensor Virtual Machine, converts onnx model to effiicent cross-platform use)
- peft            (Parameter Efficient Fine Tuning, use low rank adaption (LoRa) to fine-tune)
- onnx            (Convert trained model to universal format)

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
