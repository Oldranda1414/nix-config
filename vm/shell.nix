{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "nixos-vm-env";

  buildInputs = [
    pkgs.qemu
    pkgs.OVMF
    pkgs.bashInteractive
  ];

  shellHook = ''
    echo "✔️ VM environment ready."
    echo "Run 'sudo ./run-vm.sh /path/to/iso/nixos-minimal*.iso' to start the VM."
  '';
}
