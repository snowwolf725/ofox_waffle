#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2019-2024 The OrangeFox Recovery Project
#	
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
# 	
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="waffle"

export TARGET_ARCH="arm64-v8a"

# Some about us
export FOX_VERSION="R12.1"
export OF_MAINTAINER=Wishmasterflo

# Build environment stuffs
export FOX_BUILD_DEVICE="OnePlus12"
export ALLOW_MISSING_DEPENDENCIES=true
export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
export TARGET_DEVICE_ALT="waffle, Waffle, OnePlus12, OnePlus 12, OP5929L1"
export FOX_TARGET_DEVICES="waffle, Waffle, OnePlus12, OnePlus 12, OP5929L1"
export BUILD_USERNAME="SnowWolf725"
export BUILD_HOSTNAME="android-build"

# Use magisk boot for patching
export OF_USE_MAGISKBOOT=1
export OF_USE_MAGISKBOOT_FOR_ALL_PATCHES=1
export OF_DONT_PATCH_ENCRYPTED_DEVICE=1

# We have a/b partitions
export FOX_AB_DEVICE=1
export FOX_VIRTUAL_AB_DEVICE=1
export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1

# Device stuff
export OF_KEEP_FORCED_ENCRYPTION=1
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
export OF_FBE_METADATA_MOUNT_IGNORE=1
export OF_PATCH_AVB20=1
export OF_USE_LEGACY_BATTERY_SERVICES=1

export FOX_USE_SPECIFIC_MAGISK_ZIP=device/oneplus/waffle/Magisk-v27.0.zip
export FOX_ENABLE_APP_MANAGER=1
export FOX_USE_BASH_SHELL=1
export FOX_ASH_IS_BASH=1
export FOX_USE_NANO_EDITOR=1
export FOX_USE_TAR_BINARY=1
export FOX_USE_ZIP_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_XZ_UTILS=1

# retrofitted dynamic partitions
export FOX_USE_DYNAMIC_PARTITIONS=1; # all builds now support dynamic partitions
export FOX_BASH_TO_SYSTEM_BIN=1; # install the bash binary to /system/bin/ instead of /sbin/
#export FOX_VANILLA_BUILD=1
export FOX_RECOVERY_SYSTEM_PARTITION="/dev/block/mapper/system"
export FOX_RECOVERY_VENDOR_PARTITION="/dev/block/mapper/vendor"
#
