EXTRA_OECONF += "--with-ka_pidfile=/run/wd_keepalive.pid"
PACKAGES =+ "${PN}-keepalive-bin"
FILES_${PN}-keepalive-bin = "${sbindir}/wd_keepalive"
RDEPENDS_${PN}-keepalive += "${PN}-keepalive-bin"
RDEPENDS_${PN}-keepalive-bin += "watchdog-config"
