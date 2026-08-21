#!/usr/bin/env bash
set -euo pipefail

URL='https://www.icl1900.co.uk/unix4fun/z80pack/'
TAGS='retrocomputing,z80,z80pack,emulator,cpm'

# ArchiveBox applies URL_ALLOWLIST to URLs discovered by recursive crawling.
# Keep this capture inside the z80pack subtree. This includes the site's own
# /ftp/ downloads, but prevents depth=1 from turning external references such
# as YouTube, GitHub, Bitsavers, etc. into archive jobs of their own.
URL_ALLOWLIST='^https?://(www\.)?icl1900\.co\.uk/unix4fun/z80pack(?:/|$)'

if docker info >/dev/null 2>&1; then
  DC=(docker compose)
else
  DC=(sudo docker compose)
fi

echo "Retro Archiver: z80pack capture"
echo "URL:       ${URL}"
echo "Tags:      ${TAGS}"
echo "Crawl:     depth=1"
echo "Scope:     z80pack subtree only"
echo "Allowlist: ${URL_ALLOWLIST}"
echo

echo "Capturing the z80pack page and same-subtree URLs one hop away..."
"${DC[@]}" run --rm \
  -e URL_ALLOWLIST="${URL_ALLOWLIST}" \
  archivebox add \
  --depth=1 \
  --tag "${TAGS}" \
  "${URL}"

echo
echo "ArchiveBox status:"
"${DC[@]}" run --rm archivebox status || true

echo
echo "Local disk usage:"
du -sh data archive 2>/dev/null || true

echo
echo "Capture complete. Review the results in the ArchiveBox web UI."
