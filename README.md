# Fuse 3 Ubuntu debian control files for packaging

## Building packages

> Fuse 3 packages should be able to coexist with already installed Fuse 2 versions.
> However, existing Fuse 2 packages are not separated to common and version 2 specific
> files, i.e. here we omit installation of overlapping files (manpages, etc.).

It provides 3 packages:
 - fuse3
 - libfuse3
 - libfuse3-dev

### Example steps for Fuse 3.1.1 release for Xenial.

```
sudo apt-get install build-essential dh-make wget

## Build all supported distros
make all

## Or make only specific one
make xenial

# Optionally upload packages to LaunchPad for building
dput ppa:bkryza/fuse3 ../fuse3_3.1.1-ubuntu1\~xenial2_source.changes
dput ppa:bkryza/fuse3 ../libfuse3_3.1.1-ubuntu1\~xenial2_source.changes
```
