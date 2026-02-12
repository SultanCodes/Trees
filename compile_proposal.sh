#!/bin/bash
# Proposal PDF Compilation Script
# This script compiles proposal.tex to proposal.pdf

echo "========================================="
echo "Proposal PDF Compilation Script"
echo "========================================="
echo ""

# Check if pdflatex is available
if command -v pdflatex &> /dev/null; then
    echo "✓ Found pdflatex"
    echo "Compiling proposal.tex..."
    pdflatex -interaction=nonstopmode proposal.tex
    if [ $? -eq 0 ]; then
        echo "✓ PDF compiled successfully!"
        echo "Generated: proposal.pdf"
    else
        echo "✗ Compilation failed. Check the log above for errors."
        exit 1
    fi

# Check if latexmk is available
elif command -v latexmk &> /dev/null; then
    echo "✓ Found latexmk"
    echo "Compiling proposal.tex..."
    latexmk -pdf -interaction=nonstopmode proposal.tex
    if [ $? -eq 0 ]; then
        echo "✓ PDF compiled successfully!"
        echo "Generated: proposal.pdf"
    else
        echo "✗ Compilation failed. Check the log above for errors."
        exit 1
    fi

# Check if Docker is available
elif command -v docker &> /dev/null; then
    echo "✓ Found Docker"
    echo "Compiling using Docker container..."
    docker run --rm -v "$(pwd):/workspace" -w /workspace texlive/texlive:latest pdflatex -interaction=nonstopmode proposal.tex
    if [ $? -eq 0 ]; then
        echo "✓ PDF compiled successfully!"
        echo "Generated: proposal.pdf"
    else
        echo "✗ Docker compilation failed."
        exit 1
    fi

# No LaTeX tools found
else
    echo "✗ No LaTeX compiler found."
    echo ""
    echo "Please install LaTeX using one of these methods:"
    echo ""
    echo "On Ubuntu/Debian:"
    echo "  sudo apt-get install texlive-latex-base texlive-latex-extra"
    echo ""
    echo "On macOS:"
    echo "  brew install --cask mactex"
    echo ""
    echo "On Windows:"
    echo "  Install MiKTeX from https://miktex.org/"
    echo ""
    echo "Or use Docker:"
    echo "  docker run --rm -v \"\$(pwd):/workspace\" -w /workspace texlive/texlive:latest pdflatex -interaction=nonstopmode proposal.tex"
    echo ""
    exit 1
fi
