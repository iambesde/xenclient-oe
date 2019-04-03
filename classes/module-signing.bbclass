# For module signing
DEPENDS += "openssl-native"

# Let linux build strip modules before signing
export INSTALL_MOD_STRIP="1"
# Don't let OE strip packages since that will remove the signature
INHIBIT_PACKAGE_STRIP = "1"

# Needed to build sign-tool
export HOST_EXTRACFLAGS = "${BUILD_CFLAGS} ${BUILD_LDFLAGS}"

# Set KERNEL_MODULE_SIG_KEY in local.conf to the filepath of a private key
# for signing kernel modules.  If unset, signing can be done offline.
export KERNEL_MODULE_SIG_KEY
# Set KERNEL_MODULE_SIG_CERT in local.conf to the filepath of the corresponging
# public key to verify the signed modules.  If unset, an autogenerated
# build-time keypair will be generated and used for signing and embedding.
export KERNEL_MODULE_SIG_CERT

# Kernel builds will override this with ${B}/scripts/sign-file
SIGN_FILE = "${STAGING_KERNEL_BUILDDIR}/scripts/sign-file"

do_sign_modules() {
    if [ -n "${KERNEL_MODULE_SIG_KEY}" ] &&
       grep -q '^CONFIG_MODULE_SIG=y' ${STAGING_KERNEL_BUILDDIR}/.config; then
        SIG_HASH=$( grep CONFIG_MODULE_SIG_HASH= \
                        ${STAGING_KERNEL_BUILDDIR}/.config | \
                      cut -d '"' -f 2 )
        [ -z "$SIG_HASH" ] && bbfatal CONFIG_MODULE_SIG_HASH is not set in .config

        [ -x "${SIGN_FILE}" ] || bbfatal "Cannot find scripts/sign-file"

        find ${D} -name "*.ko" -print0 | \
          xargs --no-run-if-empty -0 -n 1 \
              ${SIGN_FILE} $SIG_HASH ${KERNEL_MODULE_SIG_KEY} \
                  ${KERNEL_MODULE_SIG_CERT}
    fi
}

addtask sign_modules after do_install before do_package
# lockfiles needs to match module.bbclass make_scripts value
# Otherwise sign-file could disappear from ${STAGING_KERNEL_BUILDDIR}
do_sign_modules[lockfiles] = "${TMPDIR}/kernel-scripts.lock"
