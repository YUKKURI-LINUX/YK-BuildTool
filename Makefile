NAME = ${DISTRO_NAME}
VER = ${VERSION}

setup: config 
	lb config \
	--apt apt \
	--apt-pipeline 1 \
	-a amd64 \
	--archive-areas "main contrib non-free non-free-firmware" \
	-b iso-hybrid \
	-d bookworm \
	--image-name ${NAME}_${VERSION} \
	--initramfs live-boot \
	--initramfs-compression gzip \
	--initsystem systemd \
	--iso-volume ${NAME}_INSTALL \

import-config: archived_config.zip config
	cp -o archived_config.zip
delete-config: archived_config.zip
	rm -f archived_config.zip
export-config: setup
	7z a archived_config.zip config

build: setup
	sudo lb build

clean:
	sudo lb clean
	sudo rm -r .build config cache
