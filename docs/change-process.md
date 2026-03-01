# Change Process

This process defines how to add, modify, or remove modules while keeping composition predictable.

## 1) Define Change Boundary

Before editing:

1. state the capability being changed.
2. identify its scope boundary.
3. decide whether behavior is shared, platform-specific, profile-specific, or host-specific.

Use these placement rules:

- shared behavior: `home/modules/common/`
- platform behavior: `home/modules/darwin/` or `home/modules/linux/`
- profile composition: `home/profiles/`
- host-specific behavior: `home/hosts/`

## 2) Name the Module

Apply naming standard from `module-naming.md`:

`<capability>-<scope>.nix`

Do not include directory context (for example `common`, `darwin`, `linux`) in the filename.
Default to placing modules directly under the selected scope directory; avoid creating a folder per module.

If adding a reusable exported module, ensure `flake.nix` `homeModules` key aligns with filename terms.

## 3) Implement and Wire

Choose the wiring surface intentionally:

1. Add to base shared chain in `lib/mk-home.nix` only when it is universally required.
2. Add to profile modules when it should be reusable but not universal.
3. Add to host modules only when it is host-bound.
4. Add to `flake.nix` `homeModules` when exposing reusable module entrypoints externally.

Keep import and layering direction explicit and minimal.

## 4) Validate

Run validation in this order:

```bash
nix flake check
nix build .#homeConfigurations."<config-id>".activationPackage
home-manager switch --flake .#<config-id>
home-manager generations
```

For lockfile-related changes, run:

```bash
nix flake update
nix flake check
```

## 5) Update Documentation

When change affects structure or process, update all impacted docs in the same change:

- `architecture.md` for composition boundary changes.
- `workflows.md` for operational command/process changes.
- `module-naming.md` for naming-rule refinements.
- `troubleshooting.md` for new failure patterns.

## Module Addition Checklist

1. file placed in correct directory.
2. filename follows naming standard.
3. import wiring matches intended scope.
4. optional `homeModules` export key aligned.
5. validation commands pass for impacted configurations.
6. docs updated where required.

## Module Modification Checklist

1. preserve or intentionally change boundary.
2. avoid broadening responsibility without renaming/splitting.
3. re-run validation cycle.
4. update docs if behavior or flow changed.

## Module Removal Checklist

1. remove all references from `lib/mk-home.nix`, profiles, hosts, and `flake.nix` exports.
2. confirm no dangling import paths.
3. run full validation cycle.
4. update architecture and troubleshooting docs to match new state.

## Compatibility and Migration

1. Prefer incremental migration of broad legacy module names when touched.
2. Avoid repository-wide renaming unless there is a specific maintenance objective.
3. Keep behavior stable while improving module boundaries and names.
