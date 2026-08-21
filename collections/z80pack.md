# z80pack

## Source

- Seed URL: https://www.icl1900.co.uk/unix4fun/z80pack/
- Initial archive target date: 2026-08-21

## Why this resource matters

z80pack is being evaluated as a possible development/emulation environment for a real S-100/IMSAI target system. The particular interest is whether it can be customized closely enough to reproduce the target machine's ROM and memory map, I/O port addresses, console devices, serial devices, disk controllers, and IDE/CF storage so software can be developed and tested in emulation before being run on the physical hardware.

The original web page is valuable not only for the software itself, but because it provides historical context and links to source distributions, documentation, related projects, screenshots, disk/software resources, and other references.

## Initial capture strategy

For the first proof of concept:

- Archive the seed page.
- Follow links one hop away (`depth=1`).
- Restrict recursive capture to the `icl1900.co.uk/unix4fun/z80pack/` subtree.
- This scope includes the site's own `/unix4fun/z80pack/ftp/` download area.
- External references such as YouTube, GitHub, Bitsavers, SourceForge, etc. remain links/context but are not automatically turned into archive jobs.
- Cap the crawl at 250 URLs.
- Keep the first capture on local SIMH storage.
- Preserve normal web pages with ArchiveBox's full page-oriented extractor set.
- Preserve recognized downloadable artifacts primarily as original bytes via wget plus HTTP headers/WARC; skip page rendering extractors for those file URLs.
- Preserve z80pack `/ftp/` directory indexes as lightweight HTML context: keep headers, wget/WARC, title and local text extraction, but skip repeated browser rendering, media, git, favicon and archive.org work.

## First-run observations

### External crawl scope

The original unrestricted `depth=1` test immediately demonstrated why crawl scope matters: ArchiveBox discovered an external YouTube channel link and began running its normal extractors against that page. The SingleFile extractor timed out after 60 seconds while rendering the YouTube channel. This was not a failure of the z80pack site itself; it showed that following all external links one hop away is too broad for the intended Retro Archiver workflow.

The capture script was therefore changed to pass an ArchiveBox `URL_ALLOWLIST` regex that limits recursive URLs to the z80pack subtree while preserving external links in the archived source page for later review or separate collection handling.

### Downloadable artifacts are not pages

The scoped retry reached `https://www.icl1900.co.uk/unix4fun/z80pack/ftp/zsdos.tgz`. ArchiveBox correctly discovered the file, but then ran page-oriented extractors against it. SingleFile failed and the PDF extractor timed out after 60 seconds because a `.tgz` archive is not a renderable page.

This established a second collection rule: direct downloadable artifacts should not receive the same extraction pipeline as HTML pages. Retro Archiver now uses ArchiveBox's per-URL `SAVE_DENYLIST` to skip page/browser extractors for common archive, disk-image, ROM/binary, ISO, and PDF extensions. The `headers` and `wget` extractors remain enabled; wget also writes the WARC record when WARC capture is enabled.

The extension list is intentionally conservative and will be expanded only as real collections expose additional formats.

### FTP directory indexes are context, not rich pages

A later retry reached a directory listing such as `https://www.icl1900.co.uk/unix4fun/z80pack/ftp/source-examples/plm80/`. Because the URL ends in `/` rather than a recognized file extension, ArchiveBox treated it as a normal page and attempted SingleFile/PDF/browser rendering. Those extractors are unnecessary for a simple directory index and can create avoidable timeout delays and additional requests to the source site.

Retro Archiver therefore treats z80pack `/ftp/` directory URLs ending in `/` as a lightweight page class. The listing HTML and link context are still preserved through headers and wget/WARC, and local title/text extraction remains available, but browser-oriented extractors are skipped. This reduces both capture time and load on the source site while retaining the historically useful directory structure.

## Tags

`retrocomputing`, `z80`, `z80pack`, `emulator`, `cpm`

## Questions to answer from the first clean capture

1. Does the archived z80pack page replay well enough to navigate naturally?
2. Are downloadable archives such as `zsdos.tgz` preserved intact and accessible from the archive?
3. Which external links are useful enough that they should become separate archive collections?
4. Does the wget/WARC/browser combination give enough redundancy for long-term preservation?
5. How much storage does a representative retrocomputing resource collection consume?
6. What information is missing that would help explain years later why the collection was saved?

## Future enhancements suggested by this collection

- Detect and mirror linked Git repositories.
- Create checksums/manifests for preserved downloads.
- Produce a capture report listing downloaded files, failed URLs, external links, and storage usage.
- Add a richer project/notes layer on top of ArchiveBox metadata.
- Decide whether WACZ/ReplayWeb.page or Browsertrix adds useful preservation fidelity for sites of this type.
