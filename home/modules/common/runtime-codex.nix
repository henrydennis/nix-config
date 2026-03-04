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

  home.file.".codex/config.toml".text = ''
    model = "gpt-5.3-codex"
    model_reasoning_effort = "xhigh"
    plan_mode_reasoning_effort = "xhigh"
    approval_policy = "never"
    sandbox_mode = "danger-full-access"
    notify = ["terminal_bell"]

    [features]
    apps = true
    multi_agent = true
    remote_models = true
    search_tool = true
    shell_snapshot = true

    [history]
    persistence = "save-all"

    [profiles.safe]
    approval_policy = "on-failure"
    sandbox_mode = "workspace-write"
  '';
}
