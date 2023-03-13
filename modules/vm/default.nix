{pkgs, ...}: {
    virtualisation.libvirtd = {
        enable = true;
        qemu = {
            ovmf.enable = true;
            swtpm.enable = true;
        };
    };
    users.extraUsers.jacob.extraGroups = [ "libvirtd" "kvm" "qemu-libvirtd" ];
    networking.firewall.checkReversePath = false;

    boot.kernelModules = [ "kvm-amd" ];

    environment.systemPackages = with pkgs; [
        qemu_kvm
        virt-manager
    ];
}