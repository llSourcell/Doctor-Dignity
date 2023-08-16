<h1>Doctor GPT</h1>
<p align="center">
    <img src="https://i.imgur.com/18jVWiV.png" width="400" height="400">
</p>

<h2>Overview</h2>
<p>DoctorGPT is a Large Language Model designed to pass the US Medical Licensing Exam. This open-source project aims to provide individuals with their own private doctor. DoctorGPT is based on Meta's Llama2, a 7 billion parameter Large Language Model. It has been fine-tuned on a Medical Dialogue Dataset and further enhanced using Reinforcement Learning & Constitutional AI. The model, at just 3 gigabytes in size, is suitable for local devices, eliminating the need for API payments. It is free, optimized for offline usage to maintain patient confidentiality, and available on iOS, Android, and the Web. Contributions through pull requests for new features and improvements are highly encouraged.</p>

<h2>Dependencies</h2>
<p>To get started, ensure you have the following dependencies installed:</p>
<ul>
    <li><a href="https://numpy.org/install/">Numpy</a> (Used for matrix math operations)</li>
    <li><a href="https://pytorch.org/">PyTorch</a> (Building Deep Learning models)</li>
    <li><a href="https://huggingface.co/docs/datasets/index">Datasets</a> (Accessing datasets from Hugging Face hub)</li>
    <li><a href="https://huggingface.co/docs/huggingface_hub/v0.5.1/en/package_reference/hf_api">Huggingface_hub</a> (Accessing Hugging Face data & models)</li>
    <li><a href="https://huggingface.co/docs/transformers/index">Transformers</a> (Accessing models from Hugging Face hub)</li>
    <li><a href="https://huggingface.co/docs/trl/index">Trl</a> (Transformer Reinforcement Learning & fine-tuning)</li>
    <li><a href="https://github.com/TimDettmers/bitsandbytes">Bitsandbytes</a> (Model size reduction, 'quantization')</li>
    <li><a href="https://github.com/google/sentencepiece">Sentencepiece</a> (Byte Pair Encoding scheme, 'tokenization')</li>
    <li><a href="https://openai.com">OpenAI</a> (Creating synthetic fine-tuning and reward model data)</li>
    <li><a href="https://tvm.apache.org/">TVM</a> (Tensor Virtual Machine, converting ONNX model for efficient cross-platform use)</li>
    <li><a href="https://huggingface.co/blog/peft">Peft</a> (Parameter Efficient Fine Tuning, using low-rank adaption (LoRa) to fine-tune)</li>
    <li><a href="https://onnx.ai/">Onnx</a> (Converting trained model to universal format)</li>
</ul>
<p>To install all dependencies at once using <a href="https://pip.pypa.io/en/stable/installation/">pip</a>:</p>
<pre><code>pip install numpy torch datasets huggingface_hub transformers trl bitsandbytes sentencepiece openai tvm peft onnx</code></pre>

<h2>Training</h2>
<p>To train the model, you can run the <code>training.ipynb</code> notebook either locally or on a cloud service like Google Colab Pro. The training process requires a GPU. If you don't have one, Google Colab Pro is a viable option, costing $10/month. The total training time for DoctorGPT, including supervised fine-tuning of the initial Llama model on custom medical data and further improvement via Reinforcement Learning from Constitutional AI Feedback, took 24 hours on a paid Google Colab instance. For detailed insights into the training process, refer to the <code>training.ipynb</code> notebook.</p>
<h3>Cloud Training</h3>
<p><a href="https://colab.research.google.com/github/llSourcell/DoctorGPT/blob/main/llama2.ipynb"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"></a> Click here: <a href="https://colab.research.google.com/github/llSourcell/DoctorGPT/blob/main/llama2.ipynb">https://colab.research.google.com/github/llSourcell/DoctorGPT/blob/main/llama2.ipynb</a></p>
<h3>Local Training</h3>
<pre><code>git clone https://github.com/llSourcell/DoctorGPT.git
jupyter training.ipynb</code></pre>
<p>Download Jupyter <a href="https://jupyter.org/install">here</a></p>

<h2>Usage: https://huggingface.co/llSourcell/medllama2_7b</h2>
<p>DoctorGPT can be accessed through Hugging Face repositories. There are two versions available: one optimized for mobile, and the other not.</p>
<h3>iOS</h3>
<ol>
    <li> <a href="https://github.com/mlc-ai/mlc-llm/tree/main/ios">Download</a> the iOS Machine Learning Compilation Chat Repository</li>
    <li> Follow the <a href="https://mlc.ai/mlc-llm/docs/deploy/ios.html">installation steps</a></li>
    <li> Run the app on your iOS device or simulator, then tap "add model variant"</li>
    <li> Enter the URL for the latest DoctorGPT model to download it: <a href="https://huggingface.co/llSourcell/doctorGPT_mini">https://huggingface.co/llSourcell/doctorGPT_mini</a></li>
    <li> Tap 'Add Model' to begin local chatting, no internet connection needed!</li>
</ol>
<h3>Android</h3>
<ol>
    <li> <a href="https://github.com/mlc-ai/mlc-llm/tree/main/android">Download</a> the Android Machine Learning Compilation Chat Repository</li>
    <li> Follow the <a href="https://mlc.ai/mlc-llm/docs/deploy/android.html">installation steps</a></li>
    <li> Tap "add model variant"</li>
    <li> Enter the URL for the latest DoctorGPT model to download it: <a href="https://huggingface.co/llSourcell/doctorGPT_mini">https://huggingface.co/llSourcell/doctorGPT_mini</a></li>
    <li> Tap 'Add Model' and start chatting locally, no internet required.</li>
</ol>
<h3>Web (TODO)</h3>
<p>As an experiment in Online Learning using human feedback, the model is deployed as a Flask API with a React front-end. Chatting with the model is possible through this URL. After each query, a human rates the model's response, which is then used to further enhance the model's performance through reinforcement learning. To run the app, download Flask and execute:</p>
<pre><code>flask run</code></pre>
<p>Visit localhost:3000 to interact with the app! You can also deploy it to <a href="https://vercel.com/templates/ai">Vercel</a></p>

<h2>Credits</h2>
<p>This project is made possible with contributions from Meta, MedAlpaca, Apache, MLC Chat & OctoML.</p>
