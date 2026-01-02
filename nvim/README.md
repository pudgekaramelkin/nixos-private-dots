[kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) fork

> ⚠️ **Warning**: 27.04.2025 произошли большие изменения в конфиге, которые мне очень лень описывать в ридми. Документировать изменения сложнее, чем эти самые изменения вносить. Проще по коммитам ориентироваться. Поменялось много биндов и кор плагинов. Адаптировано для работы на neovim 0.11.

Тут будет лежать мой конфиг nvim. Я хочу, чтоб он был отдельно от nix конфигов, чтоб не надо было ничего ребилдить. 

Первый запуск конфига может быть долгим. Не прерывай этот процесс, пока не появится меню плагин манагера

Для выбора варианта из автокомплита надо жать ctrl+y, а не enter. Это можно исправить в конфиге, но я решил оставить так, как советует разраб kickstart.nvim, потому что я часто был в ситуации, когда готовая ide даёт мне вариант, но он мне не нужен, я уже написал свой, и мне надо перейти на новую строку, я жму enter и получаю комплит, который мне не нужен, мне новая строка нужна была.

Вкладки как в vscode я решил не делать, тут есть более удобный инструмент для этого. Например два раза нажать пробел в нормал моде, откроется меню буферов, тоесть файлов, которые в данный момент открыты. Отображаются они в порядке последнего открытия. Ныне открытый файл там не отображается. Это аналог ctrl+tab в vscode. Можно легко и быстро переключаться между "вкладками". Если надо искать что-то среди файлов проекта, то можно нажать пробел sf, от слов search files. В целом пробел+s это поиск чего-то. Подсказки на экране скажут поиск чего будет происходить. Grep поиск это поиск по содержимому всех файлов проекта.
https://medium.com/@jogarcia/you-dont-need-tabs-in-neovim-c6ba5ee44e3e

Если будут проблемы с сессиями, то можно написать `:SessionDelete`. Для выхода из проекта лучше использовать `:qa`, а не `:q`, чтоб закрыть все буферы и не ломать сессии

Конфиг сделан для NixOS. Я не знаю работает ли он в других дистрибутивах.

Сайт с топами плагинов и тем - https://dotfyle.com/neovim/colorscheme/top
LSP list - https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.txt

Логи для форматтеров `~/.local/state/nvim/conform.log`
Логи для lsp `~/.local/state/nvim/lsp.log`

> ⚠️ **Warning**: Некоторых lsp в mason не существует и их надо качать отдельно. Или они не работают в NixOS, если их качать через mason. Такие lsp я настроил отдельно и скачал как пакет. Из конфига mason я их удалил. **Не скачай случайно эти lsp через mason руками, когда они уже настроены как отдельный пакет**. Это же касается форматтеров и линтеров. Их я стараюсь качать как системный пакет, а не через mason.

> ⚠️ **Warning**: Я вообще перестал качать что либо через mason, используя его только как поиск разных инструментов для нужного мне языка. Так что лучше ничего не качать через него.

## Установка
На новом пк руками делаю симлинк в `~/.config/nvim`.

```sh
ln -s ~/nixos-private-dots/nvim ~/.config/nvim
```
### Зависимости

Для работы этого конфига надо установить некоторые пакеты в систему. Часть из них я напишу ниже, часть находится в `packages.nix` в категории `программирование`

Это мне пришлось скачать для работы конфига на NixOS с нужными мне инструментами:
- `neovim`
- `git`
- `unzip`
- `ripgrep`
- `fd`
- `xclip` на X11 или `wl-clipboard` на Wayland
- `tree-sitter`
- `ueberzugpp`
- Любой nerd font

Пакеты для разных языков могут часть меняться, так что ищем в `packages.nix`

Чтоб понять есть ли проблемы с конфигом, может какие-то пакеты отсутствуют, можно запустить `:checkhealth`.

## Изменить в будущем

Сейчас я сделал в стоке везде табуляцию в 4 символа на таб. Не пробелы. Если захочу это исправить и сделать per language настройки, то это можно сделать по разному. Сейчас у меня lsp/formatter сами заменяют табы на пробелы при сохранении файла.

