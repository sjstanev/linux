## Use Debian package management
Debian package format `(.deb)` and its package tool `(dpkg)`.
Another package management tool that is popular on Debian-based systems is the `Advanced Package Tool (apt)`, which can 
streamline many of the aspects of the installation, maintenance and removal of packages, making it much easier.

- [The Debian Package Tool](#the-debian-package-tool)
- [Advanced Package Tool](#advanced-package-tool)
- [The Sources List](#the-sources-list)
- [Summary](#summary)

### Key knowledge areas
- Install, upgrade and uninstall Debian binary packages.
- Find packages containing specific files or libraries which may or may not be installed.
- Obtain package information like version, content, dependencies, package integrity and installation status (whether or not the package is installed).
- Awareness of apt.

### Partial list of the used files, terms and utilities
- /etc/apt/sources.list
- dpkg
- dpkg-reconfigure
- apt-get
- apt-cache

## The Debian Package Tool 
The `Debian Package (dpgk)` tool is the essential utility to install, configure, maintain and remove software packages 
on Debian based systems. The most basic operation is to install a **.deb** package, which can be done with:
```editorconfig
# dpkg -i PACKAGENAME
```
### Dealing with Dependencies
More often than not, a package may depend on others to work as intended. 
**dpkg** will check if those dependencies are installed on your system, and will `fail` to install the package if they are not.
```editorconfig
# dpkg -i openshot-qt_2.4.3+dfsg1-1_all.deb
(Reading database ... 269630 files and directories currently installed.)
Preparing to unpack openshot-qt_2.4.3+dfsg1-1_all.deb ...
Unpacking openshot-qt (2.4.3+dfsg1-1) over (2.4.3+dfsg1-1) ...
>>>dpkg: dependency problems prevent configuration of openshot-qt:<<<
 openshot-qt depends on fonts-cantarell; however:
  Package fonts-cantarell is not installed.
```

### Removing Packages
When a package is removed, the corresponding configuration files are left on the system. 
If you want to remove everything associated with the package, use the `-P (purge)` option instead of `-r`.
```editorconfig
# dpkg -r p7zip
```

You can force dpkg to install or remove a package, even if dependencies are not met, by adding the `--force`parameter
```editorconfig
# dpkg -i --force PACKAGENAME or # dpkg -r --force PACKAGENAME
```

### Getting Package Information
To get information about a `.deb` package, such as its version, architecture, maintainer, dependencies and more, 
use the dpkg command with the `-I` parameter, followed by the filename of the package you want to inspect:
```editorconfig
# dpkg -I /var/cache/apt/archives/zstd_1.5.4+dfsg2-5_amd64.deb 
 new Debian package, version 2.0.
 size 700656 bytes: control archive=1124 bytes.
     666 bytes,    16 lines      control              
    1130 bytes,    18 lines      md5sums              
 Package: zstd
 Source: libzstd
 Version: 1.5.4+dfsg2-5
 Architecture: amd64

```

### Listing Installed Packages 
To get a list of every package installed on your system, use the `--get-selections` option, as:
```editorconfig
# dpkg --get-selections | head -3
accountsservice         install
acl                     install
adduser                 install

    or

# dpkg --get-selections zip
zip                     install


```
### Package Contents
To get a list of every file installed by a specific package by passing the `-L PACKAGENAME` parameter:
```editorconfig
# dpkg -L unrar
/.
/usr
/usr/bin
/usr/bin/unrar-nonfree
/usr/share
```
### Finding Out Which Package Owns a Specific File
Sometimes you may need to find out which package owns a specific file in your system. You can do so by using the 
`dpkg-query` utility, followed by the `-S` parameter and the path to the file in question:
```editorconfig
# dpkg-query -S /usr/bin/unrar-nonfree
unrar: /usr/bin/unrar-nonfree
```

### Reconfiguring Installed Packages
When a package is installed there is a configuration step called `post-install` where a script runs to set-up everything 
needed for the software to run such as permissions, placement of configuration files, etc.
Sometimes, due to a corrupt or malformed configuration file, you may wish to restore a package’s settings to its 
`“fresh”` state. Or you may wish to change the answers you gave to the initial configuration questions. 
To do this run the `dpkg-reconfigure` utility, followed by the package name.
```editorconfig
# dpkg-reconfigure tzdate
```

## Advanced Package Tool
`The Advanced Package Tool (APT)` is a package management system, including a set of tools, that greatly simplifies 
package installation, upgrade, removal and management. `APT` provides features like advanced search capabilities and 
automatic dependency resolution.
APT is not a “substitute” for dpkg. You may think of it as a **“front end”**, streamlining operations and filling gaps
in dpkg functionality, like dependency resolution.
- There are many utilities that interact with APT, the main ones being:
  - `apt-get` - used to download, install, upgrade or remove packages from the system.  
  - `apt-cache` - used to perform operations, like searches, in the package index.
  - `apt-file` - used for searching for files inside packages.

### Updating the Package Index
Before installing or upgrading software with APT, it is recommended to update the package index first in order to 
retrieve information about new and updated packages. 
This is done with the apt-get command, followed by the update parameter:
```editorconfig
# sudo apt-get update
Hit:1 http://deb.debian.org/debian bookworm InRelease
Hit:2 http://deb.debian.org/debian bookworm-updates InRelease    
Hit:3 https://packages.microsoft.com/debian/11/prod bullseye InRelease                                                                                                      
...
```

### Installing and Removing Packages

`apt-get install`, followed by the name of the package you wish to install:
Be aware that when installing or removing packages, APT will do automatic dependency resolution
```editorconfig
# apt-get install xournal
```
Similarly, to remove a package use `apt-get remove`, followed by the package name:
```editorconfig
# apt-get remove xournal
    or
# apt-get purge xournal or # apt-get remove --purge p7zip
```
Note that when a package is removed the corresponding configuration files are left on the system. To remove the package
and any configuration files, use the `purge` parameter instead of `remove` or the `remove` parameter with the `--purge`
option:

### Fixing Broken Dependencies
It is possible to have “broken dependencies” on a system. This means that one or more of the installed packages 
depend on other packages that have not been installed, or are not present anymore. 
This may happen due to an APT error, or because of a manually installed package.
To solve this, use the `apt-get install -f` command. This will try to “fix” the broken packages by installing the 
missing dependencies, ensuring that all packages are consistent again.
```editorconfig
# apt-get install -f
```
### The Local Cache
When you install or update a package, the corresponding `.deb `file is downloaded to a local cache directory 
before the package is installed. By default, this directory is `/var/cache/apt/archives`. 
Partially downloaded files are copied to `/var/cache/apt/archives/partial/`.

As you install and upgrade packages, the cache directory can get quite large. To reclaim space, you can empty the cache
by using the `apt-get clean` command.

### Searching for Packages
The apt-cache utility can be used to perform operations on the package index, such as searching for a specific package
or listing which packages contain a specific file.
```editorconfig
# apt-cache search p7zip
liblzma-dev - XZ-format compression library - development files
liblzma5 - XZ-format compression library
forensics-extra - Forensics Environment - extra console components (metapackage)
```
In the example above, the entry liblzma5 - XZ-format compression library does not seem to match the pattern. However, 
if we show the full information, including description, for the package using the `show` parameter, we will find the
pattern there:
```editorconfig
# apt-cache show liblzma5
Package: liblzma5
Architecture: amd64
Version: 5.2.4-1
Multi-Arch: same
Priority: required
...
Description-en: XZ-format compression library
 XZ is the successor to the Lempel-Ziv/Markov-chain Algorithm
 compression format, which provides memory-hungry but powerful
 compression (often better than bzip2) and fast, easy decompression.
 The native format of liblzma is XZ; it also supports raw (headerless)
 streams and the older LZMA format used by lzma. (For 7-Zip's related
 format, use the p7zip package instead.)
```

## The Sources List
APT uses a list of sources to know where to get packages from. 
This list is stored in the file sources.list, located inside the `/etc/apt `directory. 
A typical line inside sources.list looks like this:
```editorconfig
deb http://us.archive.ubuntu.com/ubuntu/ bookworm main restricted universe multiverse
```
The syntax is archive `type`, `URL`, `distribution` and one or more `components`, where:
- `Archive type` -  repository may contain packages with ready-to-run software (binary packages, type `deb`) or 
with the source code to this software (source packages, type `deb-src`). 
- `URL` - The URL for the repository.
- `Distribution` - The name (or codename) for the distribution for which packages are provided. 
One repository may host packages for multiple distributions. In the example above, bookworm is the codename for `Debian GNU/Linux 12 (bookworm)`.
- `Components` -Each component represents a set of packages. These components may be different on different Linux distributions. For example, on `Ubuntu` and derivatives, they are:
  - `main` - contains officially supported, open-source packages.
  - `restricted` - contains officially supported, closed-source software, like device drivers for graphic cards, for example.
  - `universe` - contains community maintained open-source software.
  - `multiverse` - contains unsupported, closed-source or patent-encumbered software.


- On `Debian`, the main components are:
    - `main` - consists of packages compliant with the Debian Free Software Guidelines (DFSG), which do not rely on software outside this area to operate.
    - `contrib` - contains DFSG-compliant packages, but which depend on other packages that are not in main
    - `non-free` - contains packages that are not compliant with the DFSG.
    - `security` - contains security updates.
    - `backports` - contains more recent versions of packages that are in main. The development cycle of the stable versions of Debian is quite long (around two years), and this ensures that users can get the most up-to-date packages without having to modify the main core repository.
  
Inside the `/etc/apt/sources.list.d ` directory you can add files with additional repositories to be used by APT, 
without the need to modify the main `/etc/apt/sources.list `file. These are simple text files, 
with the same syntax described above and the .list file extension.

Below you see the contents of a file called `/etc/apt/sources.list.d/buster-backports.list`:
```editorconfig
deb http://deb.debian.org/debian buster-backports main contrib non-free
deb-src http://deb.debian.org/debian buster-backports main contrib non-free
```

### Listing Package Contents and Finding Files
A utility called `apt-file` can be used to perform more operations in the package index, like listing the contents of a 
package or finding a package that contains a specific file. This utility may not be installed by default in your system. 
In this case, you can usually install it using apt-get:
```editorconfig
# apt-get install apt-file
```
After installation, you will need to update the package cache used for apt-file:
```editorconfig
# apt-file update
```
To list the contents of a package, use the `list` parameter followed by the package name:
```editorconfig
# apt-file list unrar
unrar: /usr/bin/unrar-nonfree
unrar: /usr/share/doc/unrar/changelog.Debian.gz
unrar: /usr/share/doc/unrar/copyright
unrar: /usr/share/man/man1/unrar-nonfree.1.gz
```
You can search all packages for a file using the `search` parameter, followed by the file name. For example, 
if you wish to know which package provides a file called **libSDL2.so**, you can use:
```editorconfig
# apt-file search libSDL2.so
libsdl2-dev: /usr/lib/x86_64-linux-gnu/libSDL2.so
```
The answer is the package `libsdl2-dev`, which provides the file `/usr/lib/x86_64-linux-gnu/libSDL2.so`.

The difference between `apt-file `search and `dpkg-query` is that **apt-file** search will also search **uninstalled**
packages, while `dpkg-query `can only show files that belong to an installed package.

## Summary
 ### dpkg
| Command                   | Description                                                        |
|---------------------------|--------------------------------------------------------------------|
| `dpkg -i `                | Installs a single package, or a space-separated list of packages.  |
| `dpkg -r `                | Removes a package, or a space-separated list of packages.          |
| `dpkg -I `                | To get information about a `.deb` package                          |
| `dpkg --get-selections `  | Listing Installed Packages                                         |
| `dpkg -L `                | To get a list of every file installed by a specific package        |
| `pkg-query -S`            | Finding Out Which Package Owns a Specific File                     |
| `dpkg-reconfigure`        | Reconfiguring Installed Packages                                   |

### apt
| Command              | Description                                                                                |
|----------------------|--------------------------------------------------------------------------------------------|
| `apt-get install `   | Installs a single package, or a space-separated list of packages.                          |
| `apt-get remove `    | Removes a package, or a space-separated list of packages.                                  |
| `apt-get purge`      | Removes a package and corresponding configuration files                                    |
| `apt-get install -f` | Fixing Broken Dependencies                                                                 |
| `apt-get clean`      | To empty the Local Cache                                                                   |

### apt-cache
| Command              | Description                                                                                |
|----------------------|--------------------------------------------------------------------------------------------|
| `apt-cache search `  | Searching for Packages                                                                     |
| `apt-cache show `    | show the full information, including description, for the package using the show parameter |

### apt-file
| Command           | Description                                                                               |
|-------------------|-------------------------------------------------------------------------------------------|
| `apt-file list`   | To list the contents of a package                                                         |
| `apt-file search` | To search all packages for a file using the `search` parameter, followed by the file name |