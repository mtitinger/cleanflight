#
# src/main/board/NAZE/Makefile
#
# This file is included by the global makefile so that you can add your own
# architecture-specific flags and dependencies.
#
# This file is subject to the terms and conditions of the GNU General Public
# License.  See the file "COPYING" in the main directory of this archive
# for more details.
#
# Copyright (C) 1995-2001 by Russell King

# Ensure linker flags are correct
LDFLAGS		:=

LDFLAGS_cleanflight	:=-p --no-undefined -X --pic-veneer
ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
LDFLAGS_cleanflight	+= --be8
LDFLAGS_MODULE	+= --be8
endif

OBJCOPYFLAGS	:=-O binary -R .comment -S
GZFLAGS		:=-9
#KBUILD_CFLAGS	+=-pipe

# Never generate .eh_frame
KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)

# Do not use src/main/board/NAZE/defconfig - it's always outdated.
# Select a platform tht is kept up-to-date
KBUILD_DEFCONFIG := naze_defconfig

ifeq ($(CONFIG_FRAME_POINTER),y)
KBUILD_CFLAGS	+=-fno-omit-frame-pointer -mapcs -mno-sched-prolog
endif

ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
KBUILD_CPPFLAGS	+= -mbig-endian
AS		+= -EB
LD		+= -EB
else
KBUILD_CPPFLAGS	+= -mlittle-endian
AS		+= -EL
LD		+= -EL
endif

# This selects which instruction set is used.
# Note that GCC does not numerically define an architecture version
# macro, but instead defines a whole series of macros which makes
# testing for a specific architecture or later rather impossible.
ifeq ($(CONFIG_CPU_32v6),y)
arch-$(CONFIG_CPU_32v6K)	=-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6k,-march=armv5t -Wa$(comma)-march=armv6k)
endif

# Evaluate arch cc-option calls now
arch-y := $(arch-y)

# This selects how we optimise for the processor.
tune-$(CONFIG_CPU_ARM740T)	=-mtune=arm7tdmi
tune-$(CONFIG_CPU_ARM9TDMI)	=-mtune=arm9tdmi
tune-$(CONFIG_CPU_ARM946E)	=$(call cc-option,-mtune=arm9e,-mtune=arm9tdmi)
tune-$(CONFIG_CPU_ARM926T)	=-mtune=arm9tdmi
tune-$(CONFIG_CPU_V6)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
tune-$(CONFIG_CPU_V6K)		=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)

# Evaluate tune cc-option calls now
tune-y := $(tune-y)

ifeq ($(CONFIG_AEABI),y)
CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork -mfpu=vfp
else
CFLAGS_ABI	:=$(call cc-option,-mapcs-32,-mabi=apcs-gnu) $(call cc-option,-mno-thumb-interwork,)
endif

ifeq ($(CONFIG_ARM_UNWIND),y)
CFLAGS_ABI	+=-funwind-tables
endif

CFLAGS_ISA	:=$(call cc-option,-marm,)
AFLAGS_ISA	:=$(CFLAGS_ISA)

# Need -Uarm for gcc < 3.x
KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float

CHECKFLAGS	+= -D__arm__

#Default value
#head-y		:= src/main/board/$(BAORD)/head??

# Text offset. This list is sorted numerically by address in order to
# provide a means to avoid/resolve conflicts in multi-arch kernels.
textofs-y	:= 0x00008000
#textofs-$(CONFIG_ARCH_CLPS711X) := 0x00028000

# Machine directory name.  This list is sorted alphanumerically
# by CONFIG_* macro name.
machine-$(CONFIG_ARCH_MXC)		+= imx
machine-$(CONFIG_ARCH_QCOM)		+= qcom
machine-$(CONFIG_ARCH_STM32)		+= stm32

plat-$(CONFIG_PLAT_VERSATILE)	+= versatile

# The byte offset of the kernel image in RAM from the start of RAM.
TEXT_OFFSET := $(textofs-y)

# The first directory contains additional information for the boot setup code
ifneq ($(machine-y),)
MACHINE  := src/main/board/NAZE/mach-$(word 1,$(machine-y))/
else
MACHINE  :=
endif

machdirs := $(patsubst %,board/NAZE/mach-%/,$(machine-y))
platdirs := $(patsubst %,board/NAZE/plat-%/,$(sort $(plat-y)))

ifeq ($(KBUILD_SRC),)
KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
else
KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
endif

export	TEXT_OFFSET GZFLAGS MMUEXT

#core-$(CONFIG_FPE_NWFPE)	+= board/NAZE/nwfpe/
#core-$(CONFIG_VFP)		+= board/NAZE/vfp/

# If we have a machine-specific directory, then include it in the build.
core-y				+= $(machdirs) $(platdirs)
# FIXME 
#libs-y				:= src/main/board/NAZE/lib/ $(libs-y)

KBUILD_IMAGE := cleanflight

all:	$(KBUILD_IMAGE)

# FIXME boot := src/main/board/NAZE/boot
boot:

archprepare:
	@echo "fake archprepare"
	#$(Q)$(MAKE) $(build)=board/NAZE/tools include/generated/mach-types.h

BOOT_TARGETS	= cleanflight
INSTALL_TARGETS	= install

# FIXME CL
#PHONY += $(BOOT_TARGETS) $(INSTALL_TARGETS)

#$(BOOT_TARGETS): cleanflight
#	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $(boot)/$@

#$(INSTALL_TARGETS):
#	$(Q)$(MAKE) $(build)=$(boot) MACHINE=$(MACHINE) $@

# We use MRPROPER_FILES and CLEAN_FILES now
archclean:
	$(Q)$(MAKE) $(clean)=$(boot)

define archhelp
  echo  '* zImage        - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
  echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
  echo  '  install       - Install uncompressed kernel'
  echo  '  zinstall      - Install compressed kernel'
endef
