#!/usr/bin/env python
"""Simple static file server to serve ./site on http://127.0.0.1:8000

Usage: python site/serve_site.py
"""
import http.server
import socketserver
import webbrowser
import os

PORT = 8000

def main():
    this_dir = os.path.dirname(__file__)
    os.chdir(this_dir)
    handler = http.server.SimpleHTTPRequestHandler
    with socketserver.TCPServer(("", PORT), handler) as httpd:
        url = f"http://127.0.0.1:{PORT}"
        print(f"Serving {this_dir} at {url}")
        try:
            webbrowser.open(url)
        except Exception:
            pass
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("Stopping server")

if __name__ == '__main__':
    main()
