SUMMARY = "Argo Linux module."
DESCRIPTION = "Argo implements inter-domain communication on Xen virtualization \
platform relying on the hypervisor to broker all communications. Domains then \
manage their own data rings and no memory is shared between them. Argo module \
defines a stream and a datagram protocol."
HOMEPAGE = "https://wiki.xenproject.org/wiki/Argo:_Hypervisor-Mediated_Exchange_(HMX)_for_Xen"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=4641e94ec96f98fabc56ff9cc48be14b"

require argo.inc

S = "${WORKDIR}/git/argo-linux"

inherit module
inherit module-signing

EXTRA_OEMAKE += "INSTALL_HDR_PATH=${D}${prefix}"
MODULES_INSTALL_TARGET += "headers_install"

KERNEL_MODULE_AUTOLOAD += "xen-argo"
