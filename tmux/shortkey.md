# Tmux Shortkeys

## Table of Contents
## Learning The Basic

- [Starting tmux](#starting-tmux)
- [Command Prefix](#command-prefix)
- [Detaching and Attaching Sessions](#detaching-and-attaching-sessions)
- [Working with Windows](#working-with-windows)
- [Working with Panes](#working-with-panes)
- [Working with Command Mode](#working-with-command-mode)

---
##  Configuring tmux
- [Introducing the tmux.conf](#introducing-the-tmux_conf)

# Starting tmux

Starting tmux and creating named session
```
$ tmux new-session -s basic
```
   or 

```
$ tmux new -s basic
```
## Help
By pressing `Prefix` `?`, you can get a list of all predefined tmux keybindings and the associated commands these trigger.

# Command Prefix
The `Ctrl` - `b` combination does just that. This combination is called the *command prefix* also kwnow as `Prefix`.

Use the default of `Ctrl` - `b` whenever you see `Prefix`.

To start clock inside tmux press `Ctrl` - `b`, then press `t`. A large clock will appear on the screen.


# Detaching and Attaching Sessions
## Detaching sesssion
Detach from the tmux session by pressing `Prefix` `d`.

## List sessions
List existing tmux sessions using the command:
```
$ tmux list-sessions
```
or
```
$ tmux ls
```

## Attach to session
To attach to the session, use the `attach` keyword. If you only have one session running, you can simply use:
```
$ tmux attach
```
You can attach to the session you want by using the `-t` flag, followed by the session name. Run the following command:
``` 
$ tmux attach -t seccond_session
```

## Killing Sessions
You can type `exit` within a session to destroy the session, but you can also kill off sessions with the `kill-session `command. It works just like tmux attach:
```
$ tmux kill-session -t second_session
```

# Working with Windows
It’s possible, and very common, to run multiple, simultaneous commands within a tmux session. We can keep these organized with windows, which are similar to tabs in modern graphical terminal emulators or web browsers.

## Creating and Naming Windows
Create a named session called “windows,” like this:
```
tmux new -s windows -n shell
```
By using the `-n` flag, we tell tmux to name the first window so we can identify it easily.

To create a window in a current session, press `Prefix` `c`. Creating a window like this automatically brings the new window into focus.

## Rename window
To rename window press `Prefix` followed by `,` (a comma), and then the status line changes, lettting you rename the current window.

## Moving Between Windows
You can quickly move between windows with `Prefix` `n` for "*next* window" and `Prefix` `p` to go to the *previous* window.

You can quickly jump to the first window with `Prefix` `0`, and the second window with `Prefix` `1`.

## Display visual menu 
If you end up with more than nine windows, you can use `Prefix` `w` to display a *`visual menu`*

## Close the window
To close a window, you can either type `“exit”` into the prompt in the window, or you can use `Prefix` `&`, which displays a confirmation message in the status bar before killing off the window. 

# Working with Panes
We can divide a single session into panes.

## Split vertically
In the tmux session, press `Prefix` `%` and the window will divide down the middle and start up a second terminal session in the new pane. In addition, the focus will move to this new pane. 

## Split horizontally
Pressing `Prefix` `"` (double quote) will split this new pane in *`half horizontally`*. By default, new panes split the existing pane in half evenly.

## Cycle through the Panes
To cycle through the panes, press `Prefix` `o`. You can also use `Prefix`, followed by the `Up`, `Down`, `Left`, or `Right` keys to move around the panes.

Pane Layouts
We can resize a pane, either using incremental resizing or by using templates. Resizing panes incrementally using the default keybindings is quite awkward. Use one of tmux’s several default pane layouts:

* **even-horizontal** - stacks all panes horizontally, left to right.
* **even-vertical** - stacks all panes vertically, top to bottom.
* **main-horizontal** - creates one larger pane on the top and smaller panes underneath.
* **main-vertical** - creates one large pane on the left side of the screen, and stacks the rest of the panes vertically on the right.
* **tiled** - arranges all panes evenly on the screen.

You can cycle through these layouts by pressing `Prefix` `Spacebar`

## Closing Panes
You close a pane the same way you *`exit`* a terminal session or a tmux window: you simply type “exit” in the pane. You can also kill a pane with `Prefix` `x`

# Working with Command Mode
We can execute tmux commands two ways: from the terminal itself or from the command area in the tmux status line. 

To enter Command mode, press `Prefix` `:` (the colon) from within a running tmux session. The status line changes color and we get a prompt that indicates that we can type our command. 

Create a new window by using the new-window command, like this:
```
new-window -n console
```

By using a command rather than the shortcut, you can create a new window and give it a name at the same time by using the `-n` flag. Let’s take this a step further and launch a new window that starts the `top` program. To do that, we enter Command mode (`Prefix` `:` ) and type this command:
```
new-window -n processes "top"
```

When you press `Enter`, a new window appears and the top application runs, showing your running processes.

Specifying an initial command for a window is extremely handy for short-term tasks, but there’s a slight wrinkle; if you exit the `top` app by pressing `q`, the tmux window you created will also close. You can use configuration settings to get around this, but if you want the window to persist, simply create it without specifying an initial command, and then execute your own command in the new window.

You can use Command mode to create new windows, new panes, or new sessions, or even set other environmental options.

# Introducing the tmux_conf
By default, tmux looks for configuration settings in two places. It first looks in *`/etc/tmux.conf`* for a system-wide configuration. It then looks for a file called *`.tmux.conf`* in the current user’s home directory

To create a brand-new configuration file in our home directory:
```
$ touch ~/.tmux.conf
```
In this file we can do everything from defining new key shortcuts to setting up a default environment with multiple windows, panes, and running programs.

To set options in the .tmux.conf file, use the set-option command, which you can shorten to set. You define the tmux prefix by adding this to the .tmux.conf file:
```
# Setting the prefix from `C`-`b` to `C`-`a`
set -g prefix C-a
```
In this example, we’re using the `-g` switch, for `“global”`,  which sets the option for all tmux sessions we create.

While not necessary, we can use the unbind-key, or unbind command, to remove a keybinding that’s been defined, so we can assign a different command to this key later. 
```
​# Free the original Ctrl-b prefix keybinding​
​unbind C-b
```
Changes to the file aren’t read by tmux automatically. So if you’re editing your *`.tmux.conf`* file while tmux is running, you’ll either need to completely close all tmux sessions, or enter tmux’s Command mode with `Prefix` `:` and type this whenever you make a change:
```
​source-file ~/.tmux.conf
```