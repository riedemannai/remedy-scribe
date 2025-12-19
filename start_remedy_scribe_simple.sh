#!/bin/bash
# Einfaches Start-Skript für Remedy Scribe Web-App mit UV

set -e

PORT=${PORT:-8003}
HOST=${HOST:-0.0.0.0}

echo "🚀 Starte Remedy Scribe Web-App..."
echo "📡 Port: $PORT"
echo "🌐 Öffnen Sie: http://localhost:$PORT"
echo ""

# Mit UV: Installiere Abhängigkeiten und starte direkt
if command -v uv &> /dev/null; then
    uv pip install --system fastapi "uvicorn[standard]" 2>/dev/null || uv pip install fastapi "uvicorn[standard]"
    uv run --no-project python remedy_scribe_webapp.py
else
    # Fallback
    pip install -q fastapi "uvicorn[standard]" 2>/dev/null || true
    python remedy_scribe_webapp.py
fi

