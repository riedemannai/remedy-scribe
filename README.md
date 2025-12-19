# RemedyScribe

<div align="center">

![RemedyScribe Logo](favicon.svg)

**Medizinische Spracherkennung für klinische Dokumentation**

[Features](#features) • [Installation](#installation) • [Verwendung](#verwendung) • [Technologie](#technologie)

</div>

---

## Über RemedyScribe

RemedyScribe ist eine moderne Web-App für medizinische Spracherkennung, speziell optimiert für die klinische Dokumentation. Die App ermöglicht es medizinischem Personal, Audio-Aufnahmen direkt im Browser zu erstellen und diese automatisch in Text zu transkribieren.

## Features

- 🎙️ **Audio-Aufnahme direkt im Browser** - Keine zusätzliche Software erforderlich
- 📝 **Automatische Transkription** - Nutzt Parakeet-MLX für präzise Transkription
- 💾 **Gesamttext-Anzeige** - Alle Transkriptionen werden zusammengeführt
- ✏️ **Textbearbeitung** - Direkte Bearbeitung im Browser
- 📋 **Kopieren-Funktion** - Ein-Klick Kopieren in die Zwischenablage
- 🗑️ **Löschen-Funktion** - Schnelles Zurücksetzen
- ⏱️ **Aufnahme-Timer** - Zeigt die Aufnahmezeit an
- 🎨 **Moderne UI** - Benutzerfreundliche, professionelle Oberfläche
- 🏥 **Medizinisches Design** - Optimiert für klinische Umgebungen

## Screenshots

![RemedyScribe Interface](https://via.placeholder.com/800x400/00d4aa/ffffff?text=RemedyScribe+Interface)

## Installation

### Voraussetzungen

- Python 3.10 oder höher
- UV (Python Package Manager) - optional, aber empfohlen
- Ein laufender Transkriptions-Server (z.B. [Parakeet-MLX Server](https://github.com/mlx-community/parakeet))

### Schnellstart

```bash
# 1. Repository klonen
git clone https://github.com/USERNAME/remedy-scribe.git
cd remedy-scribe

# 2. Abhängigkeiten installieren
pip install -r requirements_remedy_scribe.txt

# 3. Web-App starten
./start_remedy_scribe_simple.sh
```

### Mit UV (empfohlen)

```bash
# 1. Repository klonen
git clone https://github.com/USERNAME/remedy-scribe.git
cd remedy-scribe

# 2. Mit UV installieren und starten
uv pip install fastapi "uvicorn[standard]"
uv run --no-project python remedy_scribe_webapp.py
```

## Verwendung

### 1. Transkriptions-Server starten

Zuerst muss ein Transkriptions-Server laufen:

```bash
# Beispiel: Parakeet-MLX Server
python parakeet_server.py --port 8002
```

### 2. RemedyScribe Web-App starten

```bash
# Einfachste Methode
./start_remedy_scribe_simple.sh

# Oder direkt
python remedy_scribe_webapp.py
```

### 3. Browser öffnen

Öffnen Sie Ihren Browser und navigieren Sie zu:

```
http://localhost:8003
```

### Workflow

1. **Aufnahme starten**: Klicken Sie auf "Aufnahme starten"
2. **Sprechen**: Sprechen Sie in das Mikrofon
3. **Aufnahme stoppen**: Klicken Sie auf "Stoppen"
4. **Transkription**: Die Aufnahme wird automatisch transkribiert
5. **Text bearbeiten**: Bearbeiten Sie den Text direkt im Textfeld
6. **Kopieren**: Verwenden Sie die Kopieren-Schaltfläche
7. **Löschen**: Setzen Sie alles mit der Löschen-Schaltfläche zurück

## Technologie

### Frontend
- **HTML5** mit modernem CSS
- **JavaScript** (MediaRecorder API)
- **Responsive Design** für Desktop und Mobile

### Backend
- **FastAPI** - Moderne Python Web-Framework
- **Uvicorn** - ASGI Server
- **Python 3.10+**

### Audio-Verarbeitung
- **Format**: WAV (16kHz, Mono)
- **Codec**: Opus (Browser) → WAV (Server)

### Transkriptions-API
- **Kompatibilität**: OpenAI-kompatible API
- **Endpoint**: `/v1/audio/transcriptions`
- **Model**: Parakeet-TDT-0.6B-V3 (Standard)

## Konfiguration

### Port ändern

```bash
# Über Umgebungsvariable
PORT=8080 python remedy_scribe_webapp.py

# Oder in der Kommandozeile
uvicorn remedy_scribe_webapp:app --port 8080
```

### Server-URL ändern

Die Server-URL für die Transkription kann in `test_transcription.html` angepasst werden:

```javascript
const serverUrlInput = document.getElementById('server-url');
// Standard: http://localhost:8002
```

## Entwicklung

### Projekt-Struktur

```
remedy-scribe/
├── remedy_scribe_webapp.py    # FastAPI Backend
├── test_transcription.html     # Frontend HTML
├── favicon.svg                 # SVG Favicon
├── favicon.png                 # PNG Favicon
├── start_remedy_scribe_simple.sh  # Start-Skript
├── requirements_remedy_scribe.txt # Python Abhängigkeiten
├── pyproject.toml              # UV Konfiguration
└── README.md                   # Diese Datei
```

### Lokale Entwicklung

```bash
# Mit Hot-Reload
uvicorn remedy_scribe_webapp:app --reload

# Mit UV
uv run uvicorn remedy_scribe_webapp:app --reload
```

### Code-Formatierung

```bash
# Mit ruff
ruff check remedy_scribe_webapp.py

# Mit black
black remedy_scribe_webapp.py
```

## Fehlerbehebung

### Server nicht erreichbar

Stellen Sie sicher, dass der Transkriptions-Server läuft:

```bash
curl http://localhost:8002/health
```

### Mikrofon-Berechtigung

Der Browser benötigt Berechtigung für den Mikrofonzugriff. Stellen Sie sicher, dass Sie die Berechtigung erteilt haben.

### Port bereits belegt

Die App sucht automatisch nach einem freien Port, wenn der Standard-Port (8003) belegt ist.

### CORS-Fehler

Die Web-App hat CORS aktiviert. Falls Probleme auftreten, überprüfen Sie die CORS-Einstellungen im Transkriptions-Server.

## Lizenz

[Lizenz hier einfügen - z.B. MIT, Apache 2.0, etc.]

## Beitragen

Beiträge sind willkommen! Bitte:

1. Forken Sie das Repository
2. Erstellen Sie einen Feature-Branch (`git checkout -b feature/AmazingFeature`)
3. Committen Sie Ihre Änderungen (`git commit -m 'Add some AmazingFeature'`)
4. Pushen Sie zum Branch (`git push origin feature/AmazingFeature`)
5. Öffnen Sie einen Pull Request

## Support

Bei Problemen oder Fragen:
- Öffnen Sie ein [Issue](https://github.com/USERNAME/remedy-scribe/issues)
- Kontaktieren Sie die Maintainer

## Danksagungen

- [Parakeet-MLX](https://github.com/mlx-community/parakeet) für die Transkriptions-Engine
- [FastAPI](https://fastapi.tiangolo.com/) für das Web-Framework
- [Uvicorn](https://www.uvicorn.org/) für den ASGI Server

---

<div align="center">

**Made with ❤️ for medical professionals**

[⭐ Star auf GitHub](https://github.com/USERNAME/remedy-scribe) • [📖 Dokumentation](#) • [🐛 Issues](https://github.com/USERNAME/remedy-scribe/issues)

</div>

