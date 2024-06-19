{ pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  packages = [
    pkgs.k9s
    pkgs.kubectl
    pkgs.kubevirt
  ];
}
