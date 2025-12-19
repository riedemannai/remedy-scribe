# RemedyScribe

<div align="center">

![RemedyScribe Logo](favicon.svg)

**Medical Speech Recognition for Clinical Documentation**

[Features](#features) • [Installation](#installation) • [Usage](#usage) • [Technology](#technology)

</div>

---

## About RemedyScribe

RemedyScribe is a modern web application for medical speech recognition, specifically optimized for clinical documentation. The app enables medical professionals to create audio recordings directly in the browser and automatically transcribe them into text.

## Features

- 🎙️ **Direct Browser Audio Recording** - No additional software required
- 📝 **Automatic Transcription** - Uses Parakeet-MLX for precise transcription
- 💾 **Combined Text Display** - All transcriptions are merged together
- ✏️ **Text Editing** - Direct editing in the browser
- 📋 **Copy Function** - One-click copy to clipboard
- 🗑️ **Delete Function** - Quick reset
- ⏱️ **Recording Timer** - Shows recording duration
- 🎨 **Modern UI** - User-friendly, professional interface
- 🏥 **Medical Design** - Optimized for clinical environments

## Screenshots

![RemedyScribe Interface](https://via.placeholder.com/800x400/00d4aa/ffffff?text=RemedyScribe+Interface)

## Installation

### Prerequisites

- Python 3.10 or higher
- UV (Python Package Manager) - optional, but recommended
- A running transcription server (e.g., [Parakeet-MLX Server](https://github.com/riedemannai/parakeet-mlx-server))

### Quick Start

```bash
# 1. Clone repository
git clone git@github.com:riedemannai/remedy-scribe.git
cd remedy-scribe

# 2. Install dependencies
pip install -r requirements_remedy_scribe.txt

# 3. Start web app
./start_remedy_scribe_simple.sh
```

### With UV (recommended)

```bash
# 1. Clone repository
git clone git@github.com:riedemannai/remedy-scribe.git
cd remedy-scribe

# 2. Install and start with UV
uv pip install fastapi "uvicorn[standard]"
uv run --no-project python remedy_scribe_webapp.py
```

## Usage

### 1. Start Transcription Server

First, a transcription server must be running:

```bash
# Example: Parakeet-MLX Server
cd ../parakeet-mlx-server
./start_server.sh
```

### 2. Start RemedyScribe Web App

```bash
# Simplest method
./start_remedy_scribe_simple.sh

# Or directly
python remedy_scribe_webapp.py
```

### 3. Open Browser

Open your browser and navigate to:

```
http://localhost:8003
```

### Workflow

1. **Start Recording**: Click "Aufnahme starten" (Start Recording)
2. **Speak**: Speak into the microphone
3. **Stop Recording**: Click "Stoppen" (Stop)
4. **Transcription**: The recording is automatically transcribed
5. **Edit Text**: Edit the text directly in the text field
6. **Copy**: Use the copy button
7. **Delete**: Reset everything with the delete button

## Technology

### Frontend
- **HTML5** with modern CSS
- **JavaScript** (MediaRecorder API)
- **Responsive Design** for desktop and mobile

### Backend
- **FastAPI** - Modern Python web framework
- **Uvicorn** - ASGI server
- **Python 3.10+**

### Audio Processing
- **Format**: WAV (16kHz, Mono)
- **Codec**: Opus (Browser) → WAV (Server)

### Transcription API
- **Compatibility**: OpenAI-compatible API
- **Endpoint**: `/v1/audio/transcriptions`
- **Model**: Parakeet-TDT-0.6B-V3 (default)

## Configuration

### Change Port

```bash
# Via environment variable
PORT=8080 python remedy_scribe_webapp.py

# Or via command line
uvicorn remedy_scribe_webapp:app --port 8080
```

### Change Server URL

The server URL for transcription can be adjusted in `test_transcription.html`:

```javascript
const serverUrlInput = document.getElementById('server-url');
// Default: http://localhost:8002
```

## Development

### Project Structure

```
remedy-scribe/
├── remedy_scribe_webapp.py    # FastAPI Backend
├── test_transcription.html     # Frontend HTML
├── favicon.svg                 # SVG Favicon
├── favicon.png                 # PNG Favicon
├── start_remedy_scribe_simple.sh  # Start script
├── requirements_remedy_scribe.txt # Python dependencies
├── pyproject.toml              # UV configuration
└── README.md                   # This file
```

### Local Development

```bash
# With hot-reload
uvicorn remedy_scribe_webapp:app --reload

# With UV
uv run uvicorn remedy_scribe_webapp:app --reload
```

### Code Formatting

```bash
# With ruff
ruff check remedy_scribe_webapp.py

# With black
black remedy_scribe_webapp.py
```

## Troubleshooting

### Server Not Reachable

Make sure the transcription server is running:

```bash
curl http://localhost:8002/health
```

### Microphone Permission

The browser requires permission for microphone access. Make sure you have granted permission.

### Port Already in Use

The app automatically searches for a free port if the default port (8003) is in use.

### CORS Errors

The web app has CORS enabled. If problems occur, check the CORS settings in the transcription server.

## License

MIT License - see [LICENSE](LICENSE) file

## Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Support

For problems or questions:
- Open an [Issue](https://github.com/riedemannai/remedy-scribe/issues)
- Contact the maintainers

## Acknowledgments

- [NVIDIA Parakeet TDT 0.6B V2](https://huggingface.co/nvidia/parakeet-tdt-0.6b-v2) - Base transcription model by NVIDIA
- [FastAPI](https://fastapi.tiangolo.com/) for the web framework
- [Uvicorn](https://www.uvicorn.org/) for the ASGI server

---

<div align="center">

**Made with ❤️ for medical professionals**

[⭐ Star on GitHub](https://github.com/riedemannai/remedy-scribe) • [📖 Documentation](#) • [🐛 Issues](https://github.com/riedemannai/remedy-scribe/issues)

</div>
