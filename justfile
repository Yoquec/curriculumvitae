build:
    pdflatex -interaction=nonstopmode cv.tex

install path:
    mkdir -p '{{path}}'
    cp cv.pdf '{{path}}/'
