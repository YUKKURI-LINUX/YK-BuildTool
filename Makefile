NAME = ${DISTRO_NAME}
VER = ${VERSION}

setup:
	lb config \
	--apt apt \
	--apt-pipeline 1 \
	-a amd64 \
	--archive-areas "main contrib non-free non-free-firmware" \
	-b iso-hybrid \
	--bootappend-live "boot=live splash components username=yukkuri user-fullname=Yukkuri Live User locales=ja_JP.UTF-8,en_US.UTF-8 timezone=Asia/Tokyo " \
	-d bookworm \
	--image-name ${NAME}_${VERSION} \
	--initramfs live-boot \
	--initramfs-compression gzip \
	--initsystem systemd \
	--iso-volume ${NAME}_INSTALL \

import-config: archived_config.zip config
	unzip -o archived_config.zip
delete-config: archived_config.zip
	rm -f archived_config.zip
export-config: setup
	7z a archived_config.zip config

build: config
	sudo lb build

clean:
	sudo lb clean
	sudo rm -r .build config cache
