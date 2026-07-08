"""
Desktop wrapper for Numerical Calculator.
Chạy app Flask trong nền và mở giao diện bằng cửa sổ desktop pywebview.
"""
import os
import socket
import sys
import threading
from contextlib import closing

import webview
from werkzeug.serving import make_server


def resource_path(relative_path: str) -> str:
    """Return absolute path both in source mode and PyInstaller frozen mode."""
    base_path = getattr(sys, "_MEIPASS", os.path.abspath(os.path.dirname(__file__)))
    return os.path.join(base_path, relative_path)


def find_free_port() -> int:
    """Find an available localhost port."""
    with closing(socket.socket(socket.AF_INET, socket.SOCK_STREAM)) as sock:
        sock.bind(("127.0.0.1", 0))
        sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        return sock.getsockname()[1]


class FlaskServerThread(threading.Thread):
    def __init__(self, flask_app, port: int):
        super().__init__(daemon=True)
        self.server = make_server("127.0.0.1", port, flask_app)
        self.context = flask_app.app_context()
        self.context.push()

    def run(self):
        self.server.serve_forever()

    def shutdown(self):
        self.server.shutdown()


def main():
    # Ensure relative template/static paths work correctly after packaging.
    app_root = resource_path(".")
    os.chdir(app_root)
    if app_root not in sys.path:
        sys.path.insert(0, app_root)

    from app import app as flask_app

    port = find_free_port()
    server_thread = FlaskServerThread(flask_app, port)
    server_thread.start()

    url = f"http://127.0.0.1:{port}"
    window = webview.create_window(
        "Numerical Calculator",
        url,
        width=1280,
        height=820,
        min_size=(1000, 700),
    )

    try:
        webview.start(debug=False)
    finally:
        server_thread.shutdown()


if __name__ == "__main__":
    main()
