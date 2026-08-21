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
- Cap the crawl at 250 URLs.
- Use ArchiveBox's normal enabled extractors rather than customizing the extraction pipeline yet.
- Keep the first capture on local SIMH storage.
- Review exactly what ArchiveBox preserved before deciding whether to add special handling for downloads, Git repositories, or external sites.

## Tags

`retrocomputing`, `z80`, `z80pack`, `emulator`, `cpm`

## Questions to answer from the first capture

1. Does the archived z80pack page replay well enough to navigate naturally?
2. Which downloadable archives and documentation files are captured automatically?
3. Which external links are useful enough that they should become separate archive collections?
4. Does the default wget/WARC/browser output give enough redundancy for long-term preservation?
5. How much storage does a representative retrocomputing resource collection consume?
6. What information is missing that would help explain years later why the collection was saved?

## Future enhancements suggested by this collection

Do not implement these until the first capture is reviewed:

- Detect and mirror linked Git repositories.
- Create checksums/manifests for preserved downloads.
- Produce a capture report listing downloaded files, failed URLs, external links, and storage usage.
- Add a richer project/notes layer on top of ArchiveBox metadata.
- Decide whether WACZ/ReplayWeb.page or Browsertrix adds useful preservation fidelity for sites of this type.
