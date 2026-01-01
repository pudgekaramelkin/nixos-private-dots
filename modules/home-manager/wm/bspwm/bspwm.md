# bspc

Copy of `man bspc`

## Навигация

- [Узнать имя и класс окна](#узнать-имя-и-класс-окна)
- [Что такое ноды и селекторы](#что-такое-ноды-и-селекторы)
- [SELECTORS](#selectors)
    - [Node](#node)
        - [Descriptors](#descriptors)
        - [Path Jumps](#path-jumps)
        - [Modifiers](#modifiers)
    - [Desktop](#desktop)
        - [Descriptors](#descriptors-1)
        - [Modifiers](#modifiers-1)
    - [Monitor](#monitor)
        - [Descriptors](#descriptors-2)
        - [Modifiers](#modifiers-2)
- [WINDOW STATES](#window-states)
- [NODE FLAGS](#node-flags)
- [STACKING LAYERS](#stacking-layers)
- [RECEPTACLES](#receptacles)
- [DOMAINS](#domains)
    - [Node](#node-1)
    - [Desktop](#desktop-1)
    - [Monitor](#monitor-1)
    - [Query](#query)
    - [Wm](#wm)
    - [Rule](#rule)
    - [Config](#config)
    - [Subscribe](#subscribe)
    - [Quit](#quit)
- [EXIT CODES](#exit-codes)
- [SETTINGS](#settings)
    - [Global Settings](#global-settings)
    - [Monitor and Desktop Settings](#monitor-and-desktop-settings)
    - [Desktop Settings](#desktop-settings)
    - [Node Settings](#node-settings)
- [POINTER BINDINGS](#pointer-bindings)
- [EVENTS](#events)
- [REPORT FORMAT](#report-format)
- [ENVIRONMENT VARIABLES](#environment-variables)
- [Правила окон (bspc rule)](#правила-окон-bspc-rule)

## Узнать имя и класс окна

Чтобы узнать имя окна, пишем в терминал `xprop` и кликаем по нужному окну. Команда xprop выведет много информации о выбранном окне. Ищите строки, содержащие `WM_CLASS` и `WM_NAME`. Или просто используем grep:
```sh
xprop | grep -E 'WM_CLASS|WM_NAME' 
```

Будет что-то типо такого:
```sh
WM_CLASS(STRING) = "code", "Code"
WM_NAME(UTF8_STRING) = "bspwm.md - Visual Studio Code"
```

У `WM_CLASS` первое значение (code) это `instance_name`, второе значение (Code) это `class_name`. Узнал [тут](https://tronche.com/gui/x/xlib/ICC/client-to-window-manager/wm-class.html).

В `WM_NAME` написано имя окна

В `bspc rule` их можно указывать в следующем порядке `class_name:instance_name:name`. Если надо указать правила только по классу, то пишем лишь его. Если хочется по названию окна, то, как я понимаю, надо делать фул путь. Можно указать `*`, чтоб применить изменения ко всем окнам.

Пример:
```sh
bspc rule --add 'Gimp:myinstance:MyImage' state=floating
```

## Что такое ноды и селекторы?

Своими словами пока не могу объяснить, поэтому прикреплю ответ ChatGPT.

### Что такое "node" в `bspwm`?

В `bspwm` "node" — это базовый элемент, который может быть либо оконным элементом, либо контейнером (или рабочим пространством, или монитором). В `bspwm`, все элементы, с которыми вы работаете, рассматриваются как ноды в иерархической структуре. Давайте подробнее рассмотрим это:

1. **Node**:
   - **Окно**: Это может быть отдельное окно приложения, такое как терминал или браузер.
   - **Контейнер**: Это контейнер, который может содержать другие ноды (окна или контейнеры). Контейнеры могут быть горизонтальными или вертикальными, и они могут содержать рабочие столы.
   - **Рабочий стол**: Это рабочая область, на которой могут располагаться окна и контейнеры.
   - **Монитор**: Это физический монитор, на котором отображаются рабочие столы и окна.

### Как используются селекторы?

Селекторы в `bspwm` используются для выбора конкретных нод, рабочих столов или мониторов. Вот как это работает:

1. **Глобальные и относительные селекторы**:
   - **Глобальные селекторы**: Назначают уникальное имя или идентификатор для нод, которые могут быть использованы для их выбора в командах. Например, вы можете использовать имя рабочего стола или монитора, чтобы нацелиться на него напрямую.
   - **Относительные селекторы**: Используются для выбора нод относительно текущего состояния или фокуса. Например, можно выбрать следующую или предыдущую ноду относительно текущей активной ноды.

2. **Примеры команд с селекторами**:
   - **Выбор ноды по имени**:
     ```sh
     bspc node -d ^2
     ```
     Это переключит текущую ноду на рабочий стол с именем `2`.

   - **Перемещение ноды**:
     ```sh
     bspc node -s east
     ```
     Это переместит текущую ноду в направлении востока от его текущего положения.

   - **Переключение на рабочий стол**:
     ```sh
     bspc desktop -f '^3'
     ```
     Это переключит фокус на рабочий стол с именем `3`.

### Как это выглядит в конфигурации?

В вашем `.config/bspwm/bspwmrc` файле и в командах `bspc`, вы будете использовать селекторы, чтобы указать, какую ноду вы хотите настроить или изменить. Например:

```sh
bspc monitor -d I II III IV V
```

Здесь селекторы `I`, `II`, `III`, `IV`, `V` используются для задания рабочих столов на текущем мониторе.

### Примеры селекторов

- **Глобальные селекторы**:
  - `^1` — выбирает рабочий стол с именем `1`.
  - `^2` — выбирает рабочий стол с именем `2`.

- **Относительные селекторы**:
  - `next` — выбирает следующую ноду в порядке, в котором они расположены.
  - `prev` — выбирает предыдущую ноду.

### Заключение

В `bspwm`, "node" — это основное понятие, которое представляет собой любой элемент, который может быть оконным или контейнером. Селекторы используются для выбора и управления этими нодами. Понимание того, как использовать селекторы для выбора нод, позволяет более эффективно управлять оконным менеджером и настроить рабочее пространство по вашему вкусу.

## SELECTORS

Selectors are used to select a target node, desktop, or monitor. A selector can either describe the target relatively or name it globally.

Selectors consist of an optional reference, a descriptor and any number of non-conflicting modifiers as follows:

`[REFERENCE#]DESCRIPTOR(.MODIFIER)*`

The relative targets are computed in relation to the given reference (the default reference value is focused).

An exclamation mark can be prepended to any modifier in order to reverse its meaning.

The following characters cannot be used in monitor or desktop names: #, :, ..

The special selector %<name> can be used to select a monitor or a desktop with an invalid name.

### Node

Select a node.

```
NODE_SEL := [NODE_SEL#]
    (DIR|CYCLE_DIR|PATH|any|first_ancestor|last|newest|
    older|newer|focused|pointed|biggest|smallest|<node_id>)
    [.[!]focused]
    [.[!]active]
    [.[!]automatic]
    [.[!]local]
    [.[!]leaf]
    [.[!]window]
    [.[!]STATE]
    [.[!]FLAG]
    [.[!]LAYER]
    [.[!]SPLIT_TYPE]
    [.[!]same_class]
    [.[!]descendant_of]
    [.[!]ancestor_of]
```

- **STATE**: `tiled` | `pseudo_tiled` | `floating` | `fullscreen`
- **FLAG**: `hidden` | `sticky` | `private` | `locked` | `marked` | `urgent`
- **LAYER**: `below` | `normal` | `above`
- **SPLIT_TYPE**: `horizontal` | `vertical`
- **PATH**: `@[DESKTOP_SEL:][[/]JUMP](/JUMP)*`
- **JUMP**: `first` | `1` | `second` | `2` | `brother` | `parent` | `DIR`

#### Descriptors

- `DIR`
Selects the window in the given (spacial) direction relative to the reference node.

- `CYCLE_DIR`
Selects the node in the given (cyclic) direction relative to the reference node within a depth-first in-order traversal of the tree.

- `PATH`
Selects the node at the given path.

- `any`
Selects the first node that matches the given selectors.

- `first_ancestor`
Selects the first ancestor of the reference node that matches the given selectors.

- `last`
Selects the previously focused node relative to the reference node.

- `newest`
Selects the newest node in the history of the focused node.

- `older`
Selects the node older than the reference node in the history.

- `newer`
Selects the node newer than the reference node in the history.

- `focused`
Selects the currently focused node.

- `pointed`
Selects the leaf under the pointer.

- `biggest`
Selects the biggest leaf.

- `smallest`
Selects the smallest leaf.

- `<node_id\`
Selects the node with the given ID.

#### Path Jumps

The initial node is the focused node (or the root if the path starts with /) of the reference desktop (or the selected desktop if the path has a `DESKTOP_SEL` prefix).

- `1|first`
Jumps to the first child.

- `2|second`
Jumps to the second child.

- `brother`
Jumps to the brother node.

- `parent`
Jumps to the parent node.

- `DIR`
Jumps to the node holding the edge in the given direction.

#### Modifiers

- `[!]focused`
Only consider the focused node.

- `[!]active`
Only consider nodes that are the focused node of their desktop.

- `[!]automatic`
Only consider nodes in automatic insertion mode. See also --presel-dir under Node in the DOMAINS section below.

- `[!]local`
Only consider nodes in the reference desktop.

- `[!]leaf`
Only consider leaf nodes.

- `[!]window`
Only consider nodes that hold a window.

- `[!](tiled|pseudo_tiled|floating|fullscreen)`
Only consider windows in the given state.

- `[!]same_class`
Only consider windows that have the same class as the reference window.

- `[!]descendant_of`
Only consider nodes that are descendants of the reference node.

- `[!]ancestor_of`
Only consider nodes that are ancestors of the reference node.

- `[!](hidden|sticky|private|locked|marked|urgent)`
Only consider windows that have the given flag set.

- `[!](below|normal|above)`
Only consider windows in the given layer.

- `[!](horizontal|vertical)`
Only consider nodes with the given split type.

### Desktop

Select a desktop.

```
DESKTOP_SEL := [DESKTOP_SEL#]
    (CYCLE_DIR|any|last|newest|older|newer|[MONITOR_SEL:](focused|^<n>)|<desktop_id>|<desktop_name>)
    [.[!]focused]
    [.[!]active]
    [.[!]occupied]
    [.[!]urgent]
    [.[!]local]
```

#### Descriptors

- `CYCLE_DIR`
Selects the desktop in the given direction relative to the reference desktop.

- `any`
Selects the first desktop that matches the given selectors.

- `last`
Selects the previously focused desktop relative to the reference desktop.

- `newest`
Selects the newest desktop in the history of the focused desktops.

- `older`
Selects the desktop older than the reference desktop in the history.

- `newer`
Selects the desktop newer than the reference desktop in the history.

- `focused`
Selects the currently focused desktop.

- `^<n>`
Selects the nth desktop. If MONITOR_SEL is given, selects the nth desktop on the selected monitor.

- `<desktop_id>`
Selects the desktop with the given ID.

- `<desktop_name>`
Selects the desktop with the given name.

#### Modifiers

- `[!]focused`
Only consider the focused desktop.

- `[!]active`
Only consider desktops that are the focused desktop of their monitor.

- `[!]occupied`
Only consider occupied desktops.

- `[!]urgent`
Only consider urgent desktops.

- `[!]local`
Only consider desktops inside the reference monitor.

### Monitor

Select a monitor.

```
MONITOR_SEL := [MONITOR_SEL#]
    (DIR|CYCLE_DIR|any|last|newest|older|newer|focused|pointed|primary|^<n>|<monitor_id>|<monitor_name>)
    [.[!]focused]
    [.[!]occupied]
```

#### Descriptors

- `DIR`
Selects the monitor in the given (spacial) direction relative to the reference monitor.

- `CYCLE_DIR`
Selects the monitor in the given (cyclic) direction relative to the reference monitor.

- `any`
Selects the first monitor that matches the given selectors.

- `last`
Selects the previously focused monitor relative to the reference monitor.

- `newest`
Selects the newest monitor in the history of the focused monitors.

- `older`
Selects the monitor older than the reference monitor in the history.

- `newer`
Selects the monitor newer than the reference monitor in the history.

- `focused`
Selects the currently focused monitor.

- `pointed`
Selects the monitor under the pointer.

- `primary`
Selects the primary monitor.

- `^<n>`
Selects the nth monitor.

- `<monitor_id>`
Selects the monitor with the given ID.

- `<monitor_name>`
Selects the monitor with the given name.

#### Modifiers

- `[!]focused`
Only consider the focused monitor.

- `[!]occupied`
Only consider monitors where the focused desktop is occupied.

## WINDOW STATES

- `tiled`
Its size and position are determined by the window tree.

- `pseudo_tiled`
A tiled window that automatically shrinks but doesn’t stretch beyond its floating size.

- `floating`
Can be moved/resized freely. Although it doesn’t use any tiling space, it is still part of the window tree.

- `fullscreen`
Fills its monitor rectangle and has no borders.

## NODE FLAGS

- `hidden`
Is hidden and doesn’t occupy any tiling space.

- `sticky`
Stays in the focused desktop of its monitor.

- `private`
Tries to keep the same tiling position/size.

- `locked`
Ignores the node --close message.

- `marked`
Is marked (useful for deferred actions). A marked node becomes unmarked after being sent on a preselected node.

- `urgent`
Has its urgency hint set. This flag is set externally.


## STACKING LAYERS

There’s three stacking layers: `BELOW`, `NORMAL` and `ABOVE`.

In each layer, the window are orderered as follow: tiled & pseudo-tiled < floating < fullscreen.

## RECEPTACLES

A leaf node that doesn’t hold any window is called a receptacle. When a node is inserted on a receptacle in automatic mode, it will replace the receptacle. A receptacle can be inserted on a node, preselected and killed. Receptacles can therefore be used to build a tree whose leaves are receptacles. Using the appropriate rules, one can then send windows on the leaves of this tree. This feature is used in examples/receptacles to store and recreate layouts.

## DOMAINS

### Node

#### General Syntax

`node [NODE_SEL] COMMANDS`

If `NODE_SEL` is omitted, focused is assumed.

#### Commands

- `-f, --focus [NODE_SEL]`
Focus the selected or given node.

- `-a, --activate [NODE_SEL]`
Activate the selected or given node.

- `-d, --to-desktop DESKTOP_SEL [--follow]`
Send the selected node to the given desktop. If --follow is passed, the focused node will stay focused.

- `-m, --to-monitor MONITOR_SEL [--follow]`
Send the selected node to the given monitor. If --follow is passed, the focused node will stay focused.

- `-n, --to-node NODE_SEL [--follow]`
Send the selected node on the given node. If --follow is passed, the focused node will stay focused.

- `-s, --swap NODE_SEL [--follow]`
Swap the selected node with the given node. If --follow is passed, the focused node will stay focused.

- `-p, --presel-dir [~]DIR|cancel`
Preselect the splitting area of the selected node (or cancel the preselection). If ~ is prepended to DIR and the current preselection direction matches DIR, then the argument is interpreted as cancel. A node with a preselected area is said to be in "manual insertion mode".

- `-o, --presel-ratio RATIO`
Set the splitting ratio of the preselection area.

- `-v, --move dx dy`
Move the selected window by dx pixels horizontally and dy pixels vertically.

- `-z, --resize top|left|bottom|right|top_left|top_right|bottom_right|bottom_left dx dy`
Resize the selected window by moving the given handle by dx pixels horizontally and dy pixels vertically.

- `-r, --ratio RATIO|(+|-)(PIXELS|FRACTION)`
Set the splitting ratio of the selected node (0 < RATIO < 1).

- `-R, --rotate 90|270|180`
Rotate the tree rooted at the selected node.

- `-F, --flip horizontal|vertical`
Flip the the tree rooted at selected node.

- `-E, --equalize`
Reset the split ratios of the tree rooted at the selected node to their default value.

- `-B, --balance`
Adjust the split ratios of the tree rooted at the selected node so that all windows occupy the same area.

- `-C, --circulate forward|backward`
Circulate the windows of the tree rooted at the selected node.

- `-t, --state [~](tiled|pseudo_tiled|floating|fullscreen)`
Set the state of the selected window. If ~ is present and the current state matches the given state, then the argument is interpreted as the last state.

- `-g, --flag hidden|sticky|private|locked|marked[=on|off]`
Set or toggle the given flag for the selected node.

- `-l, --layer below|normal|above`
Set the stacking layer of the selected window.

- `-i, --insert-receptacle`
Insert a receptacle node at the selected node.

- `-c, --close`
Close the windows rooted at the selected node.

- `-k, --kill`
Kill the windows rooted at the selected node.


### Desktop

#### General Syntax

`desktop [DESKTOP_SEL] COMMANDS`

If `DESKTOP_SEL` is omitted, focused is assumed.

#### COMMANDS

- `-f, --focus [DESKTOP_SEL]`
Focus the selected or given desktop.

- `-a, --activate [DESKTOP_SEL]`
Activate the selected or given desktop.

- `-m, --to-monitor MONITOR_SEL [--follow]`
Send the selected desktop to the given monitor. If --follow is passed, the focused desktop will stay focused.

- `-s, --swap DESKTOP_SEL [--follow]`
Swap the selected desktop with the given desktop. If --follow is passed, the focused desktop will stay focused.

- `-l, --layout CYCLE_DIR|monocle|tiled`
Set or cycle the layout of the selected desktop.

- `-n, --rename <new_name>`
Rename the selected desktop.

- `-b, --bubble CYCLE_DIR`
Bubble the selected desktop in the given direction.

- `-r, --remove`
Remove the selected desktop.

### Monitor

#### General Syntax

`monitor [MONITOR_SEL] COMMANDS`

If `MONITOR_SEL` is omitted, focused is assumed.

#### Commands

- `-f, --focus [MONITOR_SEL]`
Focus the selected or given monitor.

- `-s, --swap MONITOR_SEL`
Swap the selected monitor with the given monitor.

- `-a, --add-desktops <name>...`
Create desktops with the given names in the selected monitor.

- `-o, --reorder-desktops <name>...`
Reorder the desktops of the selected monitor to match the given order.

- `-d, --reset-desktops <name>...`
Rename, add or remove desktops depending on whether the number of given names is equal, superior or inferior to the number of existing desktops.

- `-g, --rectangle WxH+X+Y`
Set the rectangle of the selected monitor.

- `-n, --rename <new_name>`
Rename the selected monitor.

- `-r, --remove`
Remove the selected monitor.


### Query

#### General Syntax

`query COMMANDS [OPTIONS]`

#### Commands

The optional selectors are references.

- `-N, --nodes [NODE_SEL]`
List the IDs of the matching nodes.

- `-D, --desktops [DESKTOP_SEL]`
List the IDs (or names) of the matching desktops.

- `-M, --monitors [MONITOR_SEL]`
List the IDs (or names) of the matching monitors.

- `-T, --tree`
Print a JSON representation of the matching item.

#### Options

`-m,--monitor [MONITOR_SEL], -d,--desktop [DESKTOP_SEL], -n, --node [NODE_SEL]`
Constrain matches to the selected monitor, desktop or node. The descriptor can be omitted for -M, -D and -N.

`--names`
Print names instead of IDs. Can only be used with -M and -D.


### Wm

#### General Syntax

`wm COMMANDS`

#### Commands

- `-d, --dump-state`
Dump the current world state on standard output.

- `-l, --load-state <file_path>`
Load a world state from the given file. The path must be absolute.

- `-a, --add-monitor <name> WxH+X+Y`
Add a monitor for the given name and rectangle.

- `-O, --reorder-monitors <name>...`
Reorder the list of monitors to match the given order.

- `-o, --adopt-orphans`
Manage all the unmanaged windows remaining from a previous session.

- `-h, --record-history on|off`
Enable or disable the recording of node focus history.

- `-g, --get-status`
Print the current status information.

- `-r, --restart`
Restart the window manager


### Rule

#### General Syntax

`rule COMMANDS`

#### Commands

Create a new rule.
```sh
-a, --add (<class_name>|*)[:(<instance_name>|*)[:(<name>|*)]] 
    [-o|--one-shot] 
    [monitor=MONITOR_SEL|desktop=DESKTOP_SEL|node=NODE_SEL] 
    [state=STATE] 
    [layer=LAYER] 
    [split_dir=DIR] 
    [split_ratio=RATIO] 
    [(hidden|sticky|private|locked|marked|center|follow|manage|focus|border)=(on|off)] 
    [rectangle=WxH+X+Y]
```


- `-r, --remove ^<n>|head|tail|(<class_name>|*)[:(<instance_name>|*)[:(<name>|\*)]]...`
Remove the given rules.

- `-l, --list`
List the rules.


### Config

#### General Syntax

`config [-m MONITOR_SEL|-d DESKTOP_SEL|-n NODE_SEL] <setting> [<value>]`

Get or set the value of <setting>.


### Subscribe

#### General Syntax

`subscribe [OPTIONS] (all|report|monitor|desktop|node|...)*`

Continuously print events. See the EVENTS section for the description of each event.

#### Options

- `-f, --fifo`
Print a path to a FIFO from which events can be read and return.

- `-c, --count COUNT`
Stop the corresponding bspc process after having received COUNT events.


### Quit

#### General Syntax

`quit [<status>]`

Quit with an optional exit status.


## EXIT CODES

If the server can’t handle a message, bspc will return with a non-zero exit code.

## SETTINGS

Colors are in the form `#RRGGBB`, booleans are `true`, `on`, `false` or `off`.

All the boolean settings are false by default unless stated otherwise.

### Global Settings

- `normal_border_color`
Color of the border of an unfocused window.

- `active_border_color`
Color of the border of a focused window of an unfocused monitor.

- `focused_border_color`
Color of the border of a focused window of a focused monitor.

- `presel_feedback_color`
Color of the `node --presel-{dir,ratio}` message feedback area.

- `split_ratio`
Default split ratio.

- `status_prefix`
Prefix prepended to each of the status lines.

- `external_rules_command`
Absolute path to the command used to retrieve rule consequences. The command will receive the following arguments: `window ID`, `class name`, `instance name`, and `intermediate consequences`. The output of that command must have the following format: `key1=value1 key2=value2` ... (the valid key/value pairs are given in the description of the rule command).

- `automatic_scheme`
The insertion scheme used when the insertion point is in automatic mode. Accept the following values: `longest_side`, `alternate`, `spiral`.

- `initial_polarity`
On which child should a new window be attached when adding a window on a single window tree in automatic mode. Accept the following values: `first_child`, `second_child`.

- `directional_focus_tightness`
The tightness of the algorithm used to decide whether a window is on the DIR side of another window. Accept the following values: `high`, `low`.

- `removal_adjustment`
Adjust the brother when unlinking a node from the tree in accordance with the automatic insertion scheme.

- `presel_feedback`
Draw the preselection feedback area. Defaults to `true`.

- `borderless_monocle`
Remove borders of tiled windows for the `monocle` desktop layout.

- `gapless_monocle`
Remove gaps of tiled windows for the `monocle` desktop layout.

`top_monocle_padding, right_monocle_padding, bottom_monocle_padding, - left_monocle_padding`
Padding space added at the sides of the screen for the `monocle` desktop layout.

- `single_monocle`
Set the desktop layout to `monocle` if there’s only one tiled window in the tree.

- `pointer_motion_interval`
The minimum interval, in milliseconds, between two motion notify events.

- `pointer_modifier`
Keyboard modifier used for moving or resizing windows. Accept the following values: `shift`, `control`, `lock`, `mod1`, `mod2`, `mod3`, `mod4`, `mod5`.

- `pointer_action1, pointer_action2, pointer_action3`
Action performed when pressing `pointer_modifier` + `button<n>`. Accept the following values: `move`, `resize_side`, `resize_corner`, `focus`, `none`.

- `click_to_focus`
Button used for focusing a window (or a monitor). The possible values are: `button1`, `button2`, `button3`, `any`, `none`. Defaults to `button1`.

- `swallow_first_click`
Don’t replay the click that makes a window focused if `click_to_focus` isn’t `none`.

- `focus_follows_pointer`
Focus the window under the pointer.

- `pointer_follows_focus`
When focusing a window, put the pointer at its center.

- `pointer_follows_monitor`
When focusing a monitor, put the pointer at its center.

- `mapping_events_count`
Handle the next mapping_events_count mapping notify events. A negative value implies that every event needs to be handled.

- `ignore_ewmh_focus`
Ignore EWMH focus requests coming from applications.

- `ignore_ewmh_fullscreen`
Block the fullscreen state transitions that originate from an EWMH request. The possible values are: `none`, `all`, or a comma separated list of the following values: `enter`, `exit`.

- `ignore_ewmh_struts`
Ignore strut hinting from clients requesting to reserve space (i.e. task bars).

- `center_pseudo_tiled`
Center pseudo tiled windows into their tiling rectangles. Defaults to `true`.

- `honor_size_hints`
Apply ICCCM window size hints.

- `remove_disabled_monitors`
Consider disabled monitors as disconnected.

- `remove_unplugged_monitors`
Remove unplugged monitors.

- `merge_overlapping_monitors`
Merge overlapping monitors (the bigger remains).

### Monitor and Desktop Settings

- `top_padding, right_padding, bottom_padding, left_padding`
Padding space added at the sides of the monitor or desktop.

### Desktop Settings

- `window_gap`
Size of the gap that separates windows.

### Node Settings

- `border_width`
Window border width.

## POINTER BINDINGS

- `click_to_focus`
Focus the window (or the monitor) under the pointer if the value isn’t none.

- `pointer_modifier + button1`
Move the window under the pointer.

- `pointer_modifier + button2`
Resize the window under the pointer by dragging the nearest side.

- `pointer_modifier + button3`
Resize the window under the pointer by dragging the nearest corner.

The behavior of `pointer_modifier` + `button<n>` can be modified through the `pointer_action<n>` setting.

## EVENTS

- `report`
See the next section for the description of the format.

- `monitor_add <monitor_id> <monitor_name> <monitor_geometry>`
A monitor is added.

- `monitor_rename <monitor_id> <old_name> <new_name>`
A monitor is renamed.

- `monitor_remove <monitor_id>`
A monitor is removed.

- `monitor_swap <src_monitor_id> <dst_monitor_id>`
A monitor is swapped.

- `monitor_focus <monitor_id>`
A monitor is focused.

- `monitor_geometry <monitor_id> <monitor_geometry>`
The geometry of a monitor changed.

- `desktop_add <monitor_id> <desktop_id> <desktop_name>`
A desktop is added.

- `desktop_rename <monitor_id> <desktop_id> <old_name> <new_name>`
A desktop is renamed.

- `desktop_remove <monitor_id> <desktop_id>`
A desktop is removed.

- `desktop_swap <src_monitor_id> <src_desktop_id> <dst_monitor_id> <dst_desktop_id>`
A desktop is swapped.

- `desktop_transfer <src_monitor_id> <src_desktop_id> <dst_monitor_id>`
A desktop is transferred.

- `desktop_focus <monitor_id> <desktop_id>`
A desktop is focused.

- `desktop_activate <monitor_id> <desktop_id>`
A desktop is activated.

- `desktop_layout <monitor_id> <desktop_id> tiled|monocle`
The layout of a desktop changed.

- `node_add <monitor_id> <desktop_id> <ip_id> <node_id>`
A node is added.

- `node_remove <monitor_id> <desktop_id> <node_id>`
A node is removed.

- `node_swap <src_monitor_id> <src_desktop_id> <src_node_id> <dst_monitor_id> <dst_desktop_id> <dst_node_id>`
A node is swapped.

- `node_transfer <src_monitor_id> <src_desktop_id> <src_node_id> <dst_monitor_id> <dst_desktop_id> <dst_node_id>`
A node is transferred.

- `node_focus <monitor_id> <desktop_id> <node_id>`
A node is focused.

- `node_activate <monitor_id> <desktop_id> <node_id>`
A node is activated.

- `node_presel <monitor_id> <desktop_id> <node_id> (dir DIR|ratio RATIO|cancel)`
A node is preselected.

- `node_stack <node_id_1> below|above <node_id_2>`
A node is stacked below or above another node.

- `node_geometry <monitor_id> <desktop_id> <node_id> <node_geometry>`
The geometry of a window changed.

- `node_state <monitor_id> <desktop_id> <node_id> tiled|pseudo_tiled|floating|fullscreen on|off`
The state of a window changed.

- `node_flag <monitor_id> <desktop_id> <node_id> hidden|sticky|private|locked|marked|urgent on|off`
One of the flags of a node changed.

- `node_layer <monitor_id> <desktop_id> <node_id> below|normal|above`
The layer of a window changed.

- `pointer_action <monitor_id> <desktop_id> <node_id> move|resize_corner|resize_side begin|end`
A pointer action occurred.

Please note that bspwm initializes monitors before it reads messages on its socket, therefore the initial monitor events can’t be received.

## REPORT FORMAT

Each report event message is composed of items separated by colons.

Each item has the form `<type><value>` where `<type>` is the first character of the item.

`M<monitor_name>`
Focused monitor.

`m<monitor_name>`
Unfocused monitor.

`O<desktop_name>`
Occupied focused desktop.

`o<desktop_name>`
Occupied unfocused desktop.

`F<desktop_name>`
Free focused desktop.

`f<desktop_name>`
Free unfocused desktop.

`U<desktop_name>`
Urgent focused desktop.

`u<desktop_name>`
Urgent unfocused desktop.

`L(T|M)`
Layout of the focused desktop of a monitor.

`T(T|P|F|=|@)`
State of the focused node of a focused desktop.

`G(S?P?L?M?)`
Active flags of the focused node of a focused desktop.

## ENVIRONMENT VARIABLES

- `BSPWM_SOCKET`
The path of the socket used for the communication between bspc and bspwm. If it isn’t defined, then the following path is used: `/tmp/bspwm<host_name>_<display_number>_<screen_number>-socket.`














## Правила окон (bspc rule)

Все параметры и их описание для [MONITOR_SEL](#monitor), [DESKTOP_SEL](#desktop) и [NODE_SEL](#node) указаны выше

Текст ниже написан через ChatGPT, потому что разрабы ничего не пишут

### monitor = MONITOR_SEL
Устанавливает монитор, на котором должно появляться окно. Можно указать конкретный монитор, используя его имя или идентификатор. Если монитор не указан, используется текущий фокусный монитор.
Возможные параметры:
- `monitor1` — Окно будет размещено на монитор1.
- `monitor2` — Окно будет размещено на монитор2.
- `primary` — Окно будет размещено на основной монитор.

**Пример:**
```sh
bspc rule -a 'firefox' monitor=monitor2
```

### desktop = DESKTOP_SEL
Устанавливает рабочий стол, на котором должно появляться окно. Можно указать конкретный рабочий стол по его имени или номеру.
Возможные параметры:
- `^1` — Окно будет размещено на рабочем столе 1.
- `^2` — Окно будет размещено на рабочем столе 2.
- `^myDesktop` — Окно будет размещено на рабочем столе с именем `myDesktop`.

**Пример:**
```sh
bspc rule -a 'chrome' desktop='^2'
```

### node = NODE_SEL
Определяет, какой узел (окно) следует выбрать. Можно указать узел относительно текущего фокусного окна или по идентификатору узла.
Возможные параметры:
- `focused` — Фокусное окно.
- `newest` — Новейшее окно.
- `@/desktop1` — Узел по пути.

**Пример:**
```sh
bspc rule -a 'terminal' node=focused
```

### state = STATE
Устанавливает состояние окна.
Возможные параметры:
- `tiled` — Плиточный.
- `pseudo_tiled` — Псевдоплиточный.
- `floating` — Плавающий.
- `fullscreen` — На весь экран.

**Пример:**
```sh
bspc rule -a 'gimp' state=floating
```

### layer = LAYER
Устанавливает уровень, на котором окно должно быть отображено.
Возможные параметры:
- `below` — Под окнами.
- `normal` — Нормальный.
- `above` — Над окнами.

**Пример:**
```sh
bspc rule -a 'polybar' layer=above
```

### split_dir = DIR
Определяет направление разделения окна.
Возможные параметры:
- `horizontal` — Горизонтальное.
- `vertical` — Вертикальное.

**Пример:**
```sh
bspc rule -a 'editor' split_dir=horizontal
```

### split_ratio = RATIO
Устанавливает соотношение размеров при разделении окна. Значение от 0 до 1.
Возможные параметры:
- `0.5` — Равное разделение.
- `0.3` — Разделение с доминирующей одной частью.

**Пример:**
```sh
bspc rule -a 'browser' split_ratio=0.3
```

### hidden = on/off
Устанавливает видимость окна.
Возможные параметры:
- `on` — Скрыть окно.
- `off` — Показать окно.

**Пример:**
```sh
bspc rule -a 'notifications' hidden=on
```

### sticky = on/off
Устанавливает, должно ли окно оставаться видимым на всех рабочих столах.
Возможные параметры:
- `on` — Всегда видимо.
- `off` — Не видимо на всех рабочих столах.

**Пример:**
```sh
bspc rule -a 'systemtray' sticky=on
```

### private = on/off
Устанавливает, является ли окно приватным. Приватные окна не будут отображаться в списках окон.
Возможные параметры:
- `on` — Приватное окно.
- `off` — Обычное окно.

**Пример:**
```sh
bspc rule -a 'settings' private=on
```

### locked = on/off
Устанавливает, будет ли окно заблокировано и не сможет быть перемещено или изменено.
Возможные параметры:
- `on` — Заблокировано.
- `off` — Разблокировано.

**Пример:**
```sh
bspc rule -a 'video-player' locked=on
```

### marked = on/off
Устанавливает, отмечено ли окно. Отмеченные окна могут использоваться для специальных целей, таких как привязка к горячим клавишам.
Возможные параметры:
- `on` — Отмечено.
- `off` — Не отмечено.

**Пример:**
```sh
bspc rule -a 'browser' marked=on
```

### center = on/off
Устанавливает, должно ли окно быть центрировано на рабочем столе. Вроде окно должно быть `floating` для этого. 
Возможные параметры:
- `on` — Центрировать окно.
- `off` — Не центрировать окно.

**Пример:**
```sh
bspc rule -a 'dialog' center=on
```

### follow = on/off
Устанавливает, будет ли окно следовать за фокусом. Если включено, окно будет следовать за фокусом текущего окна.
Возможные параметры:
- `on` — Следовать за фокусом.
- `off` — Не следовать за фокусом.

**Пример:**
```sh
bspc rule -a 'chat' follow=on
```

### manage = on/off

Устанавливает, должно ли окно управляться оконным менеджером. 

Если установлено `off`, то окно будет работать независимо от оконного менеджера. Оно может работать как "надстраница" или "плавающее окно", но независимо от управления его размерами и позицией.

Пример использования: Screenkey — это инструмент для отображения на экране нажатий клавиш. Его полезно видеть постоянно, чтобы следить за тем, какие клавиши нажимаются, особенно при записи видеоуроков или презентаций. Сделав его "независимым", вы обеспечиваете его постоянное присутствие на экране без влияния bspwm, который может изменить его положение или размер. Таким образом, установка manage=off для Screenkey делает его "особенным" в глазах bspwm, позволяя работать вне стандартного управления окнами и обеспечивая его постоянное отображение без вмешательства оконного менеджера.

Возможные параметры:
- `on` — Управлять окном.
- `off` — Не управлять окном.

**Пример:**
```sh
bspc rule -a Screenkey manage=off
```

### focus = on/off
Устанавливает, должно ли окно получать фокус при создании.
Возможные параметры:
- `on` — Получить фокус.
- `off` — Не получать фокус.

**Пример:**
```sh
bspc rule -a 'terminal' focus=on
```

### border = on/off
Устанавливает, должен ли у окна быть видимый бордер.
Возможные параметры:
- `on` — Показать бордер.
- `off` — Скрыть бордер.

**Пример:**
```sh
bspc rule -a 'browser' border=off
```

### rectangle = WxH+X+Y
Устанавливает положение и размеры окна в виде прямоугольника.
Возможные параметры:
- `800x600+100+100` — Ширина 800 пикселей, высота 600 пикселей, смещение по X и Y.

**Пример:**
```sh
bspc rule -a 'editor' rectangle=1024x768+100+50
```

Этот формат описания и примеры помогут вам более четко понять, как использовать различные параметры `bspc rule` для настройки окон в `bspwm`.