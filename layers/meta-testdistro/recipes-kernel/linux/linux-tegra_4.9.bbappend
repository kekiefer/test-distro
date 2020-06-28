FILESEXTRAPATHS_prepend := "${THISDIR}/linux-tegra-4.9:"
SRC_URI += "file://systemd.cfg"
SRC_URI_append_jetson-tx2_signing = " file://0001-Drop-security-engine-RSA-priority.patch"
SRC_URI_append_signing = " file://test-signing-key.pem"
SRC_URI_append_signing = " file://module-signing.cfg"
SRC_URI_append_secureboot = " file://dm-crypt.cfg"

DEPENDS += "openssl-native"

do_configure_append_signing() {
    if [ ! -e ${S}/certs/test-signing-key.pem ] || \
        ! cmp -s ${WORKDIR}/test-signing-key.pem ${S}/certs/test-signing-key.pem; then
        cp ${WORKDIR}/test-signing-key.pem ${S}/certs/
    fi
}

inherit kernel-module-signing
