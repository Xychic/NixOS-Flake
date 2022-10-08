{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        rust-lang.rust-analyzer
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace (import ./extensions);
    userSettings = {
      "editor.renderWhitespace" = "trailing";
      "update.mode" = "none";
      "telemetry.telemetryLevel" = "off";
      "editor.fontFamily" = "'Cascadia Mono',monospace";
      "telemetry.enableTelemetry" = false;
      "telemetry.enableCrashReporter" = false;
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
    };
  };
}
