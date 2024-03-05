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

export FOX_USE_SPECIFIC_MAGISK_ZIP=~/Magisk/Magisk-v27.zip
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
