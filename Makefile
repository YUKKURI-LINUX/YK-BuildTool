NAME = ${DISTRO_NAME}
VER = ${VERSION}

.PHONY: config
config: 
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

build: config
	sudo lb build

clean:
	sudo lb clean
	sudo rm -r .build config cache
