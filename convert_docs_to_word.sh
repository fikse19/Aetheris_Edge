#!/bin/bash
set -e
if ! command -v pandoc &> /dev/null; then
    echo "❌ Error: 'pandoc' is not installed on this system."
    exit 1
fi
mkdir -p word_deliverables
for file in *.md; do
    if [ -f "$file" ]; then
        filename=$(basename -- "$file")
        name_no_ext="${filename%.*}"
        pandoc -f markdown -t docx "$file" -o "word_deliverables/${name_no_ext}.docx"
    fi
done
echo "=================================================================="
echo "✅ SUCCESS: All documentation packages converted to /word_deliverables/"
echo "=================================================================="
