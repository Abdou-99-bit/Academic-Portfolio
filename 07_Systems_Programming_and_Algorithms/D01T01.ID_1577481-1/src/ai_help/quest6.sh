#!/bin/bash

# Quest 6: Generate main.key using keygen.sh and unifier.sh

echo "Step 1: Go to ai_help folder"
cd src/ai_help || exit 1

echo "Step 2: Run keygen.sh to generate key fragments"
bash keygen.sh

echo "Step 3: Delete all irrelevant files (keep only .key files)"
find key -type f ! -name "*.key" -delete

echo "Step 4: Run unifier.sh to create main.key"
bash unifier.sh

echo "Step 5: List the key folder to confirm main.key"
ls -l key

echo "Quest 6 complete!"
