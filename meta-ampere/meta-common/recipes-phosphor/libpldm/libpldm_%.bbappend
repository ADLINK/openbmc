FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
PACKAGECONFIG = "abi-development"

SRCREV = "64764fd6debc749fd2025f2ea6e7c98c6758ccdd"
SRC_URI += " \
            file://0001-pdr-Add-decode_numeric_effecter_pdr_data.patch \
          "
