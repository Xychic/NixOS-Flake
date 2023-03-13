{ config, lib, pkgs, inputs, self, ... }:
let
  toValue = v:
    if builtins.isString v then
      v
    else if builtins.isBool v then
      lib.boolToString v
    else if builtins.isInt v then
      builtins.toString v
    else
      builtins.abort ("Unknown value type: " ++ builtins.toString v);
  lines = lib.flatten (lib.mapAttrsToList
    (file:
      lib.mapAttrsToList
        (group:
          lib.mapAttrsToList
            (key: value:
              "$DRY_RUN_CMD ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5 --file $confdir/'${file}' --group '${group}' --key '${key}' '${toValue value}'"
            )
        )
    )
    (import ./config.nix)
  ) ++ [
    "$DRY_RUN_CMD ${pkgs.libsForQt5.kconfig}/bin/kwriteconfig5 --file $confdir/'kscreenlockerrc' --group 'Greeter' --group 'Wallpaper' --group 'org.kde.image' --group 'General' --key 'Image' '${inputs.wallpapers}/nixos.svg'"
    "$DRY_RUN_CMD ${pkgs.plasma-workspace}/bin/plasma-apply-wallpaperimage '${inputs.wallpapers}/nixos.svg'"
    "$DRY_RUN_CMD ${pkgs.plasma-workspace}/bin/plasma-apply-desktoptheme 'breeze-dark'"
    "$DRY_RUN_CMD ${pkgs.plasma-workspace}/bin/plasma-apply-lookandfeel -a 'org.kde.breezedark.desktop'"
  ];
in
{
  home.packages = with pkgs; [ 
    wmctrl
    kcalc
  ];
  # pkgs.writeTextFile {
  #   name = "setvd1.desktop";
  #   executable = true;
  #   destination = "${home}/.config/autostart/setvd1.desktop";
  #   text = ''
  #     [Desktop Entry]
  #     Exec=sleep 5; wmctrl -s 4
  #     X-DBUS-StartupType=wait
  #     Name=Set VD #1
  #     Type=Service
  #     X-KDE-StartupNotify=false
  #     OnlyShowIn=KDE;
  #     X-KDE-autostart-phase=1
  #   '';
  # }
  
  home.activation.kwriteconfig5 = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    _() {
      confdir="''${XDG_CONFIG_HOME:-$HOME/.config}"
      ${builtins.concatStringsSep "\n" lines}

      $DRY_RUN_CMD ${pkgs.libsForQt5.qt5.qttools.bin}/bin/qdbus org.kde.KWin /KWin reconfigure || echo "KWin reconfigure failed"
      for i in {0..10}; do
        $DRY_RUN_CMD ${pkgs.dbus}/bin/dbus-send --type=signal /KGlobalSettings org.kde.KGlobalSettings.notifyChange int32:$i int32:0 || echo "KGlobalSettings.notifyChange failed"
      done
    } && _
    unset -f _
  '';
}
