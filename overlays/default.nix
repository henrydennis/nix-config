final: prev:
let
  local = import ../pkgs { pkgs = final; };
in
{
  inherit (local) hello-hm;
}
