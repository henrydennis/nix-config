# Module Naming

## Naming Standard

New module files should follow:

`<capability>-<scope>[-<platform>].nix`

Definitions:

- `<capability>`: the primary function being configured.
- `<scope>`: the boundary or concern within that capability.
- `[-<platform>]`: optional platform suffix (`darwin`, `linux`) when behavior is platform-bound.

## Naming Goals

1. Make purpose obvious from filename alone.
2. Keep each module responsible for one clear concern.
3. Remove ambiguous catch-all names for new work.
4. Align file names with exported module keys and documentation terms.

## Good Examples

- `shell-interactive-common.nix`
- `git-core-common.nix`
- `runtime-node-common.nix`
- `xdg-user-dirs-linux.nix`
- `window-management-darwin.nix`

## Avoid

- `tooling.nix`
- `misc.nix`
- `defaults.nix` (unless it is an intentional aggregator entrypoint)
- `my-config.nix`

## Directory Placement

Use directory + suffix together:

- cross-platform shared modules: `home/modules/common/`
- platform-bound modules: `home/modules/darwin/` or `home/modules/linux/`

The filename should still include explicit scope and optional platform suffix when it adds clarity.

## Export Key Alignment

When adding to `flake.nix` `homeModules`:

1. use kebab-case keys.
2. keep key terms aligned to filename terms.
3. keep prefix/scope ordering consistent across related modules.

Example mapping:

- file: `home/modules/common/git-core-common.nix`
- key: `common-git-core`

## Transition Policy

Existing module names can remain until touched by related changes.
When touching an existing broad module, split or rename incrementally toward this standard instead of large one-shot rewrites.
