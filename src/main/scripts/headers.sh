#!/bin/sh
# Run headers_$1 command for all suitable architectures

# Stop on error
set -e

do_command()
{
	if [ -f ${srctree}/board/$2/include/asm/Kbuild ]; then
		make TARGET=$2 KBUILD_HEADERS=$1 headers_$1
	else
		printf "Ignoring board: %s\n" ${board}
	fi
}

boards=${HDR_ARCH_LIST:-$(ls ${srctree}/board)}

for board in ${boards}; do
	case ${board} in
	*)
		if [ -d ${srctree}/board/${board} ]; then
			do_command $1 ${board}
		fi
		;;
	esac
done
