# Vim Shortkeys
![alt text](image.png)
## Learning The Basic
## Table of Contents

- [Learn to move](#learn-to-move)
- [First set the ruler](#first-set-the-ruler)
- [Fix Your Deletion](#fix-your-deletion)
- [Control Your Insertions](#control-your-insertions)
- [Search smarter](#search-smarter)
- [Preview search](#preview-search)
- [Postview search](#postview-search)
- [Postprocess Your Search](#postprocess-your-search)
- [Search and Replace](#search-and-replace)
- [Global command](#global-command)
---
## Learn to move
Most vi users know the basic cursor motions of Normal mode:
```
      k
    h   l
      j
```
Or four arrows
The are also higher-level motion commands and operators
For words, lines, and other "text-objects"

## Word motions
 * To move forward to the start of the next word: `w`
 * To move backwards to the start of the previous word: `b`
 * To move forward to the <ins>end</ins> of the next word: `e`
 * To move backforward to the <ins>end</ins> of the previous word: `ge`

"Words" are considered anything that is delimited by non-identifier characters. All the motions have uppercase versions that use <ins>whitespace</ins> as the word delimiter instead.

## Line and paragraph motions
 * To move to the start of the current line: `0`
 * To move to the start of the first word of the current line: `^`
 * To move to the end of the current line: `$`
 * To move to the start of the next line: `<CR>`
 * To move to the start of the previous line: `-`

 * To move to start of the current paragraph: `{`
 * To move to the end of the current paragraph: `}`

A paragraph is delimited by empty lines (i.e. <ins>not</ins> black lines)

## Miscellaneous motions
 * To move to the top of the buffer: `gg`
 * To move to the end of the buffer: `G`
 * To move line <ins>N</ins>: `<N>G` or `<N>gg`
 * To move to the point <ins>P</ins> percent through the buffer: `<P>%`

## Matching delimiters
 * To move the matching bracket of a {...}, (...), or [...] pair: `%`

By default , Vim only matches {...}, (...), and [...], but you can extend that to whatever pairs you like:
```
set matchpairs+=<:>, <<:>>
```
Even to "pairs" that aren't normally considered pairs:
```
set matchpairs+==:;
```
## Repeated motions
Tedious to have to type `lllll` to move five chars right:
 * instead can type: `5l`
 * likewise, up three lines: `3k`
 * likewise, ahead four paragraphs: `4}`

## First set the ruler
To find out where you are in a file: `<CTRL-G>`
To always know where you are, set the ruler, in yout `.vimrc` file:
```
set ruler
```

##  Fix Your Deletion
For example:
```
:set backspace=start    "Can delete back past start of edit

:set backspace=indent   "Can delete back past autoindenting

:set backspace=eol      "Can delete back to the previous line
```
You may want all three:
```
:set backspace=start,indent,eol
```

## Control Your Insertions
In *Insert* or *Replace* mode, most characters you type simple insert that character, but not all. Many of control characters have special insertion behaviours.

 * `CTRL-y` duplicates what's in the same column on the preceding line
 * `CTRL-e` duplicates what's in the same column on the following line
 * `CTRL-a` inserts again whatever the most-recent inserted text was
 * `CTRL-r=` evaluates expression and inserts the result

 * `CTRL-t` insert a tab at the start of the line
    (without moving the insertion point)
 * `CTRL-d` delete a tab at the start of the line
    (without moving the insertion point)
 * `CTRL-v` insert the next character verbatim
 * `CTRL-w` deletes the word preceding the cursor
 * `CTRL-o` takes you back to Normal mode for one command, which is handy, for example, to clean the rest of the line: `CTRL-oD`

## Search smarter
Regexes used are <ins>sed</ins>-ish, but Vim extends them considerably, comparable in power to Perl, but numerous differences in syntax.
Single most useful thing to remember... nearly every *metasyntactic* need a backslash

### Commonest mistakes:
`\d+` or `\foo|bar `must become:

&ensp; \d<span style="color:yellow">\\</span>+

&ensp; \foo<span style="color:yellow">\\</span>|bar

Alternatively, you can prefix your regexes with \v:

&ensp; <span style="color:yellow">\v</span>\d+

&ensp; <span style="color:yellow">\v</span>foo|bar

### You can even automate that:
```
nnoremap / /\v
```

### Another very useful metasyntactics is `\&`

The "and" equivalent of `\|`'s "or"

For example, find line containing "Java" and "line":
```
/.*Java\&.*line
```

### \\< and \\> match only at start/end of word. 
For example:
```
/\<for\>

... mathches "for", but not "forture" nor "wherefor" nor "enforce"
```

### Searching for existing word
If the word you want to search for is already under your cursor... just type `*` to find the next instance or `#` to find the previous

### Case (in)sensitivity
Normally Vim searches are case-sensitive. If you would prefer case insensitive set the following option:
```
:set ignorecase
```
Better still, if you'd like "partial sensitivity", set this option as well:
```
:set smartcase
```
"Smartcase" overrides the "ignorecase" behaviour whenever your pattern includes any uppercase letters

Even with these options set you can still be specific when you need to be. Use the `\c` specifier within the pattern. Everything after it within the pattern will match case-insensitively, no matter what

Likewise, there's `\C` to undconditionally turn case sensitivity on.

## Preview search

Vim has an option that causes it to show you where your search will match:
```
:set incsearch
```
Look ahead as you type the search pattern, and highlights first match

Only jumps to that position when you hit `<ENTER>`. if you're looking ahead and hit `<ESC>` instead...

...cancels the search and returns cursor to former postion. Very handy to "peak-and-return"

## Postview search
Often the match you find isn't the one you want. So it can be handy to be shown where else it the buffer you should look.

Search highlighting makes that easy:
```
:set hlsearch
```
Now every match of every search will be highlighted. Search still jumps to the first match. But now you can also see where else you might need to look.

Note that the highlighting persists until your next search. To get rid of it, type:
```
:nohlsearch

or 

/<search some random gibberish string>
```
If this is still tedious, so maybe( in your <span style="color:green">.vimrc</span> ) 
```
nmap <silent>  <BS>  :nohlsearch<CR>
```

## Postprocess Your Search
Search in Vim has an unusual and useful characteristic. It's one of the few ways within the editor to select a non-contigous set of lines. The others are `:helpgrep` and `:vimgrep` and the `:global` command

There is a plugin that simplifies some task:
```
yankmatches.vim
```
## Search and Replace
* ### cpefify a range
You can specify a range of lines to restrict the search to:
```
:10,33s/<pattern>/<pepralcement>
```
will then replace <ins>first</ins> instance per line in that range. `s` comes from substitution.

If the range consists of a single number, only that line is modified. For example, only change the first line:
```
:1s/<pattern>/<replacement>
```
If you include a sign, then the range will be relative to the current line:
```
:-10,+33s/<pattern>/<replacement>
```
That means: "from 10 lines above the cursor to 33 lines below it"

* ### semi-colon
If you use a semi-colon instead of a comma:
```
:-10;+33s/<pattern>/<replacement>
```
...then the end of the range is <ins>relative to the start of the range</ins> instead of relative to the current line.

So the semicoloned version means: " from 10 lines above the cursor for the following 33 lines"

* ### range `.`,`$`
In that range, `.` means the current line, `$` means the last line. For example, to substitute on each line in the rest of the file:
```
:.,$s/<pattern>/<replacement>
```

* ### short-cut for making the range
There's also a short-cut for making the range "the next `N` lines". If you enter a number befor the colon:
```
99:

   then you get:

:.,+98
```
You can specify the entire file as the range:
```
:1,$s/<pattern>/<replacement>
```
and that's so useful that there's a short-cut:
```
:%s/<pattern>/<replacement>
```

* ### specify a range of lines according to their `contents`
You can specify a range of lines according to their contents. 
* Use `/<pattern>/` to specify "the next line that matches
* Use `?<pattern>?` to specify "the previous line that matches
For example, to substitute only within the body of en HTML file:
```
gg    # to bring back to beginning of the file

:/<body>/,/<\/body>/s/<I>/<EM>/
```

* ### add an offset
You can add an offset after either range cpecifier.

For example, to match from the line after the previous instance of "foo"...
   ... to ten lines before the end of the file:
```
:?foo?+1,$-10s/<pattern>/<replacement>
```
`Note:` that many other "colon" commands take ranges. The cpecification syntax is always the same.

* ### multiple substitutions
A substitution only subsitutes one match per line. Even if you use the `%` range, you get <ins>one</ins> substitution on every line.

To specify a substitution of <ins>every</ins> match on a line...
   ... append the /g modifier:
```
:s/<pattern>/<replacement>/g

:10,33s/<pattern>/<replacement>/g

:%s/<pattern>/<replacement>/g
```

* ### cautious substitution
To request a confirmation on each replacement append a flag: `/c`
```
:%s/cat/filene/gc
```

* ### substitution again
Often you want to repeat the last substitution on another line. You can do that with just:
```
:s<CR>
   or use the Normal-mode shortcut:
&
```
 ## Global command
The `%` range is very handy for applying a substitution everywhere:
```
:%s/<pattern>/<replacement>/g
   ...or for globally applying some other commands:
:%center 60
```
But often you don't want to apply a command to every line, just to those lines that match a certain pattern.

For that purpose, Vim provides the `:global` command. Which is almost always abbreviated to just `:g`
```
:g /pattern/ <colon command>
```
For example, to center only those lines that are already indented:
```
:g /^\s/ :center
```
There's also `:g!` that applies the command to lines that <ins>didn't</ins> match:
```
:g! /^\s/ :center
```

You can use `Normal` mode commands instead of "colon" commands. By using the `:normal` "colon: command:
```
:g /<h3>/ :normal gUU

   guu	-  Lowercase
   gUU   -  Uppercase current line (also gUgU)
```
To search forward for pattern in the current line? Like `/` and `?` but stop at end of line
```
:g /\%.l/ :normal guu   
```
The command after the `:g` can have a range of its own. In that case, the range is used (relative to each global match).

For example, to join every "paragraph" in a file into a single line:
```
:g /./ :.;/^$/join
```