FROM n8nio/n8n:1.119.0

USER root

RUN apk add --update python3 py3-pip

RUN pip3 install pdfplumber --break-system-package

USER node
