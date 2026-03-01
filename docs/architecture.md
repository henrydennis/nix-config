# Architecture

## Repository Model

This repository is a flake-based home-manager configuration system with shared modules, profile composition, and host overrides.

Top-level boundaries:

- `flake.nix`: declares inputs and exposes outputs (`overlays`, `packages`, `homeModules`, `homeConfigurations`).
- `lib/mk-home.nix`: builds a `home-manager.lib.homeManagerConfiguration` from shared modules plus host/profile selections.
- `home/modules/`: reusable module units grouped by `common/`, `darwin/`, and `linux/`.
- `home/profiles/`: reusable profile composition overlays.
- `home/hosts/`: host-specific module fragments.
- `pkgs/`: local package definitions.
- `overlays/`: local package integration into `pkgs`.
- `scripts/`: repository maintenance scripts.
- `.githooks/`: repository-local git hooks wired via `core.hooksPath`.

## Configuration Flow

1. `flake.nix` defines inputs (`nixpkgs`, `home-manager`) and imports `lib/mk-home.nix`.
2. `homeConfigurations` entries pass identity and module lists into `mkHome`.
3. `lib/mk-home.nix` creates `pkgs` for the selected `system`, applies overlays, and detects platform.
4. Platform modules are selected:
`darwin/security-pinentry.nix` + `darwin/window-management.nix` for Darwin, or `linux/xdg-user-dirs.nix` for Linux.
5. Base shared modules are always included from `home/modules/common/`.
6. The module chain is extended with `profileModules`, then `hostModules`, then optional `extraModules`.
7. `home-manager` evaluates the merged module graph and produces an activation package.

## Module Load Order Contract

The effective order in `lib/mk-home.nix` is:

1. shared common modules
2. inline home defaults (`username`, `homeDirectory`, `stateVersion`, home-manager enablement)
3. platform modules
4. profile modules
5. host modules
6. extra modules

Implications:

- Later modules can override earlier values through normal module semantics.
- Host and extra modules are the narrowest, highest-specificity layers.
- Shared behavior should remain in common/profile modules unless specifically host-bound.

## Extension Points

Use these extension points deliberately:

- `home/modules/common/`: reusable cross-platform behavior.
- `home/modules/<platform>/`: platform-scoped behavior.
- `home/profiles/`: named bundles of reusable behavior.
- `home/hosts/`: host-specific details only.
- `pkgs/` + `overlays/`: local package definitions and exposure.
- `flake.nix` `homeModules`: external import/export surface for reusable modules.

## Architectural Constraints

1. Keep module responsibilities narrow and composable.
2. Avoid placing host-specific logic in shared modules.
3. Keep platform-specific logic under platform directories.
4. Preserve deterministic composition by making import flow explicit in `flake.nix` and `lib/mk-home.nix`.
