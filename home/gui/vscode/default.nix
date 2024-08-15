{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode
    nixfmt-rfc-style
  ];
  programs.vscode = {
    enable = true;
    extensions =
      with pkgs.vscode-extensions;
      [ rust-lang.rust-analyzer ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./extensions);
    userSettings = {
      "editor.renderWhitespace" = "all";
      "update.mode" = "none";
      "telemetry.telemetryLevel" = "off";
      "editor.fontFamily" = "'Cascadia Mono',monospace";
      "editor.suggestSelection" = "first";
      "vsintellicode.modify.editor.suggestSelection" = "automaticallyOverrodeDefaultValue";
      "code-runner.runInTerminal" = true;
      "code-runner.ignoreSelection" = true;
      "code-runner.clearPreviousOutput" = true;
      "code-runner.executorMap" = {
        "haskell" = "cd $dir && stack runghc $fileName";
        "python" = "cd $dir && python -u $fileName";
        "c" = "cd $dir && gcc $fileName -lm -o $fileNameWithoutExt && ./$fileNameWithoutExt";
        "java" = "cd $dir && javac $fileName -d ./bin/ && java -cp ./bin/ $fileNameWithoutExt";
        "rust" = "cd $dir && cargo fmt && cargo test --release && cargo run --release";
        "go" = "cd $dir && go test -v && go run main.go";
        "makefile" = "cd $dir && make && ./$(head -n 1 $fileName | cut -d : -f 1)";
        "nix" = "cd $dir && nix eval -f $fileName \"result\" --show-trace";
        "asm" = "cd $dir && nasm -f elf64 -F dwarf $fileName && echo $fileNameWithoutExt.o";
      };
      "code-runner.executorMapByGlob" = {
        "*.asm" = "cd $dir && nasm -f elf64 -F dwarf $fileName && ld -m elf_x86_64 $fileNameWithoutExt.o -o $fileNameWithoutExt && ./$fileNameWithoutExt";
      };
      "python.languageServer" = "Pylance";
      "explorer.confirmDelete" = false;
      "editor.detectIndentation" = true;
      "security.workspace.trust.untrustedFiles" = "open";
      "explorer.confirmDragAndDrop" = false;
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs" = true;
      "workbench.iconTheme" = "vscode-great-icons";
      "rust-analyzer.procMacro.enable" = false;
      "rust-analyzer.inlayHints.lifetimeElisionHints.enable" = "always";
      "rust-analyzer.check.command" = "clippy";
      "rust-analyzer.check.extraArgs" = [
        "--"
        "-W"
        "clippy::pedantic"
      ];
      "diffEditor.ignoreTrimWhitespace" = false;
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "cSpell.language" = "en-GB";
      "prettier.configPath" = ".prettierrc";
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[markdown]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "window.zoomLevel" = 1;
      "MarkdownPaste.path" = "\${fileDirname}/images";
      "terminal.integrated.defaultLocation" = "editor";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "errorLens.enabledDiagnosticLevels" = [
        "error"
        "warning"
      ];
      "python.analysis.typeCheckingMode" = "strict";
      "python.analysis.autoImportCompletions" = true;
      "editor.fontLigatures" = false;
      "nix.serverPath" = "nixd";
      "nix.enableLanguageServer" = true;
      "editor.stickyScroll.enabled" = false;
    };
  };
}
