{ pkgs ? import <nixpkgs> {} }:

let
  ovmfPath = pkgs.OVMF.fd + "/FV";
in
pkgs.mkShell {
  name = "nixos-vm-env";

  buildInputs = [
    pkgs.qemu
    pkgs.OVMF
    pkgs.bashInteractive
  ];

  shellHook = ''
    export OVMF_CODE="${ovmfPath}/OVMF_CODE.fd"
    export OVMF_VARS="${ovmfPath}/OVMF_VARS.fd"

    echo "✔️ VM environment ready."
    echo
    echo "Run './run-vm.sh /path/to/iso/nixos-minimal*.iso' to start the VM."
  '';
}
