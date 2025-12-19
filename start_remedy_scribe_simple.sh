#!/bin/bash
# Einfaches Start-Skript für Remedy Scribe Web-App mit UV

set -e

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -p|--port)
            PORT="$2"
            export PORT
            shift 2
            ;;
        -h|--host)
            HOST="$2"
            export HOST
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            echo "Usage: $0 [-p|--port PORT] [-h|--host HOST]"
            exit 1
            ;;
    esac
done

# Set defaults if not provided
PORT=${PORT:-8003}
HOST=${HOST:-0.0.0.0}

echo "🚀 Starte Remedy Scribe Web-App..."
echo "📡 Port: $PORT"
echo "🌐 Öffnen Sie: http://localhost:$PORT"
echo ""

# Mit UV: Installiere Abhängigkeiten und starte direkt
if command -v uv &> /dev/null; then
    uv pip install --system fastapi "uvicorn[standard]" 2>/dev/null || uv pip install fastapi "uvicorn[standard]"
    PORT=$PORT uv run --no-project python remedy_scribe_webapp.py
else
    # Fallback
    pip install -q fastapi "uvicorn[standard]" 2>/dev/null || true
    PORT=$PORT python remedy_scribe_webapp.py
fi

