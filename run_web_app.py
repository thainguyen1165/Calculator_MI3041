"""Run Numerical Calculator in the default web browser.

This launcher is more reliable for students than running Flask debug mode:
- chooses a free localhost port automatically,
- opens the browser for you,
- avoids Flask's debug reloader opening twice.
"""
from __future__ import annotations

import os
import socket
import sys
import webbrowser
from contextlib import closing

from werkzeug.serving import make_server


def find_free_port() -> int:
    with closing(socket.socket(socket.AF_INET, socket.SOCK_STREAM)) as sock:
        sock.bind(("127.0.0.1", 0))
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        return int(sock.getsockname()[1])


def main() -> int:
    app_root = os.path.abspath(os.path.dirname(__file__))
    os.chdir(app_root)
    if app_root not in sys.path:
        sys.path.insert(0, app_root)

    from app import app as flask_app

    port = find_free_port()
    url = f"http://127.0.0.1:{port}"
    server = make_server("127.0.0.1", port, flask_app)

    print("=" * 64)
    print("Numerical Calculator is running.")
    print(f"Open this address if the browser does not open automatically: {url}")
    print("Keep this window open while using the app. Press Ctrl+C to stop.")
    print("=" * 64)

    try:
        webbrowser.open(url)
    except Exception:
        pass

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nStopping server...")
    finally:
        server.shutdown()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
