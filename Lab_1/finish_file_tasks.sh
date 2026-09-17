#!/usr/bin/env bash
set -euo pipefail
LAB_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$LAB_DIR"

# Ensure directories and permissions
mkdir -p "Work/Лабораторная работа №1!" "Work/ФИО"
chmod 772 "Work/Лабораторная работа №1!" || true
chmod 700 "Work/ФИО" || true

# Create required files
: > "Work/Text @1"
: > "Work/Text $2"
: > "Work/Text #3"

# Write specified text into Text @1
cat > "Work/Text @1" <<'TEXT'
Птица говорун отличается умом и сообразительностью!
Отличается умом, отличается сообразительностью...
TEXT

# Copy/move as required
cp -f "Work/Text @1" "Work/Text $2"
mv -f "Work/Text $2" "Work/Лабораторная работа №1!/"
cp -f "Work/Text @1" "Work/ФИО/"
cp -f "Work/Text @1" "Work/ФИО/Text @1"

# Prepare Text #3: first line of Text @1, then append warning
head -n1 "Work/Text @1" > "Work/Text #3"
echo "Будь осторожен! Преступник вооружен!" >> "Work/Text #3"

# Create gz files and tar archive
gzip -c "Work/Text @1" > "Work/Text @1.gz" || true
gzip -c "Work/Text #3" > "Work/Text #3.gz" || true
tar -cf "Work/MyAchiv.tar" -C "Work" "Text @1.gz" "Text #3.gz" || true

# Create reversed Result_two in ФИО
awk '{lines[NR]=$0} END{for(i=NR;i>=1;i--) print lines[i]}' "Work/Text @1" > "Work/ФИО/Result_one"
mv -f "Work/ФИО/Result_one" "Work/ФИО/Result_two"

# Create Result_3 in Лабораторная работа №1! from files in ФИО starting with 'T'
: > "Work/Лабораторная работа №1!/Result_3"
shopt -s nullglob || true
for f in Work/ФИО/T*; do
  [ -e "$f" ] || continue
  echo "===== $(basename "$f") =====" >> "Work/Лабораторная работа №1!/Result_3"
  if [ -d "$f" ]; then ls -la "$f" >> "Work/Лабораторная работа №1!/Result_3"; else cat "$f" >> "Work/Лабораторная работа №1!/Result_3"; fi
  echo >> "Work/Лабораторная работа №1!/Result_3"
done

# Append kernel info and date
uname -a >> "Work/Лабораторная работа №1!/Result_3" || true
date >> "Work/Лабораторная работа №1!/Result_3" || true

# Ensure Work_files contains the commands (append if not present)
if ! grep -q "# Commands used for file tasks:" "Work_files" 2>/dev/null; then
  cat >> "Work_files" <<'EOF'
# Commands used for file tasks:
mkdir -p "Work/Лабораторная работа №1!" "Work/ФИО"
chmod 772 "Work/Лабораторная работа №1!"
chmod 700 "Work/ФИО"
touch "Work/Text @1" "Work/Text $2" "Work/Text #3"
cat > "Work/Text @1" <<'TEXT'
Птица говорун отличается умом и сообразительностью!
Отличается умом, отличается сообразительностью...
TEXT
cp "Work/Text @1" "Work/ФИО/"
cp "Work/Text @1" "Work/Text $2"
mv "Work/Text $2" "Work/Лабораторная работа №1!/"
head -n1 "Work/Text @1" > "Work/Text #3"
echo 'Будь осторожен! Преступник вооружен!' >> "Work/Text #3"
awk '{lines[NR]=$0} END{for(i=NR;i>=1;i--) print lines[i]}' "Work/Text @1" > "Work/ФИО/Result_one"
mv "Work/ФИО/Result_one" "Work/ФИО/Result_two"
find "Work/ФИО" -maxdepth 1 -type f -name 'T*' -exec sh -c 'echo "===== $(basename "$1") ====="; cat "$1"; echo' _ {} \; > "Work/Лабораторная работа №1!/Result_3"
uname -a >> "Work/Лабораторная работа №1!/Result_3"
date >> "Work/Лабораторная работа №1!/Result_3"
EOF
fi

# Stage and commit changes
cd "$(dirname "$LAB_DIR")"
git add Lab_1/Work Lab_1/Work_files Lab_1/sandbox/Boriskin.asm Lab_1/sandbox/Disassemble || true
if ! git diff --cached --quiet; then
  git commit -m "Finish Lab_1 file tasks: Work folder, results, update Work_files" || true
fi

# Push
git push origin main || true

echo "Finished."
