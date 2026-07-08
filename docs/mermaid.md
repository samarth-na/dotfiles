# Vite React Scaffolding — Mermaid Diagrams

Renders in GitHub, VS Code (with Mermaid extension), Obsidian, and any other Mermaid-aware viewer.

## Hierarchy

```mermaid
graph TD
    Root["Vite React Scaffolding<br/>9 options"]
    Root --> Plain["Plain React<br/>(SPA, no routing, no SSR)"]
    Root --> Full["Full-framework / SSR"]

    Plain --> TS["TypeScript<br/><i>Learning / small SPA</i>"]
    Plain --> TSC["TypeScript + React Compiler<br/><i>Auto-memoization</i>"]
    Plain --> JS["JavaScript<br/><i>No TypeScript</i>"]
    Plain --> JSC["JavaScript + React Compiler<br/><i>JS + auto-memo</i>"]

    Full --> RSC["RSC<br/><i>Server rendering without Next</i>"]
    Full --> RR7["React Router v7<br/><i>Remix-style data + routing</i>"]
    Full --> TSR["TanStack Router<br/><i>Max type safety on routes</i>"]
    Full --> RW["RedwoodSDK<br/><i>Cloudflare Workers full-stack</i>"]
    Full --> Vike["Vike<br/><i>Thin customizable Vite layer</i>"]

    classDef plain fill:#1f2533,stroke:#4b5563,color:#c8cdd6
    classDef full  fill:#1f2533,stroke:#4b5563,color:#c8cdd6
    classDef leaf  fill:#161a22,stroke:#6ea8ff,color:#e6e8ec
    class Plain,Full plain
    class TS,TSC,JS,JSC,RSC,RR7,TSR,RW,Vike leaf
```

## Capability matrix

Grouped by which features each option turns on.

```mermaid
graph LR
    subgraph Plain["Plain React (SPA)"]
        TS["TypeScript"]
        TSC["TypeScript + Compiler"]
        JS["JavaScript"]
        JSC["JS + Compiler"]
    end

    subgraph Full["Full-framework / SSR"]
        RSC["RSC"]
        RR7["React Router v7"]
        TSR["TanStack Router"]
        RW["RedwoodSDK"]
        Vike["Vike"]
    end

    subgraph Feat["Capabilities"]
        Routing["Routing"]
        SSR["SSR"]
        RSCf["RSC"]
        Data["Data loading"]
        Comp["React Compiler"]
    end

    RR7 --> Routing
    TSR --> Routing
    RW --> Routing
    Vike -.->|bring your own| Routing

    RSC --> SSR
    RR7 --> SSR
    TSR --> SSR
    RW --> SSR
    Vike --> SSR

    RSC --> RSCf
    RW --> RSCf

    RSC --> Data
    RR7 --> Data
    TSR --> Data
    RW --> Data
    Vike -.->|bring your own| Data

    TSC --> Comp
    JSC --> Comp

    classDef node fill:#161a22,stroke:#6ea8ff,color:#e6e8ec
    classDef feat fill:#1f2533,stroke:#2bd4a4,color:#2bd4a4
    class TS,TSC,JS,JSC,RSC,RR7,TSR,RW,Vike,Plain,Full node
    class Routing,SSR,RSCf,Data,Comp feat
```

## Decision flow

```mermaid
flowchart TD
    Start([Need a React app?]) --> Q1{Need routing or SSR?}
    Q1 -->|No| Q2{Use TypeScript?}
    Q1 -->|Yes| Q3{Deploy target?}

    Q2 -->|Yes| Q4{Use React Compiler?}
    Q2 -->|No| Q5{Use React Compiler?}

    Q4 -->|Yes| TSC["TypeScript + React Compiler"]
    Q4 -->|No| TS["TypeScript"]
    Q5 -->|Yes| JSC["JavaScript + React Compiler"]
    Q5 -->|No| JS["JavaScript"]

    Q3 -->|Cloudflare Workers| RW["RedwoodSDK"]
    Q3 -->|Anywhere else| Q6{Max type safety?}

    Q6 -->|Yes| TSR["TanStack Router"]
    Q6 -->|No| Q7{Prefer conventions?}

    Q7 -->|Yes| Q8{Server Components?}
    Q7 -->|No| Vike["Vike<br/><i>flexible / BYO</i>"]

    Q8 -->|Yes| RSC["RSC"]
    Q8 -->|No| RR7["React Router v7"]

    classDef ans fill:#161a22,stroke:#2bd4a4,color:#2bd4a4
    classDef opt fill:#161a22,stroke:#6ea8ff,color:#e6e8ec
    class TS,TSC,JS,JSC,RR7,TSR,RW,RSC,Vike opt
```
