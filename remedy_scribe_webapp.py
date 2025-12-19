#!/usr/bin/env python3
"""
Remedy Scribe Web-App
Eine eigenständige Web-App für medizinische Spracherkennung.
Läuft mit UV-Server (uvicorn).
"""

from fastapi import FastAPI, Request, HTTPException
from fastapi.responses import HTMLResponse, FileResponse
from fastapi.staticfiles import StaticFiles
from fastapi.middleware.cors import CORSMiddleware
import os
import logging
from pathlib import Path
from fastapi.responses import Response

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Initialize FastAPI app
app = FastAPI(
    title="Remedy Scribe",
    description="Medizinische Spracherkennung für klinische Dokumentation",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Get the directory where this script is located
BASE_DIR = Path(__file__).parent

@app.get("/", response_class=HTMLResponse)
async def root():
    """Serve the main HTML page."""
    html_file = BASE_DIR / "test_transcription.html"
    
    if not html_file.exists():
        raise HTTPException(status_code=404, detail="HTML file not found")
    
    with open(html_file, "r", encoding="utf-8") as f:
        html_content = f.read()
    
    return HTMLResponse(content=html_content)

@app.get("/health")
async def health():
    """Health check endpoint."""
    return {"status": "ok", "service": "Remedy Scribe"}

@app.get("/favicon.svg")
async def favicon_svg():
    """Serve the SVG favicon."""
    favicon_path = BASE_DIR / "favicon.svg"
    if favicon_path.exists():
        with open(favicon_path, "r", encoding="utf-8") as f:
            return Response(content=f.read(), media_type="image/svg+xml")
    raise HTTPException(status_code=404, detail="Favicon not found")

@app.get("/favicon.png")
async def favicon_png():
    """Serve the PNG favicon (fallback)."""
    favicon_path = BASE_DIR / "favicon.png"
    if favicon_path.exists():
        with open(favicon_path, "rb") as f:
            return Response(content=f.read(), media_type="image/png")
    # Fallback to SVG if PNG doesn't exist
    favicon_svg_path = BASE_DIR / "favicon.svg"
    if favicon_svg_path.exists():
        with open(favicon_svg_path, "r", encoding="utf-8") as f:
            return Response(content=f.read(), media_type="image/svg+xml")
    raise HTTPException(status_code=404, detail="Favicon not found")

@app.get("/favicon.ico")
async def favicon_ico():
    """Serve the ICO favicon (legacy browsers)."""
    # Redirect to SVG for modern browsers, or serve SVG as ICO alternative
    favicon_path = BASE_DIR / "favicon.svg"
    if favicon_path.exists():
        with open(favicon_path, "r", encoding="utf-8") as f:
            return Response(content=f.read(), media_type="image/svg+xml")
    raise HTTPException(status_code=404, detail="Favicon not found")

if __name__ == "__main__":
    import uvicorn
    import socket
    
    # Get port from environment variable or default to 8003
    port = int(os.getenv("PORT", 8003))
    host = os.getenv("HOST", "0.0.0.0")
    
    # Check if port is available
    def is_port_available(port, host="0.0.0.0"):
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            try:
                s.bind((host, port))
                return True
            except OSError:
                return False
    
    # Check if the specified port is available
    # Only use alternative port if PORT was not explicitly set (using default)
    port_explicitly_set = "PORT" in os.environ
    original_port = port
    
    if not is_port_available(port, host):
        if port_explicitly_set:
            # If PORT was explicitly set, fail instead of using alternative
            logger.error(f"Port {port} is already in use. Please free up port {port} or specify a different PORT.")
            exit(1)
        else:
            # Only use alternative if using default port
            logger.warning(f"Port {port} is already in use, trying alternative ports...")
            for alt_port in range(port + 1, port + 10):
                if is_port_available(alt_port, host):
                    port = alt_port
                    logger.info(f"Using alternative port: {port}")
                    break
            else:
                logger.error(f"Could not find an available port. Please free up port {original_port} or specify a different PORT.")
                exit(1)
    
    logger.info(f"Starting Remedy Scribe Web-App on {host}:{port}")
    logger.info(f"Open your browser at http://localhost:{port}")
    
    uvicorn.run(
        app,
        host=host,
        port=port,
        log_level="info"
    )

