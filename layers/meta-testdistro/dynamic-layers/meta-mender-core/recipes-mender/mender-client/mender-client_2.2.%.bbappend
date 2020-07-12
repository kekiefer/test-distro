PATCHDIR = "${S}/src/${GO_IMPORT}"

SRC_URI_append_tegra = " \
    file://0001-dual_rootfs_device-allow-for-rootfs-devices-that-do-.patch;patchdir=${PATCHDIR} \
    file://0002-mender-device-identity-skip-dummyX-interfaces.patch;patchdir=${PATCHDIR} \
    file://0003-mender.service-update-to-run-after-network-online.ta.patch;patchdir=${PATCHDIR} \
"

FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"
SRC_URI_append_signing = " file://artifact-verify-key.pem"
