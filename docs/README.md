# Documentation Index

This directory is the canonical handbook for operating and evolving this repository.

## Reading Order

1. [`architecture.md`](./architecture.md): how the repository is composed and how configuration flows.
2. [`workflows.md`](./workflows.md): command recipes for inspect, validate, build, apply, and update cycles.
3. [`change-process.md`](./change-process.md): how to add, modify, and remove modules safely.
4. [`module-naming.md`](./module-naming.md): naming rules for new modules and module exports.
5. [`troubleshooting.md`](./troubleshooting.md): diagnosis and fixes for common failure modes.

## Documentation Principles

1. Organize by workflows and architecture layers, not by role labels.
2. Focus on structure, composition, and maintenance mechanics.
3. Avoid app/program inventory sections.
4. Use placeholders in command examples (for example: `<config-id>`, `<capability>`, `<scope>`).
5. Keep naming examples in sync with `module-naming.md` and `change-process.md`.

## Update Rule

When changing repository structure, composition wiring, or operational workflow, update affected docs in this directory in the same change.
