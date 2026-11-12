#!/usr/bin/env bash
# Gera os MP4 em 1080p para web a partir dos masters.
# Uso: ./encode.sh "/caminho/para/a/pasta/Reel" ./filmes
# Requer ffmpeg instalado (brew install ffmpeg).
set -euo pipefail

SRC="${1:?Informe a pasta com os masters}"
OUT="${2:-./filmes}"
mkdir -p "$OUT"

# slug do site|arquivo master
LISTA=(
  "alvarez-marsal|Alvarez & Marsal.mp4"
  "google-black-friday-2024|Google Black Friday (videocase)_v07.mp4"
  "chilli-beans|chili beans - 30s.mp4"
  "bourbon-resort|Bourbon_60s_POST02_1004.mp4"
  "accenture-telefonica|ACCENTURE-TELEFONICA-V3_002.mp4"
  "accenture-renew|ACCENTURE_RENEW_RESOURCES_02_FullHD.mp4"
  "youtube-brandcast|YOUTUBE BRANCAST MEMORIA VS2.mp4"
  "wellhub|Cópia de Wellhub_full_(no lower thirds).mp4"
)

for item in "${LISTA[@]}"; do
  slug="${item%%|*}"
  master="${item#*|}"
  in="$SRC/$master"
  out="$OUT/$slug.mp4"
  if [[ ! -f "$in" ]]; then
    echo "NÃO ENCONTRADO: $in" >&2
    continue
  fi
  echo ">> $slug"
  ffmpeg -y -v warning -i "$in" \
    -vf "scale=1920:1080:flags=lanczos:force_original_aspect_ratio=decrease,pad=1920:1080:(ow-iw)/2:(oh-ih)/2:black,setsar=1" \
    -c:v libx264 -preset slow -crf 21 -maxrate 10M -bufsize 20M \
    -profile:v high -level 4.2 -pix_fmt yuv420p -r 25 \
    -c:a aac -b:a 192k -ac 2 \
    -movflags +faststart \
    "$out"
  echo "   $(du -h "$out" | cut -f1)  $out"
done
echo "Pronto. Confira a duração de cada arquivo com ffprobe antes de subir."
