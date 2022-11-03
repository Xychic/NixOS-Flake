{pkgs, ...}: [
  {
    name = "zsh-autosuggestions";
    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-autosuggestions";
      rev = "v0.7.0";
      sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
    };
  }
  {
    name = "zsh-syntax-highlighting";
    src = pkgs.fetchFromGitHub {
      owner = "zsh-users";
      repo = "zsh-syntax-highlighting";
      rev = "0.7.1";
      sha256 = "gOG0NLlaJfotJfs+SUhGgLTNOnGLjoqnUp54V9aFJg8=";
    };
  }
  {
    name = "zsh-git-prompt";
    src = pkgs.fetchFromGitHub {
      owner = "woefe";
      repo = "git-prompt.zsh";
      rev = "v2.3.0";
      sha256 = "i5UemJNwlKjMJzStkUc1XHNm/kZQfC5lvtz6/Y0AwRU=";
    };
  }
]
