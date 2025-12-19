#!/bin/bash
# Start-Skript für Remedy Scribe Web-App mit UV

set -e

# Farben für Ausgabe
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Remedy Scribe Web-App - Start-Skript              ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Prüfe ob UV installiert ist
if ! command -v uv &> /dev/null; then
    echo -e "${YELLOW}⚠️  UV ist nicht installiert.${NC}"
    echo "Installiere UV..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    echo ""
fi

# Prüfe ob Python installiert ist
if ! command -v python3 &> /dev/null; then
    echo -e "${YELLOW}⚠️  Python 3 ist nicht installiert.${NC}"
    exit 1
fi

# Port aus Umgebungsvariable oder Standard
PORT=${PORT:-8003}
HOST=${HOST:-0.0.0.0}

echo -e "${GREEN}✓${NC} Starte Remedy Scribe Web-App..."
echo -e "${GREEN}✓${NC} Port: ${PORT}"
echo -e "${GREEN}✓${NC} Host: ${HOST}"
echo ""
echo -e "${BLUE}Öffnen Sie Ihren Browser unter:${NC}"
echo -e "${GREEN}   http://localhost:${PORT}${NC}"
echo ""
echo -e "${YELLOW}Hinweis:${NC} Stellen Sie sicher, dass der Transkriptions-Server läuft!"
echo -e "${YELLOW}         (z.B. python parakeet_server.py --port 8002)${NC}"
echo ""
echo "─────────────────────────────────────────────────────────────"
echo ""

# Starte die Web-App mit UV
if command -v uv &> /dev/null; then
    # Installiere Abhängigkeiten in virtuellem Environment
    if [ ! -d ".venv" ]; then
        echo -e "${BLUE}Erstelle virtuelles Environment...${NC}"
        uv venv
    fi
    
    echo -e "${BLUE}Installiere Abhängigkeiten...${NC}"
    uv pip install -r requirements_remedy_scribe.txt
    
    echo -e "${GREEN}Starte Web-App...${NC}"
    source .venv/bin/activate
    uvicorn remedy_scribe_webapp:app --host "$HOST" --port "$PORT" --reload
else
    # Fallback zu Python direkt
    echo -e "${YELLOW}UV nicht gefunden, verwende Python direkt...${NC}"
    python3 -m pip install -q -r requirements_remedy_scribe.txt 2>/dev/null || true
    python3 -m uvicorn remedy_scribe_webapp:app --host "$HOST" --port "$PORT" --reload
fi

