#!/usr/bin/env sh
set -eu

REPO_ROOT="$(git rev-parse --show-toplevel)"
cd "$REPO_ROOT"

resolve_gitleaks() {
  if command -v gitleaks >/dev/null 2>&1; then
    command -v gitleaks
    return 0
  fi

  if [ -x "$HOME/.nix-profile/bin/gitleaks" ]; then
    printf '%s\n' "$HOME/.nix-profile/bin/gitleaks"
    return 0
  fi

  return 1
}

ensure_gitleaks() {
  if resolve_gitleaks >/dev/null 2>&1; then
    return 0
  fi

  if ! command -v nix >/dev/null 2>&1; then
    cat >&2 <<'EOF'
setup-git-hooks: gitleaks is required but was not found.
Install Nix, or install gitleaks manually and rerun this script.
EOF
    exit 1
  fi

  echo "Installing gitleaks with Nix profile: nixpkgs#gitleaks"
  nix profile add nixpkgs#gitleaks
}

git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
ensure_gitleaks

echo "Configured core.hooksPath: $(git config --get core.hooksPath)"
echo "Using gitleaks: $(resolve_gitleaks)"
