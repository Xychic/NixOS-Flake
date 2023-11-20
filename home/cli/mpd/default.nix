{pkgs, ...}: {
  services = {
    mpd = {
      enable = true;
      dataDir = "/home/jacob/Documents/mpd";
      musicDirectory = "/mnt/data/Music/";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "pipewire"
        }
        audio_output {
          type   "fifo"
          name   "FIFO"
          path   "/tmp/mpd.fifo"
          format "44100:16:2"
        }
      '';
    };
    mpdris2 = {
      enable = true;
      multimediaKeys = true;
    };
  };


  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {
      visualizerSupport = true;
    };
    settings = {
      visualizer_fps = 60;
      user_interface = "alternative";
      media_library_primary_tag = "album_artist";
      display_bitrate = "yes";
      mouse_support = "no";
      main_window_color = "green";
      color1 = "white";
      color2 = "yellow";
      now_playing_prefix = "$b$(red)";
      now_playing_suffix = "$(end)$/b";
      progressbar_color = "black:b";
      progressbar_elapsed_color = "red:b";
    };
  };
}
