# nix-profile

This repository manages home-manager configurations for multiple hosts from a single flake.
It keeps common behavior centralized while allowing host-specific and platform-specific overrides.
The structure is optimized for repeatable evaluation, predictable composition, and incremental changes.

## Start Here

Full documentation lives in [`docs/`](./docs/README.md). Use this root README as a quick entrypoint.

## Repository Layout

- `flake.nix`: top-level inputs, outputs, and host configuration registrations.
- `lib/`: composition helpers (notably `mk-home.nix`).
- `home/modules/`: reusable module units grouped by platform and shared scope.
- `home/profiles/`: profile-level composition that can be reused across hosts.
- `home/hosts/`: host-specific overrides and environment details.
- `overlays/`: package overlay wiring.
- `pkgs/`: local packages exposed through overlays and flake outputs.
- `scripts/`: repository maintenance scripts (for example git hook setup).
- `.githooks/`: repository-local git hooks used via `core.hooksPath`.
- `docs/`: architecture, workflows, naming standards, and maintenance process.

## Quick Recipes

Replace `<config-id>` with a key from `homeConfigurations` in `flake.nix`.

```bash
# Install repository git hooks (includes gitleaks pre-commit scan)
./scripts/setup-git-hooks.sh

# Inspect flake outputs
nix flake show

# Validate flake evaluation and checks
nix flake check

# Build activation package without switching
nix build .#homeConfigurations."<config-id>".activationPackage

# Apply configuration
home-manager switch --flake .#<config-id>

# Update input lockfile
nix flake update
```

## Documentation Rule

Any structural or workflow change must update the relevant files in `docs/` in the same change.
