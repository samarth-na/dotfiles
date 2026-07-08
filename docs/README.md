# Vite React Scaffolding — Interactive Docs

Visualizations of the 9 React options shown by `bun create vite` (or `npm create vite`).

## Files

| File | Format | Best for |
|---|---|---|
| [`tree.html`](./tree.html) | Expandable/collapsible tree (vanilla JS) | Browsing the hierarchy and reading per-option notes |
| [`graph.html`](./graph.html) | Force-directed graph (vis-network) | Seeing relationships, clustering, and outliers |
| [`mermaid.md`](./mermaid.md) | Mermaid diagrams | Rendering inside GitHub, VS Code, Obsidian, etc. |
| [`comparison.md`](./comparison.md) | Comparison table | Quick side-by-side reference |

## The 9 options at a glance

**Plain React (no routing, no SSR)**
- TypeScript
- TypeScript + React Compiler
- JavaScript
- JavaScript + React Compiler

**Full-framework / SSR**
- RSC (React Server Components via Vite plugin)
- React Router v7 (rebranded Remix, framework mode)
- TanStack Router (type-safe routing)
- RedwoodSDK (Cloudflare Workers + RSC)
- Vike (formerly `vite-plugin-ssr`, flexible meta-framework)

## TL;DR

- Learning / small SPA → **TypeScript**
- Auto-memoization → **TypeScript + React Compiler**
- Server rendering without Next → **RSC**
- Remix-style data + routing → **React Router v7**
- Max type safety on routes → **TanStack Router**
- Cloudflare edge full-stack → **RedwoodSDK**
- Flexible thin Vite layer → **Vike**
