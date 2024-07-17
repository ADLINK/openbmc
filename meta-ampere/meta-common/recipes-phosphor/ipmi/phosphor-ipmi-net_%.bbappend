FILESEXTRAPATHS:append := "${THISDIR}/${PN}:"

SRC_URI += "\
             file://0001-sol-change-to-use-async_connect-method-to-prevent-bl.patch \
           "
