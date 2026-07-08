# Backend Engineering & Database Scaling — HTML Deck

A single-file Reveal.js presentation covering backend engineering and database scaling concepts from the original summary document.

## Files

- `backend-engineering-deck.html` — the full presentation
- `README.md` — this file

## How to view

Open `backend-engineering-deck.html` in any modern web browser.

```bash
# macOS
open backend-engineering-deck.html

# Linux
xdg-open backend-engineering-deck.html
```

## Navigation

- **Arrow keys** / **Space** — move between slides
- **O** — overview mode
- **F** — fullscreen
- **Esc** — exit fullscreen or overview

## Themes

Click the **Light/Dark** toggle in the top-right corner. Your preference is saved in local storage.

## Print to PDF

Append `?print-pdf` to the file URL and print to PDF in your browser.

```
file:///tmp/opencode/backend-engineering-deck.html?print-pdf
```

For best results, use Chrome and set the page size to match the slide aspect ratio (16:9).

## Offline use

The deck loads Reveal.js, highlight.js, and fonts from CDN. To use it fully offline, download those assets and update the `<script>` and `<link>` tags.

## Slide count

67 slides organized into:

1. Introduction & big picture
2. Storage hierarchy and database internals
3. Indexes, query planners, B-trees
4. Transactions, locks, MVCC
5. Sharding and replication
6. Caching, Redis, queues, load balancing
7. Networking, auth, Docker, Kubernetes
8. Learning roadmap, books, tools, projects
9. Mental models, mistakes, summary
