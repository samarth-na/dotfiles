# Vite React Scaffolding — Comparison

Quick side-by-side reference for the 9 options shown by `bun create vite` / `npm create vite`.

## Capability matrix

Legend: ✅ built in · ❌ not included · 🟡 bring your own · ⚗️ experimental

| Option | TypeScript | React Compiler | Routing | SSR | RSC | Data loading | Pick this if… |
|---|:---:|:---:|:---:|:---:|:---:|:---:|---|
| **TypeScript** | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | Learning / small SPA |
| **TypeScript + React Compiler** | ✅ | ⚗️ | ❌ | ❌ | ❌ | ❌ | You want auto-memoization |
| **JavaScript** | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | You're not using TypeScript |
| **JavaScript + React Compiler** | ❌ | ⚗️ | ❌ | ❌ | ❌ | ❌ | JS + auto-memo |
| **RSC** | ✅ | ❌ | ❌ | ✅ | ✅ | ✅ | Server rendering without Next |
| **React Router v7** | ✅ | ❌ | ✅ | ✅ | ❌ | ✅ | Remix-style data + routing |
| **TanStack Router** | ✅ | ❌ | ✅ | ✅ | ❌ | ✅ | Max type safety on routes |
| **RedwoodSDK** | ✅ | ❌ | ✅ | ✅ | ✅ | ✅ | Cloudflare Workers full-stack |
| **Vike** | ✅ | ❌ | 🟡 | ✅ | ❌ | 🟡 | Thin customizable Vite layer |

## At a glance

**Plain React (SPA, no routing, no SSR)**
These four are the same thing with knobs turned on/off. Pick by language and whether you want the experimental compiler.

- **TypeScript** — default modern stack: React 19 + Vite + TS.
- **TypeScript + React Compiler** — adds Meta's build-time auto-memoizer. Stop writing `useMemo` / `useCallback` / `React.memo`.
- **JavaScript** — same as the TS template but JS + JSDoc.
- **JavaScript + React Compiler** — JS + compiler.

**Full-framework / SSR**
All of these add routing, server rendering, and (usually) a data layer on top of Vite. The differences are mostly about opinion.

- **RSC** — official Vite plugin for React Server Components. Closest to "Next.js-lite". Server-renders parts of the tree without Next.
- **React Router v7** — the rebrand of Remix. File-based routes, `loader`/`action`, nested layouts, SSR. Framework mode.
- **TanStack Router** — type-safe router. Route params, search params, and loaders are all type-checked from one source of truth.
- **RedwoodSDK** — full-stack React on Cloudflare Workers + RSC. Successor in spirit to RedwoodJS, for the edge.
- **Vike** — formerly `vite-plugin-ssr`. Flexible meta-framework. You pick the router, data layer, and SSR strategy.

## Decision cheat sheet

| You want… | Pick |
|---|---|
| The simplest thing that works | **TypeScript** |
| Free memoization | **TypeScript + React Compiler** |
| No TypeScript | **JavaScript** *(or JS + Compiler)* |
| Server rendering, no Next | **RSC** |
| Remix-style data + routes | **React Router v7** |
| Type-safe routes & search params | **TanStack Router** |
| Cloudflare edge full-stack | **RedwoodSDK** |
| Thin Vite layer, bring your own | **Vike** |

## Where each shines

| Option | Strength | Tradeoff |
|---|---|---|
| TypeScript | Zero opinions, zero magic | You wire everything (router, data, SSR) yourself |
| TS + Compiler | Less manual memoization | Compiler is still stabilizing; not all libs play nice yet |
| RSC | Real server rendering without Next | Newer mental model; ecosystem still settling |
| React Router v7 | Battle-tested data/routing patterns | You adopt the Remix model (loaders, actions, nested routes) |
| TanStack Router | Best-in-class type inference | Steeper learning curve; smaller community than RR |
| RedwoodSDK | Deploys to the edge with RSC | Tied to Cloudflare; smaller community |
| Vike | Maximum flexibility | You assemble the pieces yourself |
