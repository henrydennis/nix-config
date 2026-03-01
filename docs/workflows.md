# Workflows

This page provides command recipes for the regular lifecycle: inspect, validate, build, apply, and update.

## Identify Configuration IDs

Configuration IDs are keys in `flake.nix` under `homeConfigurations`.

```bash
nix flake show
```

Use one of those keys as `<config-id>` in commands below.

## Fast Path: Validate, Build, and Switch Current Host

Use the repository helper script when switching from this checkout:

```bash
./scripts/hmup
```

What it does:

1. derives `<config-id>` from `$(id -un)@$(scutil --get LocalHostName || hostname -s)`.
2. runs `nix flake check`.
3. runs `nix build .#homeConfigurations."<config-id>".activationPackage`.
4. runs `home-manager switch --flake .#<config-id>`.

## Codex CLI Profiles

Codex config is managed in this repo and written to `~/.codex/config.toml` by Home Manager.
Experimental feature flags are enabled by default under `[features]`.

```bash
# default profile from config.toml (equivalent to --dangerously-bypass-approvals-and-sandbox)
codex

# safer profile (approvals on failure + workspace-write sandbox)
codex --profile safe
```

## Install Repository Hooks

```bash
# configure repository-local git hooks path and permissions
./scripts/setup-git-hooks.sh
```

Expected result:

- `git config --get core.hooksPath` returns `.githooks`.
- `gitleaks` is available from `PATH` or `~/.nix-profile/bin/gitleaks`.
- commits run gitleaks scan against staged changes before commit is created.

## Inspect and Evaluate

```bash
# Show outputs and available targets
nix flake show

# Evaluate and run declared checks
nix flake check
```

Expected result:

- `nix flake show` lists outputs without evaluation errors.
- `nix flake check` finishes successfully.

## Build Without Applying

```bash
nix build .#homeConfigurations."<config-id>".activationPackage
```

Expected result:

- build completes and updates the local `result` symlink to an activation derivation.
- no live configuration switch happens in this step.

## Apply Configuration

```bash
home-manager switch --flake .#<config-id>
```

Expected result:

- home-manager evaluates the target configuration and activates a new generation.

## Verify Applied State

```bash
# show active generations
home-manager generations
```

Validation checks:

- latest generation timestamp matches recent switch.
- no activation-time errors were emitted.

## Update Inputs

```bash
# update all flake inputs and lockfile pins
nix flake update

# validate after update
nix flake check
```

Recommended review sequence after lockfile updates:

1. inspect lockfile diff.
2. run build for each maintained `<config-id>`.
3. switch only after successful build and check.

## Run Secret Scan Manually

```bash
# scan staged changes exactly as pre-commit does
gitleaks git --staged --no-banner --redact --log-level warn
```

If `gitleaks` is not already installed in your shell:

```bash
nix profile add nixpkgs#gitleaks
gitleaks git --staged --no-banner --redact --log-level warn
```

## Rollback-Oriented Recovery

If a switch introduces regressions:

1. inspect recent generations:
```bash
home-manager generations
```
2. activate a previous generation using the printed activation path:
```bash
/nix/store/<previous-generation-path>/activate
```
3. fix the repository change and rebuild before switching again.

## Routine Change Cycle

Use this baseline loop for most changes:

1. modify configuration files.
2. `nix flake check`
3. `nix build .#homeConfigurations."<config-id>".activationPackage`
4. `home-manager switch --flake .#<config-id>`
5. verify with `home-manager generations`
