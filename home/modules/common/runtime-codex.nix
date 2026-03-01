{ pkgs, ... }:
let
  codexLatest = pkgs.writeShellScriptBin "codex" ''
    exec ${pkgs.nodejs}/bin/npx --yes @openai/codex@latest "$@"
  '';
in
{
  home.packages = [
    pkgs.nodejs
    codexLatest
  ];
}
