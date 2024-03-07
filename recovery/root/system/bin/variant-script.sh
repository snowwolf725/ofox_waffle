#!/system/bin/sh
# This script is needed to automatically set device props.

variant=$(getprop ro.boot.prjname)
region=$(getprop ro.boot.hw_region_id)

echo $variant
echo $region

case $region in
    "21")
    #China
        case $variant in
            "22811")
            #China
                resetprop ro.product.device "OP5929L1"
                resetprop ro.product.vendor.device "OP5929L1"
                resetprop ro.product.odm.device "OP5929L1"
                resetprop ro.product.product.device "OP5929L1"
                resetprop ro.product.device "OP5929L1"
                resetprop ro.product.system_ext.device "OP5929L1"
                resetprop ro.product.product.model "PJD110"
                resetprop ro.product.model "PJD110"
                resetprop ro.product.system.model "PJD110"
                resetprop ro.product.system_ext.model "PJD110"
                resetprop ro.product.vendor.model "PJD110"
                resetprop ro.product.odm.model "PJD110"
                resetprop ro.boot.hardware.revision "CN"
                ;;
            "22861")
            #India
                resetprop ro.product.device "OP595DL1"
                resetprop ro.product.odm.device "OP595DL1"
                resetprop ro.product.product.device "OP595DL1"
                resetprop ro.product.system_ext.device "OP595DL1"
                resetprop ro.product.vendor.device "OP595DL1"
                resetprop ro.product.product.model "CPH2573"
                resetprop ro.product.product.model "CPH2573"
                resetprop ro.product.model "CPH2573"
                resetprop ro.product.system.model "CPH2573"
                resetprop ro.product.system_ext.model "CPH2573"
                resetprop ro.product.vendor.model "CPH2573"
                resetprop ro.product.odm.model "CPH2573"
                resetprop ro.boot.hardware.revision "IN"
                ;;
            *)
                resetprop ro.product.device "OP5929L1"
                resetprop ro.product.vendor.device "OP5929L1"
                resetprop ro.product.odm.device "OP5929L1"
                resetprop ro.product.product.device "OP5929L1"
                resetprop ro.product.device "OP5929L1"
                resetprop ro.product.system_ext.device "OP5929L1"
                resetprop ro.product.product.model "PJD110"
                resetprop ro.product.model "PJD110"
                resetprop ro.product.system.model "PJD110"
                resetprop ro.product.system_ext.model "PJD110"
                resetprop ro.product.vendor.model "PJD110"
                resetprop ro.product.odm.model "PJD110"
                resetprop ro.boot.hardware.revision "CN"
                ;;
        esac
        ;;
    "22")
    #Europe
            resetprop ro.product.device "OP5929L1"
            resetprop ro.product.odm.device "OP5929L1"
            resetprop ro.product.product.device "OP5929L1"
            resetprop ro.product.device "OP5929L1"
            resetprop ro.product.system_ext.device "OP5929L1"
            resetprop ro.product.vendor.device "OP5929L1"
            resetprop ro.product.product.model "CPH2581"
            resetprop ro.boot.hardware.revision "EU"
        ;;
    "23")
    #NA
            resetprop ro.product.device "OP595DL1"
            resetprop ro.product.odm.device "OP595DL1"
            resetprop ro.product.product.device "OP595DL1"
            resetprop ro.product.system_ext.device "OP595DL1"
            resetprop ro.product.vendor.device "OP595DL1"
            resetprop ro.product.product.model "CPH2583"
            resetprop ro.product.model "CPH2583"
            resetprop ro.product.system.model "CPH2583"
            resetprop ro.product.system_ext.model "CPH2583"
            resetprop ro.product.vendor.model "CPH2583"
            resetprop ro.product.odm.model "CPH2583"
            resetprop ro.boot.hardware.revision "NA"
        ;;
    *)
            resetprop ro.product.device "OP5929L1"
            resetprop ro.product.odm.device "OP5929L1"
            resetprop ro.product.product.device "OP5929L1"
            resetprop ro.product.system_ext.device "OP5929L1"
            resetprop ro.product.vendor.device "OP5929L1"
            resetprop ro.product.product.model "CPH2581"
            resetprop ro.boot.hardware.revision "EU"
        ;;
esac

exit 0 
