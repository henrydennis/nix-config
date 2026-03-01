# Troubleshooting

This page focuses on common failures in flake evaluation, module composition, and activation workflow.

## Missing Attribute in Flake Output

Symptoms:

- errors like `attribute '...' missing` when building or switching.

Likely causes:

- wrong `<config-id>` value.
- missing or renamed key in `homeConfigurations` or `homeModules`.

Diagnose:

```bash
nix flake show
```

Resolve:

1. confirm exact output key names in `flake.nix`.
2. update command target or restore expected key.

## Module Option Does Not Exist

Symptoms:

- evaluation errors indicating unknown options.

Likely causes:

- option path typo.
- module moved to wrong layer and no longer has required context.

Diagnose:

```bash
nix flake check
```

Resolve:

1. correct option paths.
2. verify module belongs in shared/platform/profile/host layer.
3. ensure imports include the module in the intended composition path.

## Conflicting Option Definitions

Symptoms:

- merge conflict errors during evaluation.

Likely causes:

- same option set in multiple layers without intended precedence.

Diagnose:

```bash
nix flake check
```

Resolve:

1. decide which layer owns the setting.
2. remove duplicated ownership.
3. if override is intentional, keep it in the narrowest layer (profile or host).

## Build Succeeds but Switch Fails

Symptoms:

- activation stage errors after successful `nix build`.

Likely causes:

- runtime activation issue not visible at pure build stage.

Diagnose:

```bash
nix build .#homeConfigurations."<config-id>".activationPackage
home-manager switch --flake .#<config-id>
```

Resolve:

1. inspect activation error output.
2. fix module logic causing activation-time failure.
3. rerun check/build/switch sequence.

## Host/Profile Mismatch

Symptoms:

- expected values not present for a specific host.

Likely causes:

- change added in wrong layer (shared vs profile vs host).
- host module not included in the target configuration.

Diagnose:

1. inspect `flake.nix` `homeConfigurations` module lists.
2. inspect `lib/mk-home.nix` import order.

Resolve:

1. move logic to correct layer.
2. ensure host module is attached to the intended configuration entry.

## Lockfile Drift After Input Updates

Symptoms:

- newer input pins trigger evaluation or behavior changes.

Diagnose:

```bash
nix flake update
nix flake check
nix build .#homeConfigurations."<config-id>".activationPackage
```

Resolve:

1. review `flake.lock` diff.
2. identify dependency changes that affect evaluation.
3. patch modules as needed, then re-run validation.

## Pre-Commit Hook Fails: gitleaks Not Found

Symptoms:

- commit is blocked with an error indicating `gitleaks` is unavailable.

Likely causes:

- `gitleaks` is not installed and `~/.nix-profile/bin/gitleaks` is missing.
- hooks were not installed for this repository yet.

Diagnose:

```bash
git config --get core.hooksPath
command -v gitleaks
ls -l ~/.nix-profile/bin/gitleaks
```

Resolve:

1. install hooks for this repository:
```bash
./scripts/setup-git-hooks.sh
```
2. if `gitleaks` is missing but Nix is available, install it:
```bash
nix profile add nixpkgs#gitleaks
```
3. verify `gitleaks` is now available:
```bash
~/.nix-profile/bin/gitleaks version
```
4. if Nix is unavailable, install `gitleaks` so `gitleaks` is in `PATH`.

## Recovery Path

If a newly applied generation is not acceptable:

1. list generations:
```bash
home-manager generations
```
2. activate a known-good generation:
```bash
/nix/store/<previous-generation-path>/activate
```
3. correct repository changes and rerun standard workflow.
