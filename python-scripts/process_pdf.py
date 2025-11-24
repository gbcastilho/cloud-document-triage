#!/usr/bin/env python3
import sys
import io
import pdfplumber
import json

try:
    # 1. Read the raw binary data from disk
    with open("/tmp/temp_file.pdf", "rb") as f:
        pdf_file_in_memory = io.BytesIO(f.read())

    all_text = ""

    # 3. Open the virtual file with pdfplumber
    with pdfplumber.open(pdf_file_in_memory) as pdf:
        # 4. Loop through pages and extract text
        for page in pdf.pages:
            page_text = page.extract_text() or ""
            all_text += page_text + "\n"

    # 5. Prepare a success JSON object
    output = {"extracted_text": all_text, "status": "extraction_success"}

except Exception as e:
    # 6. Prepare an error JSON object
    #    We print errors to stderr so N8N can log them
    print(f"Error processing PDF: {e}", file=sys.stderr)
    output = {
        "extracted_text": None,
        "status": "extraction_failed",
        "error_message": str(e),
    }

# 7. Print the final JSON to Standard Output.
#    N8N will capture this as the node's result.
print(json.dumps(output))
