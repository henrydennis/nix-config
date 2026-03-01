# Workflows

This page provides command recipes for the regular lifecycle: inspect, validate, build, apply, and update.

## Identify Configuration IDs

Configuration IDs are keys in `flake.nix` under `homeConfigurations`.

```bash
nix flake show
```

Use one of those keys as `<config-id>` in commands below.

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
