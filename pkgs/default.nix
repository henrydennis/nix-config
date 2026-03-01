{ pkgs }:
{
  hello-hm = pkgs.writeShellScriptBin "hello-hm" ''
    echo "hello from home-manager flake"
  '';
}
