#!/bin/bash

# Quick Server Start Script for Standalone Build
# This will start a local server so you can view the app

PORT=9000
DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🚀 Starting local server..."
echo "📁 Serving: $DIR"
echo "🌐 Open in browser: http://localhost:$PORT"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

cd "$DIR"
python3 -m http.server $PORT
