{
  pkgs,
  system,
  stdenv,
  pname ? "rill",
  version ? "0.51.5",
  shas ? {
    aarch64-darwin = "sha256-NJGtnxinn4Befx6CpVgy6b+rzNMr8+oQBTSm12pKdoY=";
    x86_64-darwin = "07rh67s51nyawmvyq9pbsqxfg04gznx43jxisiiii117w852j2bi";
    aarch64-linux = "087418lm1hbknafh3hs3q9s2pnmjkm4pdi0nm5k17xhlnl7i80d2";
    x86_64-linux = "sha256-LjCfEl6FqU7RyFOLiUFFidNi/OaHoTKreZMYijVhGFk=";
  },
  ...
}: let
  os =
    if stdenv.isDarwin
    then "darwin"
    else "linux";
  arch =
    if pkgs.lib.hasInfix "aarch64" system
    then "arm64"
    else "amd64";
  file = "rill_${os}_${arch}.zip";
in
  stdenv.mkDerivation {
    pname = pname;
    version = version;
    src = pkgs.fetchzip {
      url = "https://cdn.rilldata.com/rill/v${version}/${file}";
      sha256 = shas.${system};
      stripRoot = false;
    };

    installPhase = "mkdir -p $out/bin; cp rill $out/bin";

    checkPhase = ''
      rill version | grep ${version}
    '';
  }
