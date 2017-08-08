# Fuse 3 Ubuntu debian control files for packaging

## Building packages

> Fuse 3 packages should be able to coexist with already installed Fuse 2 versions.
> However, existing Fuse 2 packages are not separated to common and version 2 specific
> files, i.e. here we omit installation of overlapping files (manpages, etc.).

It provides 2 packages:
 - libfuse3
 - libfuse3-dev

### Example steps for Fuse 3.1.1 release for Xenial.

```
sudo apt-get install build-essential dh-make wget

wget https://github.com/libfuse/libfuse/releases/download/fuse-3.1.1/fuse-3.1.1.tar.gz

tar zxvf fuse-3.1.1.tar.gz

cd fuse-3.1.1

# Copy (symbolic link won't work...)
cp ../xenial/debian debian

# If necessary update changelog
dch -i

# Create orig source file
export DEBFULLNAME="Bartek Kryza"
export DEBEMAIL="bkryza@gmail.com"
dh_make -e bkryza@gmail.com -p libfuse3 -c gpl2 -l --f ../fuse-3.1.1.tar.gz

# Build packages
dpkg-buildpackage -rfakeroot

# Or build package changes description
debuild -S -sa -k$GPGKEY

# And upload packages to LaunchPad
dput ppa:bkryza/fuse3 ../libfuse3_3.1.1-ubuntu1\~xenial2_source.changes
```
