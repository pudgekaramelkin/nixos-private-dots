{ pkgs, ... }: { # https://nixos.wiki/wiki/Visual_Studio_Code
  programs.vscode = {
    enable = true;

    # Что-то из этого может пригодиться, если хочу ставить пакеты без декларативности
    # package = pkgs.vscode.fhs; # Почему в вики написано ".fhs", если пакет называется "-fhs"?
    # package = pkgs.vscode-with-extensions; # Мб это надо?


    # Чтоб узнать sha256, я скачал расширение напрямую с сайта маркетплейса
    # А потом в терминале написал "sha256sum filename"
    # В оф репе юзают такой скрипт для установки расширений, не знаю поможет ли
    # https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vscode/extensions/update_installed_exts.sh#L34
    # Имя и паблишер берутся из ссылки. После "?itemName" идёт паблишер.нейм
    extensions = with pkgs.vscode-extensions; [
      jdinhlife.gruvbox # Gruvbox theme
      eamodio.gitlens # GitLens - Git supercharged
      jnoortheen.nix-ide # Nix language support - syntax highlighting, formatting, and error reporting.
      sumneko.lua # Lua language server
      naumovs.color-highlight # Highlight web colors in your editor
      tamasfe.even-better-toml # Fully-featured TOML support
      ms-python.python # Python language support
      golang.go # Rich Go language support
      mechatroner.rainbow-csv # Rainbow syntax higlighting for CSV and TSV files
      # redhat.vscode-xml # XML Language Support by Red Hat
      # dotjoshjohnson.xml # XML Tools
      # bradlc.vscode-tailwindcss # Tailwind CSS tooling
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [ # Руками с гита ставить
      { # https://marketplace.visualstudio.com/items?itemName=budparr.language-hugo-vscode
        name = "language-hugo-vscode";
        publisher = "budparr";
        version = "1.3.1";
        sha256 = "f5da7cfe02c06fc3899e6b0b55b380280619e7085abcf5b6024f9684ba846c99";
      }
      # { # https://marketplace.visualstudio.com/items?itemName=dlasagno.rasi
      #   name = "rasi";
      #   publisher = "dlasagno";
      #   version = "1.0.0";
      #   sha256 = "b3ad1a95e8f770d01b489c6c4652111364216baa00b2670e05b5a8aa9fb0e9f9";
      # }
      # { # https://marketplace.visualstudio.com/items?itemName=a-h.templ
      #   name = "templ";
      #   publisher = "a-h";
      #   version = "0.0.29";
      #   sha256 = "459fbec312f63aa061de188b030288c3940b8d4fe29ac2bb8ab4141db27fb6a3";
      # }
      # { # https://marketplace.visualstudio.com/items?itemName=CraigRBroughton.htmx-attributes
      #   name = "htmx-attributes";
      #   publisher = "CraigRBroughton";
      #   version = "0.8.0";
      #   sha256 = "4ec7a63d992ad99d77fef6a145a3fbcf6d3a0496826754d1e8e56fe9a783bf29";
      # }
      # { # https://marketplace.visualstudio.com/items?itemName=Codeium.codeium
      #   name = "codeium";
      #   publisher = "Codeium";
      #   version = "1.29.2";
      #   sha256 = "86e075c4fd0d60f7fa7b32e497260a86a94ec812d95e3d9f058ce45e77648f89";
      # }
    ];

    # userSettings = {
    #   "telemetry.telemetryLevel" = "off";
    #   "update.showReleaseNotes" = false;
    #   "workbench.colorTheme" = "Gruvbox Dark Medium";
    #   "editor.fontFamily" = "JetBrainsMono Nerd Font";
    #   "editor.lineNumbers" = "relative";
    # };

    # globalSnippets = {};

    # languageSnippets = {};

    # keybindings = [
    #   {
    #     key = "ctrl+c";
    #     command = "editor.action.clipboardCopyAction";
    #     when = "textInputFocus";
    #   }
    # ];
  };
}
