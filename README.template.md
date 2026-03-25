# __PROJECT_NAME__

This repository hosts the `__PROJECT_NAME__` service for `__ORG_NAME__`.

The project follows a specification‑driven, agent‑friendly workflow:

- **Docs first**: product, design, delivery and operations live under `docs/`.
- **Typed artefacts**: features (`FEAT-…`), blocks (`BF-…`), subsystems (`LS-…`), tech artefacts (`TS-…`) and batches (`LOT-…`) are explicitly referenced in the docs.
- **Mono‑LOT branches**: each delivery batch (`LOT-…`) is implemented on its own Git branch, then merged via PR/MR.

## Documentation map

- `docs/00_vision/` — high‑level vision and scoping for `__PROJECT_NAME__`.
- `docs/01_product/` — product specifications and roadmap.
- `docs/02_design/` — functional, software and technical architecture, data model, tech stack.
- `docs/03_delivery/` — per‑version delivery plans (`LOT-…`) and testing strategy.
- `docs/04_operations/` — deployment, configuration, monitoring, incident handling, security.

See `AGENTS.md` and `CONVENTIONS.md` at the repository root for detailed working rules (humans and AI agents).

