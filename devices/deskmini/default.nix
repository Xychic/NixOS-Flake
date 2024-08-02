# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nixPath = [ "/etc/nix/path" ];
    registry.nixpkgs.flake = inputs.nixpkgs;
  };
  environment.etc."/nix/path/nixpkgs".source = inputs.nixpkgs;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };
    grub2-theme = {
      theme = "vimix";
    };
  };

  networking = {
    hostName = "deskmini"; # Define your hostname.
    networkmanager.enable = true;
  };

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.dhcpcd.enable = false;

  nixpkgs.config.allowUnfree = true;
  systemd.services.decrypt-data-partition = {
    wantedBy = [ "multi-user.target" ];
    description = "Decrypt veracrypt data partition";
    path = [
      pkgs.bash
      pkgs.coreutils
      pkgs.veracrypt
      pkgs.lvm2
      pkgs.util-linux
      pkgs.systemd
    ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = "yes";
      ExecStart = "${pkgs.systemd}/lib/systemd/systemd-cryptsetup attach cryptdata /dev/disk/by-partuuid/1579df1b-0875-44aa-8d3a-c46fd46d0420 /etc/passfile tcrypt-veracrypt,tcrypt-keyfile=";
      ExecStop = "${pkgs.systemd}/lib/systemd/systemd-cryptsetup detach cryptdata";
    };
  };

  systemd.mounts = [
    {
      enable = true;
      wantedBy = [ "multi-user.target" ];
      description = "Mount veracrypt data partition";
      after = [ "decrypt-data-partition.service" ];
      requires = [ "decrypt-data-partition.service" ];
      where = "/mnt/data";
      type = "exfat";
      what = "/dev/mapper/cryptdata";
      options = "rw,uid=1000,gid=100,umask=0077";
    }
  ];

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      desktopManager.plasma5.enable = true;
      # Configure keymap in X11
      xkb.layout = "gb";
      # services.xserver.xkbOptions = "eurosign:e";
    };
    displayManager.sddm.enable = true;
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # hardware.pulseaudio.enable = true;
  hardware = {
    bluetooth = {
      enable = true; # enables support for Bluetooth
      powerOnBoot = false; # powers up the default Bluetooth controller on boot
    };
    keyboard.qmk.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jacob = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  virtualisation.docker.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    veracrypt
  ];

  programs.zsh = {
    shellInit = "export PKG_CONFIG_PATH=${pkgs.openssl.dev}/lib/pkgconfig";
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;

    shellAliases = import ../../home/cli/core/zsh/aliases.nix;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
