DESCRIPTION = "libicbinn-resolved"
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM="file://../COPYING;md5=321bf41f280cf805086dd5a720b37785"

require icbinn.inc

DEPENDS = "libicbinn"

S = "${WORKDIR}/git/libicbinn_resolved"

inherit autotools
inherit pkgconfig
inherit lib_package