Use `:h ftplugin` together with `:h :setlocal`
В каталоге nvim надо сделать каталог `ftplugin` и в него добавлять файлы `filetype.lua`. Например для python будет `python.lua`. И там можно писать настройки для каждого отдельного языка:
```lua
vim.bo.tabstop = 4 -- size of a hard tabstop (ts).
vim.bo.shiftwidth = 4 -- size of an indentation (sw).
vim.bo.expandtab = true -- always uses spaces instead of tab characters (et).
vim.bo.softtabstop = 4 -- number of spaces a <Tab> counts for. When 0, feature is off (sts)
```

Если не хочется возиться с тонной файлов, то можно добавить это в init.vim (надо переписать для init.lua):
```vim
autocmd BufEnter *.py :setlocal tabstop=4 shiftwidth=4 expandtab
autocmd BufEnter *.js :setlocal tabstop=2 shiftwidth=2 expandtab
```

Per project можно использовать `.editorconfig` файл в корне проекта. Нвим должен работать с его настройками.

## Бинды

Тут будет список биндов, которых нет в стандартном NeoVim

### Мои бинды

Все бинды можно искать прям в neovim, если нажать `Space s k`, тоесть `S`earch `K`eymaps

Я не помню откуда эти бинды, может они есть в стоке, а может нет, но они полезные.

| Bind                | Description                                             |
|---------------------|---------------------------------------------------------|
| `K`                 | Hover documentation                                     |
| `ctrl+o`            | Go back                                                 |
| `ctrl+i`            | Go forward (if you went backwards)                      |
| `p`                 | Paste from nvim register                                |
| `ctrl+shift+v`      | Paste from system clipboard                             |
| `y`                 | Yank(copy) to nvim register                             |
| `space y`           | Yank(copy) to system clipboard                          |
| `d`                 | Delete(copy) to nvim register                           |
| `space d`           | Delete(copy) to system clipboard                        |
| `alt + up/down/j/k` | Move lines in visual mode                               |
| `[d`                | Go to previous `D`iagnostic message                     |
| `]d`                | Go to next `D`iagnostic message                         |
| `space e`           | Show diagnostic `E`rror message                         |
| `space q`           | Open diagnostic `Q`uickfix                              |
| `ctrl+l`            | Перейти к следующему плейсхолдеру сниппета в insert mod |


Бинды в таблице ниже нажимаются без пробела перед ними. Просто бинд

