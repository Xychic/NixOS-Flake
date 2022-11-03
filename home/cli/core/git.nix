{pkgs, ...}: {
  home.packages = with pkgs; [git];
  programs.git = {
    enable = true;
    userName = "Jacob Turner";
    userEmail = "jacob11turner@gmail.com";
    difftastic.enable = true;
    extraConfig = {
      init.defaultBranch = "master";
    };
  };
}
