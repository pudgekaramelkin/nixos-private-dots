Тут будут куски текста из разных источников. Я не хочу засирать ими свои заметки, кину сюда

## На будущее

Fix C/C++ - https://www.reddit.com/r/NixOS/comments/1d7zvgu/nvim_cant_find_standard_library_headers/
Запишу некоторые комменты из этого поста на реддите

---


Haven't seen it mentioned, so here is an alternative option.

I use nix-ld which basically makes the listed libraries available in their expected locations.

The simple config below fixed Mason for me. it also works with Doom Emacs so it's a more general solution. You can add more packages to the list and any libs will be made available for all external apps.

```nix
nix-ld = {
  enable = true;
  libraries = with pkgs; [
    stdenv.cc.cc
  ];
};
```

Since then, I have also been able to get X-Plane running natively by adding missing libraries to the list. It can be a bit tedious figuring out which libraries are missing and what packages need to be added, but it only needs to be done once. To figure out what libraries an app needs and which packages they belong to, do the following:

    run nix-index (takes about 5 minutes) which you only need to do the first time to create a file database of nixpkgs.

    Find the libraries an executable needs and whether they are found or missing. ldd ./your_executable_file

    Use nix-locate to find packages that contain that library. For example: nix-locate -w ./libX11.so.6 --top-level It may show several packages.. pick the one that looks most appropriate. In this case it was xorg.libX11

    Add that package to the nix-ld libraries list.

    Once all libraries are added, rebuild your system.

    You may need to reboot or log out and back in again before ldd will find the libraries.

The nice thing about nix-ld, is once you have a nice collection of common libraries setup, many apps will just work like on other distros.

---

Hello, sorry for the late response. I've been using that nix-ld setup for Rust, Lua, and Bash, LSPs for a while. Funnily enough it was thanks to one of your previous comments that I first tried it.

For any of the mentioned languages I didn't have to put anything into nix-ld, even the clangd LSPs in Mason installed correctly, literally the only issue is that NVim doesn't see the standard library headers. I've tried putting every package in there: clang, clang-tools, clangStdenv, libclang, and ccls.

I'm gonna be completely honest, I'm not sure I understand the instructions, especially the ldd part, I'm not sure what executable I should point to with that command.

Are there any libraries that you'd recommend I'd put in nix-ld? Like a base line?

Also as a further question. I'm not using NixOS to manage my NVim config whatsoever, meaning I just put my the nvim config into the ~/.config directory, could that be the issue, or is that ok as a practice?

---

Yeah, I'm a bit of a nix-ld fanboy as it saved NixOS for me when I was feeling like giving up.

I gotta admit, I'm not a developer, so I'm not an expert on dev tools. Maybe try creating a dev shell with nix (or a flake)? You can specify exactly what libraries you need and they should be available when you instantiate the shell.

This post on github may give you some ideas: https://github.com/NixOS/nixpkgs/issues/92739#issuecomment-861248463. It's a bit old, but it may be worth trying. Try running nvim inside of the dev shell.. maybe the standard libraries will be available then?