| Bind      | Description                                                                                                                      | File           |
|-----------|----------------------------------------------------------------------------------------------------------------------------------|----------------|
| `esc esc` | Exit terminal mode (Or use `<C-\><C-n>` to exit terminal mode)                                                                   | settings.lua   |
| `esc`     | Creal highlights on search when pressing Esc in normal mode                                                                      | settings.lua   |
| `gp`      | `G`oto context (`p`arent)                                                                                                        | treesitter.lua |
| `gd`      | `G`oto `D`efinition                                                                                                              | lsp.lua        |
| `gr`      | `G`oto `R`eferences                                                                                                              | lsp.lua        |
| `gI`      | `G`oto `I`mplementation                                                                                                          | lsp.lua        |
| `gD`      | `G`oto `D`eclaration. This is not Goto Definition, this is Goto Declaration. For example, in C this would take you to the header | lsp.lua        |
| `gc`      | Toggle Comment from mini-comment plugin                                                                                          | -              |
| `\`       | Toggle file tree                                                                                                                 | file-tree.lua  |

Перед каждым из биндов в нижней таблице надо нажать `leader`, что есть `space`, пробел.

| Bind    | Description                                                                                                                                       | File           |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------|----------------|
| `tt`    | `T`oggle `T`erminal                                                                                                                               | terminal.lua   |
| `gta`   | `G`o `T`ag `A`dd. Add json tags for struct                                                                                                        | golang.lua     |
| `gtr`   | `G`o `T`ag `R`emove. Remove json tags for struct                                                                                                  | golang.lua     |
| `gs`    | `G`o fill `S`truct                                                                                                                                | golang.lua     |
| `gc`    | `G`o fill Switch `C`ase                                                                                                                           | golang.lua     |
| `gp`    | `G`o fix `P`lurals (change func foo(b int, a int, r int) -> func foo(b, a, r int))                                                                | golang.lua     |
| `ge`    | `G`o if `E`rr                                                                                                                                     | golang.lua     |
| `gi`    | `G`o `I`mports                                                                                                                                    | golang.lua     |
| `D`     | Type `D`efinition. Jump to the typo of the word under your cursor.                                                                                | lsp.lua        |
|         | Useful when you're not sure what type a variable is and you want to see the definition of its *type*, not where it was *defined*.                 |                |
| `ds`    | `D`ocument `S`ymbols. Fuzzy find all the symbols in your current document. Symbols are things like variables, funckions, types, etc.              | lsp.lua        |
| `ws`    | `W`orkspace `S`ymbols. Fuzzy find all the symbols in your currend workspace. Similar to document symbols, except searches over you entire project | lsp.lua        |
| `rn`    | `R`e`n`ame. Rename the variable under your cursor. Most Language Servers support renaming across files, etc.                                      | lsp.lua        |
| `ca`    | `C`ode `A`ction. Execute a code action, usually your cursor needs to be on top of an error or a suggestion from your LSP for this to activate     | lsp.lua        |
| `ss`    | `S`earch Document `S`ymbols                                                                                                                       | lsp.lua        |
| `sS`    | `S`earch `S`elect Telescope                                                                                                                       | health.lua     |
| `sh`    | `S`earch `H`elp                                                                                                                                   | health.lua     |
| `sk`    | `S`earch `K`eymaps                                                                                                                                | health.lua     |
| `sf`    | `S`earch `F`iles                                                                                                                                  | health.lua     |
| `sw`    | `S`earch current `W`ord                                                                                                                           | health.lua     |
| `sg`    | `S`earch by `G`rep                                                                                                                                | health.lua     |
| `sd`    | `S`earch `D`iagnostics                                                                                                                            | health.lua     |
| `sr`    | `S`earch `R`esume                                                                                                                                 | health.lua     |
| `s.`    | `S`earch Recent Files ("." for repeat)                                                                                                            | health.lua     |
| `space` | Find existing buffers. Аналог перелючения между вкладками                                                                                         | health.lua     |
| `/`     | Fuzzily search in current buffer                                                                                                                  | health.lua     |
| `s/`    | `S`earch `/` in Open Files. Live Grep in Open Files                                                                                               | health.lua     |
| `sn`    | `S`earch `N`eovim files. Shortcut for searching your Neovim configuration files                                                                   | health.lua     |
| `st`    | `S`earch `T`hemes                                                                                                                                 | health.lua     |
| `q`     | Open diagnostic `Q`uicfix list                                                                                                                    | settings.lua   |
| `f`     | `F`ormat buffer                                                                                                                                   | autoformat.lua |
| `Sd`        | `S`ession `D`elete                                                                                                                            | session.lua    |
| `Sc`        | `S`ession `C`reate                                                                                                                            | session.lua    |
| `Backspace` | Session restore                                                                                                                               | session.lua    |


### Git

Бинды начинаются с буквы `h`. Типо "Git `H`unk"

Без пробела

| Bind | Description                   | File         |
|------|-------------------------------|--------------|
| `]c` | Jump to next git `C`hange     | gitsigns.lua |
| `[c` | Jump to previous git `C`hange | gitsigns.lua |
Visual mode. С пробелом

| Bind | Description      | File         |
|------|------------------|--------------|
| `hs` | `S`tage git hunk | gitsigns.lua |
| `hr` | `R`eset git hunk | gitsigns.lua |
Normal mode. С пробелом

| Bind | Description                    | File         |
|------|--------------------------------|--------------|
| `hs` | Git `S`tage hunk               | gitsigns.lua |
| `hr` | Git `R`eset hunk               | gitsigns.lua |
| `hS` | Git `S`tage buffer             | gitsigns.lua |
| `hu` | Git `U`ndo stage hunk          | gitsigns.lua |
| `hR` | Git `R`eset buffer             | gitsigns.lua |
| `hp` | Git `P`review hunk             | gitsigns.lua |
| `hb` | Git `B`lame line               | gitsigns.lua |
| `hd` | Git `D`iff against index       | gitsigns.lua |
| `hD` | Git `D`iff against last commit | gitsigns.lua |
| `td` | `T`oggle git show `B`lame line | gitsigns.lua |
| `tD` | `T`oggle git show `D`eleted    | gitsigns.lua |
### Debug

Без пробела

| Bind | Description                    | File      |
|------|--------------------------------|-----------|
| `F5` | Debug: Start/Continue          | debug.lua |
| `F1` | Debug: Step Into               | debug.lua |
| `F2` | Debug: Step Over               | debug.lua |
| `F3` | Debug: Step Out                | debug.lua |
| `F7` | Debug: See last session rusult | debug.lua |
С пробелом

| Bind | Description                | File      |
|------|----------------------------|-----------|
| `b`  | Debug: Toggle `B`reakpoint | debug.lua |
| `B`  | Debug: Set `B`reakpoint    | debug.lua |


## Нюансы работы LSP/Linter/Formatter

Многие LSP в стоке имеют форматтирование кода. Иногда это бесит. Чтоб узнать какие LSP имеют форматирование в открытом в данный момент файле, можно использовать такую команду:
```lua
:lua for _, client in ipairs(vim.lsp.get_active_clients()) do print(client.name, client.server_capabilities.documentFormattingProvider) end
```
Чтоб выключить форматирование у LSP, можно заглянуть в `lsp.lua` и увидеть примеры кода. Например я выключил форматирование у `sqls` везде и у `html` в файлах `templ`. Если у всех выкл, но что-то форматирует, значит форматтер установлен отдельно. 

Некоторые LSP/Linter/Formatter не могут просто взять и заработать на каком-то файле. Например для работы `tailwindcss lsp` обязательным условием является `конфиг файл tailwind` в каталоге проекта, иначе ничего не будет работать. Для многих lsp важно находить `root dir`, который определяется по наличию каталога `.git` в проекте, иначе никаких подсказок в коде не будет. Разные инструменты для работы с SQL зачастую требуют делать конект к базе данных, иначе ничего работать не будет. Тоесть с удобством написать тестовый SQL код вне проекта не получится.

Я постарался исправить это там, где возможно. Например мне пришлось использовать `sqls` вместо `postgres_lsp`, чтоб подсказки работали даже вне проекта. Но зачастую придётся создавать проект и настраивать его, чтоб получить полноценный опыт IDE

- `TailwindCSS` требует иметь свой config файл в директории проекта
- `TypeScript LSP` имеет [опциональные настройки](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.txt#ts_ls)
- `YAML LSP` имеет [опциональные настройки](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.txt#yamlls)
- `JSON LSP` имеет [опциональные настройки](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.txt#jsonls)
- `rust-analyzer` имеет много опциональных настроек
- Чтоб `sql` работал внутри `.go` файлов, sql запросы надо писать внутри \`` так `\`. Тоесть внутри \` с пробелом в начале и конце, а не просто строка.
- `sqlfluff` требует иметь `.sqlfluff` в директории проекта. Вот пример конфига:
```toml
[sqlfluff]

# Supported dialects https://docs.sqlfluff.com/en/stable/dialects.html
# Or run 'sqlfluff dialects'
dialect = postgres

# One of [raw|jinja|python|placeholder]
templater = raw

# See https://stackoverflow.com/questions/608196/why-should-i-capitalize-my-sql-keywords-is-there-a-good-reason
[sqlfluff:rules:capitalisation.keywords]
capitalisation_policy = upper
[sqlfluff:rules:capitalisation.identifiers]
capitalisation_policy = lower
[sqlfluff:rules:capitalisation.functions]
extended_capitalisation_policy = lower
[sqlfluff:rules:capitalisation.literals]
capitalisation_policy = lower
[sqlfluff:rules:capitalisation.types]
extended_capitalisation_policy = lower
```


## Остальное

Мб потом добавлю сюда используемые плагины и для каких языков оно настроено.

Learn Lua https://learnxinyminutes.com/lua/

After understanding a bit more about Lua, you can use `:help lua-guide` as a reference for how Neovim integrates Lua. (or HTML version): https://neovim.io/doc/user/lua-guide.html

Use "`<space>sh`" to `[s]`earch the `[h]`elp documentation,

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info

