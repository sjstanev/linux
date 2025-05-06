## Use Debian package management
Debian package format `(.deb)` and its package tool `(dpkg)`.
Another package management tool that is popular on Debian-based systems is the `Advanced Package Tool (apt)`, which can 
streamline many of the aspects of the installation, maintenance and removal of packages, making it much easier.

- [The RPM Package Manager](#the-rpm-package-manager)
- [YellowDog Updater Modified](#yellowDog-updater-modified)
- [Managing Software Repositories](#managing-software-repositories)
- [Dandified YUM](#dandified-yum)
- [Summary](#summary)

Key knowledge areas
- Install, re-install, upgrade and remove packages using RPM, YUM and Zypper.
- Obtain information on RPM packages such as version, status, dependencies, integrity and signatures.
- Determine what files a package provides, as well as find which package a specific file comes from.
- Awareness of dnf.

Partial list of the used files, terms and utilities
- rpm
- rpm2cpio
- /etc/yum.conf
- /etc/yum.repos.d/
- yum
- zypper


## The RPM Package Manager
The RPM Package Manager (rpm) is the essential tool for managing software packages on Red Hat-based (or derived) systems.

### Installing, Upgrading and Removing Packages
The most basic operation is to install a package, which can be done with:
```editorconfig
# rpm -i PACKAGENAME
```
Where PACKAGENAME is the name of the `.rpm` package you wish to install.

If there is a previous version of a package on the system, you can upgrade to a newer version using the `-U `parameter:
```editorconfig
# rpm -U PACKAGENAME
```
If there is no previous version of PACKAGENAME installed, then a fresh copy will be installed. 
To avoid this and **only upgrade** an installed package, use the `-F` option.
```editorconfig
# rpm -F PACKAGENAME
```
In both operations you can add the `-v` parameter to get a **verbose** output (more information is shown during the 
installation) and `-h` to get **hash signs (#)** printed as a visual aid to track installation progress. 
Multiple parameters can be combined into one, so `rpm -i -v -h `is the same as `rpm -ivh`.

To remove an installed package, pass the `-e` parameter (as in “erase”) to rpm.
```editorconfig
rpm -e wget
```
If an installed package depends on the package being removed, you will get an error message:
```editorconfig
# rpm -e unzip
error: Failed dependencies:
	/usr/bin/unzip is needed by (installed) file-roller-3.28.1-2.el7.x86_64
```

### Dealing with Dependencies
`rpm` will check if those dependencies are installed on your system, and will `fail` to install the package if they are not.
In this case, `rpm` will list what is `missing`. However it **cannot solve** dependencies by itself.
```editorconfig
# rpm -i gimp-2.8.22-1.el7.x86_64.rpm
error: Failed dependencies:
	babl(x86-64) >= 0.1.10 is needed by gimp-2:2.8.22-1.el7.x86_64
	gegl(x86-64) >= 0.2.0 is needed by gimp-2:2.8.22-1.el7.x86_64
	gimp-libs(x86-64) = 2:2.8.22-1.el7 is needed by gimp-2:2.8.22-1.el7.x86_64
	libbabl-0.1.so.0()(64bit) is needed by gimp-2:2.8.22-1.el7.x86_64
...
```
### Listing Installed Packages
To get a list of all installed packages on your system, use the `rpm -qa` **(think of “query all”)**.
```editorconfig
#  rpm -qa | head -n 5
python3-setuptools-wheel-53.0.0-13.el9.noarch
publicsuffix-list-dafsa-20210518-3.el9.noarch
pcre2-syntax-10.40-6.el9.noarch
ncurses-base-6.2-10.20210508.el9.noarch
libssh-config-0.10.4-13.el9.noarch
```
### Getting Package Information
```editorconfig
# rpm -qi gzip-1.12-1.el9.x86_64
Name        : gzip
Version     : 1.12
Release     : 1.el9
Architecture: x86_64
Install Date: Wed Mar 19 21:14:00 2025
Group       : Unspecified
Size        : 377005
License     : GPLv3+ and GFDL
Signature   : RSA/SHA256, Mon Oct 17 17:21:34 2022, Key ID d36cb86cb86b3716
Source RPM  : gzip-1.12-1.el9.src.rpm
Build Date  : Sat Oct 15 20:25:20 2022
Build Host  : x64-builder01.almalinux.org
Packager    : AlmaLinux Packaging Team <packager@almalinux.org>
Vendor      : AlmaLinux
URL         : http://www.gzip.org/
Summary     : The GNU data compression program
Description :
The gzip package contains the popular GNU gzip data compression
program. Gzipped files have a .gz extension.

Gzip should be installed on your system, because it is a
very commonly used data compression program.
```
### Get a list of what files are inside an installed package
To get a list of what files are inside an installed package use the `-ql `parameters **(think of “query list”)** 
```editorconfig
# rpm -ql gzip-1.12-1.el9.
/etc/profile.d/colorzgrep.csh
/etc/profile.d/colorzgrep.sh
/usr/bin/gunzip
/usr/bin/gzexe
[...]
```
If you wish to get information or a file listing from a **package that has not been installed yet**, 
just add the `-p` parameter to the commands above, followed by the name of the RPM file (FILENAME). 
So `rpm -qi` PACKAGENAME becomes `rpm -qip` FILENAME, and `rpm -ql` PACKAGENAME becomes `rpm -qlp` FILENAME, as shown below.

### Finding Out Which Package Owns a Specific File
To find out which installed package owns a file, use the -qf (think “query file”) followed by the full path to the file:
```editorconfig
# rpm -qf /usr/bin/unzip
unzip-6.0-19.el7.x86_64
```

## YellowDog Updater Modified
**YellowDog Updater Modified (YUM)** was originally developed as the **Yellow Dog Updater (YUP)**, a tool for package 
management on the Yellow Dog Linux distribution. Over time, it evolved to manage packages on other `RPM` based systems, 
such as Fedora, CentOS, Red Hat Enterprise Linux and Oracle Linux.

### Searching for Packages
In order to install a package, you need to know its name. For this you can perform a search with `yum search PATTERN`, 
where PATTERN is the name of the package you are searching for. The result is a list of packages whose **name** or 
**summary** contain the search pattern specified. 
```editorconfig
# yum search zip
Last metadata expiration check: 0:00:08 ago on Tue May  6 19:59:07 2025.
======================================================================== Name & Summary Matched: zip ========================================================================
zip.x86_64 : A file compression and packaging utility compatible with PKZIP
bzip2-devel.i686 : Libraries and header files for apps which will use bzip2
bzip2-devel.x86_64 : Libraries and header files for apps which will use bzip2
[...]
```
### Installing, Upgrading and Removing Packages
To install a package using yum, use the command yum install PACKAGENAME
```editorconfig
# sudo yum install p7zip
```
To upgrade an installed package, use yum update PACKAGENAME
```editorconfig
# sudo yum update wget
```
If you omit the name of a package, you can update every package on the system for which an update is available.

To check if an update is available for a specific package, use `yum check-update PACKAGENAME`. 
```editorconfig
# sudo yum check-update wget
```
To remove an installed package, use `yum remove PACKAGENAME`
```editorconfig
# sudo yum remove zip
Dependencies resolved.
=============================================================================================================================================================================
 Package                                Architecture                            Version                                       Repository                                Size
=============================================================================================================================================================================
Removing:
 zip                                    x86_64                                  3.0-35.el9                                    @baseos                                  724 k
Removing unused dependencies:
 unzip                                  x86_64                                  6.0-58.el9_5                                  @baseos                                  390 k

Transaction Summary
=============================================================================================================================================================================
Remove  2 Packages

Freed space: 1.1 M
Is this ok [y/N]: 

```
### Finding Which Package Provides a Specific File
In a previous example we showed an attempt to install the gimp image editor, which failed because of unmet dependencies.
However, `rpm` **shows which files are missing, but does not list the name of the packages that provide them**.

For example, one of the dependencies missing was **libgimpui-2.0.so.0**. To see what package provides it, 
you can use yum `whatprovides`, followed by the name of the file you are searching for:
```editorconfig
# yum whatprovides libgimpui-2.0.so.0
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirror.ufscar.br
 * epel: mirror.globo.com
 * extras: mirror.ufscar.br
 * updates: mirror.ufscar.br
2:gimp-libs-2.8.22-1.el7.i686 : GIMP libraries
Repo        : base
Matched from:
Provides    : libgimpui-2.0.so.0
```
The answer is **gimp-libs-2.8.22-1.el7.i686**. You can then install the package with the command `yum install gimp-libs`.

This also works for files already in your system. For example, if you wish to know where the file /etc/hosts came from, you can use:
```editorconfig
# yum whatprovides /etc/hosts
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirror.ufscar.br
 * epel: mirror.globo.com
 * extras: mirror.ufscar.br
 * updates: mirror.ufscar.br
setup-2.8.71-10.el7.noarch : A set of system configuration and setup files
Repo        : base
Matched from:
Filename    : /etc/hosts
```
The answer is **setup-2.8.71-10.el7.noarch**.

### Getting Information About a Package
```editorconfig
# sudo yum info firefox
Last metadata expiration check: 0:07:01 ago on Tue May  6 20:06:27 2025.
Available Packages
Name         : firefox
Version      : 128.9.0
Release      : 2.el9_5
Architecture : x86_64
Size         : 125 M
Source       : firefox-128.9.0-2.el9_5.src.rpm
Repository   : appstream
Summary      : Mozilla Firefox Web browser
URL          : https://www.mozilla.org/firefox/
License      : MPLv1.1 or GPLv2+ or LGPLv2+
Description  : Mozilla Firefox is an open-source web browser, designed for standards
             : compliance, performance and portability.
```
## Managing Software Repositories
For **yum** the “repos” are listed in the directory `/etc/yum.repos.d/`. Each repository is represented by a `.repo` file, 
like **CentOS-Base.repo.**
Additional, extra repositories can be added by the user by adding a `.repo `file in the directory mentioned above, 
or at the end of `/etc/yum.conf`. However, the **recommended** way to add or manage repositories is with the `yum-config-manager `tool.

To add a repository, use the `--add-repo `parameter, followed by the `URL` to a `.repo `file.
```editorconfig
# sudo yum-config-manager --add-repo https://rpms.remirepo.net/enterprise/remi.repo
Adding repo from: https://rpms.remirepo.net/enterprise/remi.repo
```
To get a list of all available repositories use yum repolist all. You will get an output similar to this:
```editorconfig
# yum repolist all
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
 * base: mirror.ufscar.br
 * epel: mirror.globo.com
 * extras: mirror.ufscar.br
 * updates: mirror.ufscar.br
repo id                       repo name                    status
updates/7/x86_64              CentOS-7 - Updates           enabled:  2,500
updates-source/7              CentOS-7 - Updates Sources   disabled
```
disabled repositories will be ignored when installing or upgrading software. To `enable` or `disable` a repository, 
use the `yum-config-manager` utility, followed by the `repository id`.

In the output above, the **repository id** is shown on the first column **(repo id)** of each line. 
Use only the part before the first /, so the id for the CentOS-7 - Updates repo is `updates`, and not `updates/7/x86_64`.
```editorconfig
# yum-config-manager --disable updates
```
The command above will `disable` the updates repo. To `re-enable` it use:
```editorconfig
# yum-config-manager --enable updates
```
```text
NOTE:
Yum stores downloaded packages and associated metadata in a cache directory (usually /var/cache/yum). 
As the system gets upgraded and new packages are installed, this cache can get quite large. 
To clean the cache and reclaim disk space you can use the yum clean command, followed by what to clean. 
The most useful parameters are packages (yum clean packages) to delete downloaded packages 
and metadata (yum clean metadata) to delete associated metadata.
```

## Dandified YUM

## Summary
 ### rpm
| Command     | Description                                                                                   |
|-------------|-----------------------------------------------------------------------------------------------|
| `rpm -i `   | Installs a single package, or a space-separated list of packages.                             |
| `rpm -U `   | Update a package, or a space-separated list of packages.                                      |
| `rpm -F `   | **Only upgrade** an installed package, use the `-F` option.                                   |
| `rpm -ihv ` | add the `-v` parameter to get a **verbose** output and `-h` to get **hash signs (#)** printed |
| `rpm -qa `  | Listing Installed Packages                                                                    |
| `rpm -qi `  | Getting Package Information                                                                   |
| `rpm -ql `  | Get a list of what files are inside an installed package                                      |
| `rpm -qip ` | Getting Package Information `that has not been installed yet`                                 |
| `rpm -qlp ` | Get a list of what files are inside an installed package `that has not been installed yet`    |
| `rpm -qf `  | Finding Out Which Package Owns a Specific File                                                |

 ### yum
| Command                          | Description                                                                 |
|----------------------------------|-----------------------------------------------------------------------------|
| `yum search `                    | Searching for Packages                                                      |
| `yum install `                   | To install a package                                                        |
| `yum update `                    | To update a package                                                         |
| `yum check-update `              | To check if an update is available for a specific package                   |
| `yum remove `                    | To remove a specific package                                                |
| `yum whatprovices `              | Finding Which Package Provides a Specific File                              |
| `yum info `                      | Getting Information About a Package                                         |
| `yum repolist `                  | To get a list of all available repositories                                 |
| `yum-config-manager --add-repo ` | To add a repository, use the `--add-repo `parameter, followed by the `URL`. |
| `yum-config-manager --enable`    | To enable a repository.                                                     |
| `yum-config-manager --disable`   | To disable a repository.                                                    |


 ### dnf
| Command                          | Description                                                                 |
|----------------------------------|-----------------------------------------------------------------------------|
| `yum search `                    | Searching for Packages                                                      ||