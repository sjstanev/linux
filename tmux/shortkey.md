# Tmux Shortkeys

## Table of Contents

- [Starting tmux](#starting-tmux)
- [Command Prefix](#command-prefix)
- [Detaching and Attaching Sessions](#detaching-and-attaching-sessions)
- [Working with Windows](#working-with-windows)

---
# Starting tmux

Starting tmux and creating named session
```
$ tmux new-session -s basic
```
   or 

```
$ tmux new -s basic
```

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