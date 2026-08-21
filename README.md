# Retro Archiver

A self-hosted preservation system for retrocomputing web resources.

The goal is not merely to save bookmarks or download files. Retro Archiver should preserve enough of a web resource that it can still be understood and used years later if the original site changes or disappears.

The project starts as a thin, reproducible layer around [ArchiveBox](https://archivebox.io/) and standard archival formats/tools. We will add retrocomputing-specific behavior only where it proves useful.

## First use case

Our first real capture is the z80pack site:

- https://www.icl1900.co.uk/unix4fun/z80pack/

This is a good test because the page is both a useful historical resource and a map to documentation, downloads, source code, screenshots, and external references.

## Design principles

1. **Preserve context, not just bytes.** Keep the original URL, capture time, tags, notes, and enough surrounding pages to remember why a resource mattered.
2. **Prefer durable/open formats.** Archived material should remain useful even if Retro Archiver or ArchiveBox is no longer available.
3. **Keep the first version small.** Use ArchiveBox's existing capture, metadata, WARC, wget, screenshot, and browser tooling before writing custom crawlers.
4. **Separate metadata from bulk storage.** ArchiveBox's database/config will eventually live on the SIMH host's local disk; large archived payloads will live on TrueNAS/ZFS.
5. **Do not crawl the Internet indiscriminately.** Captures need explicit depth and size limits, with source-specific strategies later for sites such as Bitsavers.
6. **GitHub is the source of truth for this project's code and configuration.** Archived third-party content itself does not belong in this repository.

## Phase 1: local proof of concept

For the first test, keep *all* ArchiveBox data local on the SIMH Ubuntu host. This deliberately avoids mixing crawler/debugging issues with NFS permissions or network-storage behavior.

### Requirements

- Linux host
- Docker Engine
- Docker Compose v2 (`docker compose`)
- Enough temporary local disk space for the first capture

### Setup

```bash
git clone https://github.com/peclark1/retro-archiver.git
cd retro-archiver

cp .env.example .env
mkdir -p data archive

docker compose pull
docker compose run --rm archivebox init
docker compose run --rm archivebox install
docker compose run --rm archivebox manage createsuperuser
docker compose up -d
```

Then run the first capture:

```bash
bash scripts/capture-z80pack.sh
```

The ArchiveBox web interface is exposed on port 8000 by default.

### What we evaluate after the first capture

- Did the z80pack pages render acceptably from the archive?
- Which linked downloads were preserved automatically?
- Did ArchiveBox save useful WARC/wget/browser artifacts?
- Which external links should have been captured, ignored, or treated specially?
- Does the ArchiveBox metadata/tagging model give us enough context for future retrieval?
- How much disk space did this one collection consume?

We should answer those questions before adding custom code.

## Phase 2: TrueNAS bulk storage

After the local proof of concept works, only the bulky ArchiveBox `data/archive/` tree will move to a TrueNAS-backed mount. The SQLite database, configuration, logs, and other operational files stay on the SIMH host's local filesystem.

The compose file already supports this split through `ARCHIVE_ROOT`. For example, after mounting a TrueNAS dataset at `/mnt/retro-archive` on the SIMH host:

```bash
ARCHIVE_ROOT=/mnt/retro-archive/archivebox/archive
```

would be placed in `.env`.

Before switching storage, we will define the TrueNAS dataset, NFS permissions, ownership, ZFS snapshot policy, and backup policy explicitly.

## Later ideas

Once the basic preservation workflow is proven, likely enhancements include:

- "Why I saved this" notes and project associations
- retrocomputing tags and collections
- capture reports showing downloads, failures, external links, and checksums
- Git repository detection and mirroring
- source-specific handlers (for example rsync-based Bitsavers preservation)
- SHA-256 manifests
- WARC/WACZ replay integration
- Browsertrix for difficult JavaScript-heavy sites
- scheduled re-captures and change reporting
- full-text search across saved documentation and notes

The intent is to add these incrementally based on actual archived sites rather than design them all up front.
