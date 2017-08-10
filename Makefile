FUSE_RELEASE ?= 3.1.1
REBUILD      ?= 3
MAINTAINER   ?= bkryza@gmail.com

DISTS = trusty wily xenial zesty

all: $(DISTS)

download: fuse-${FUSE_RELEASE}.tar.gz

fuse-${FUSE_RELEASE}.tar.gz:
	wget https://github.com/libfuse/libfuse/releases/download/fuse-${FUSE_RELEASE}/fuse-${FUSE_RELEASE}.tar.gz

.ONESHELL:
$(DISTS): download
# Build fuse3
	rm -rf fuse-${FUSE_RELEASE}
	tar zvxf fuse-${FUSE_RELEASE}.tar.gz
	cd fuse-${FUSE_RELEASE}
	cp -r ../fuse3/debian debian
	sed -i "s/{{ DISTRIBUTION }}/$@/g" debian/changelog
	sed -i "s/{{ REBUILD }}/${REBUILD}/g" debian/changelog
	dh_make -e ${MAINTAINER} -p fuse3 -c gpl2 -l --f ../fuse-${FUSE_RELEASE}.tar.gz
	dpkg-buildpackage -rfakeroot
	cd ..
	mkdir -p package/$@/binary-amd64
	mkdir -p package/$@/source
	mv *$@*amd64.deb package/$@/binary-amd64
	mv *$@*debian.tar.xz package/$@/source
	mv fuse3_${FUSE_RELEASE}.orig.tar.gz package/$@/source
	mv *$@${REBUILD}.dsc package/$@/source
# Build libfuse3 and libfuse3-dev
	rm -rf fuse-${FUSE_RELEASE}
	tar zvxf fuse-${FUSE_RELEASE}.tar.gz
	cd fuse-${FUSE_RELEASE}
	cp -r ../libfuse3/debian debian
	sed -i "s/{{ DISTRIBUTION }}/$@/g" debian/changelog
	sed -i "s/{{ REBUILD }}/${REBUILD}/g" debian/changelog
	dh_make -e bkryza@gmail.com -p libfuse3 -c gpl2 -l --f ../fuse-${FUSE_RELEASE}.tar.gz
	dpkg-buildpackage -rfakeroot
	cd ..
	mkdir -p package/$@/binary-amd64
	mkdir -p package/$@/source
	mv *$@*amd64.deb package/$@/binary-amd64
	mv *$@*debian.tar.xz package/$@/source
	mv libfuse3_${FUSE_RELEASE}.orig.tar.gz package/$@/source
	mv *$@${REBUILD}.dsc package/$@/source

clean:
	rm -rf fuse-${FUSE_RELEASE} *.tar.gz *tar.xz *.dsc *.tar.gz.* *ubuntu1*
