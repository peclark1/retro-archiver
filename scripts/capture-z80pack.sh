#!/usr/bin/env bash
set -euo pipefail

URL='https://www.icl1900.co.uk/unix4fun/z80pack/'
TAGS='retrocomputing,z80,z80pack,emulator,cpm'

echo "Retro Archiver: first z80pack capture"
echo "URL:  ${URL}"
echo "Tags: ${TAGS}"
echo

echo "Capturing the seed page and URLs one hop away..."
docker compose run --rm archivebox add \
  --depth=1 \
  --tag "${TAGS}" \
  "${URL}"

echo
echo "ArchiveBox status:"
docker compose run --rm archivebox status || true

echo
echo "Local disk usage:"
du -sh data archive 2>/dev/null || true

echo
echo "Capture complete. Review the results in the ArchiveBox web UI."
