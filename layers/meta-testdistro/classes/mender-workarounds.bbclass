MENDER_DATA_PART_FSTAB_OPTS ?= "defaults,data=journal"
use_label_for_mender_datapart() {
    if [ -f ${IMAGE_ROOTFS}${sysconfdir}/fstab ]; then
        sed -i -e's,^${MENDER_DATA_PART},LABEL=DATA,' ${IMAGE_ROOTFS}${sysconfdir}/fstab
    fi
}
ROOTFS_POSTPROCESS_COMMAND_append_jetson-tx2-cboot = " use_label_for_mender_datapart;"

OS_RELEASE_VERSION = "${BUILDNAME}${@' (%s)' % DISTRO_CODENAME if 'DISTRO_CODENAME' in d else ''}"

update_version_files () {
    dest="$1"
    if [ -f $dest/${sysconfdir}/mender/artifact_info -a -n "${MENDER_ARTIFACT_NAME}" ]; then
        echo "artifact_name=${MENDER_ARTIFACT_NAME}" > $dest/${sysconfdir}/mender/artifact_info
    fi

    if [ -f $dest/${sysconfdir}/os-release ]; then
        sed -i -r -e's,^VERSION=.*,VERSION="${OS_RELEASE_VERSION}",' \
	    -e's,^VERSION_ID=.*,VERSION_ID="${BUILDNAME}",' \
	    -e's,^PRETTY_NAME=.*,PRETTY_NAME="${DISTRO_NAME} ${BUILDNAME}",' \
	    $dest/${sysconfdir}/os-release
    fi

    if [ -f $dest/${sysconfdir}/issue ]; then
        printf "%s \\%s \\l\n\n" "${DISTRO_NAME} ${BUILDNAME}" "n" >$dest/${sysconfdir}/issue
    fi

    if [ -f $dest/${sysconfdir}/issue.net ]; then
        printf "%s %%h\n\n" "${DISTRO_NAME} ${BUILDNAME}" >$dest/${sysconfdir}/issue.net
    fi
}

rootfs_version_info() {
    update_version_files ${IMAGE_ROOTFS}
}

ROOTFS_POSTPROCESS_COMMAND_append = " rootfs_version_info;"
