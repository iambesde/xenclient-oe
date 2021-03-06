DESCRIPTION = "sample-plugin"
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=321bf41f280cf805086dd5a720b37785"
DEPENDS = "libsurfman"

require surfman.inc

S = "${WORKDIR}/git/plugins/sample"

CFLAGS_append = " -Wno-unused-parameter "

# Only compile this package to check that the sample plugin is still up to date

RDEPENDS_${PN}-dev = ""

FILES_${PN}-dev = "" 
FILES_${PN}-dbg = ""
FILES_${PN} = ""

inherit autotools
inherit pkgconfig

do_install() {
:
}
