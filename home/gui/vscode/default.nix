{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./extensions);
  };
}
