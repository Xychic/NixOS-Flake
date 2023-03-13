{pkgs, ...}: {
  home.packages = with pkgs; [ cudatoolkit ];
  home.sessionVariables = {
    CUDA_PATH = pkgs.cudatoolkit;
    # LD_LIBRARY_PATH = "${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_LDFLAGS = "-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib";
    EXTRA_CCFLAGS = "-I/usr/include";
  };
}