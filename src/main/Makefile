VERSION = 4
PATCHLEVEL = 2
SUBLEVEL = 0
EXTRAVERSION = -rc5
NAME = Hurr durr I'ma sheep

# *DOCUMENTATION*
# To see a list of typical targets execute "make help"
# More info can be located in ./README
# Comments in this file are targeted only to the developer, do not
# expect to learn how to build the kernel reading this file.

# o Do not use make's built-in rules and variables
#   (this increases performance and avoids hard-to-debug behaviour);
# o Look for make include files relative to root of kernel src
MAKEFLAGS += -rR --include-dir=$(CURDIR)

# Avoid funny character set dependencies
unexport LC_ALL
LC_COLLATE=C
LC_NUMERIC=C
export LC_COLLATE LC_NUMERIC

# Avoid interference with shell env settings
unexport GREP_OPTIONS

# We are using a recursive build, so we need to do a little thinking
# to get the ordering right.
#
# Most importantly: sub-Makefiles should only ever modify files in
# their own directory. If in some directory we have a dependency on
# a file in another dir (which doesn't happen often, but it's often
# unavoidable when linking the built-in.o targets which finally
# turn into cleanflight), we will call a sub make in that other dir, and
# after that we are sure that everything which is in that other dir
# is now up to date.
#
# The only cases where we need to modify files which have global
# effects are thus separated out and done before the recursive
# descending is started. They are now explicitly listed as the
# prepare rule.

# Beautify output
# ---------------------------------------------------------------------------
#
# Normally, we echo the whole command before executing it. By making
# that echo $($(quiet)$(cmd)), we now have the possibility to set
# $(quiet) to choose other forms of output instead, e.g.
#
#         quiet_cmd_cc_o_c = Compiling $(RELDIR)/$@
#         cmd_cc_o_c       = $(CC) $(c_flags) -c -o $@ $<
#
# If $(quiet) is empty, the whole command will be printed.
# If it is set to "quiet_", only the short version will be printed.
# If it is set to "silent_", nothing will be printed at all, since
# the variable $(silent_cmd_cc_o_c) doesn't exist.
#
# A simple variant is to prefix commands with $(Q) - that's useful
# for commands that shall be hidden in non-verbose mode.
#
#	$(Q)ln $@ :<
#
# If KBUILD_VERBOSE equals 0 then the above command will be hidden.
# If KBUILD_VERBOSE equals 1 then the above command is displayed.
#
# To put more focus on warnings, be less verbose as default
# Use 'make V=1' to see the full commands

ifeq ("$(origin V)", "command line")
  KBUILD_VERBOSE = $(V)
endif
ifndef KBUILD_VERBOSE
  KBUILD_VERBOSE = 0
endif

ifeq ($(KBUILD_VERBOSE),1)
  quiet =
  Q =
else
  quiet=quiet_
  Q = @
endif

# If the user is running make -s (silent mode), suppress echoing of
# commands

ifneq ($(filter 4.%,$(MAKE_VERSION)),)	# make-4
ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
  quiet=silent_
endif
else					# make-3.8x
ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
  quiet=silent_
endif
endif

export quiet Q KBUILD_VERBOSE

## ==================== FIXME ==============================

64K_BOARDS  = CJMCU
128K_BOARDS = ALIENFLIGHTF1 CC3D NAZE NAZE_MARC OLIMEXINO RMDO SPRACINGF1OSD
256K_BOARDS = ALIENFLIGHTF3 CHEBUZZF3 COLIBRI_RACE EUSTM32F103RC IRCFUSIONF3 \
	      LUX_RACE MOTOLAB PORT103R RCEXPLORERF3 SPARKY SPRACINGF3 \
	      SPRACINGF3EVO SPRACINGF3MINI STM32F3DISCOVERY SPRACINGF3OSD

F3_BOARDS = ALIENFLIGHTF3 CHEBUZZF3 COLIBRI_RACE IRCFUSIONF3 LUX_RACE MOTOLAB \
	    RCEXPLORERF3 RMDO SPARKY SPRACINGF3 SPRACINGF3EVO SPRACINGF3MINI \
            STM32F3DISCOVERY SPRACINGF3OSD

VALID_BOARDS = $(64K_BOARDS) $(128K_BOARDS) $(256K_BOARDS)

VCP_BOARDS = CC3D ALIENFLIGHTF3 CHEBUZZF3 COLIBRI_RACE LUX_RACE MOTOLAB \
	     RCEXPLORERF3 SPARKY SPRACINGF3EVO SPRACINGF3MINI STM32F3DISCOVERY \
	     SPRACINGF1OSD SPRACINGF3OSD

OSD_BOARDS = SPRACINGF1OSD SPRACINGF3OSD

ROOT		= ../..
STDPERIPH_DIR    = $(ROOT)/lib/main/STM32F10x_StdPeriph_Driver
CMSIS_DIR        = $(ROOT)/lib/main/CMSIS

# ~~~ ST c-files ~~~~
STDPERIPH_SRC = $(notdir $(wildcard $(STDPERIPH_DIR)/src/*.c))
EXCLUDES        = stm32f10x_crc.c \
                stm32f10x_cec.c \
                stm32f10x_can.c
STDPERIPH_SRC := $(filter-out ${EXCLUDES}, $(STDPERIPH_SRC))

# Search path and source files for the CMSIS sources
VPATH           := $(VPATH):$(CMSIS_DIR)/CM3/CoreSupport:$(CMSIS_DIR)/CM3/DeviceSupport/ST/STM32F10x
CMSIS_SRC        = $(notdir $(wildcard $(CMSIS_DIR)/CM3/CoreSupport/*.c \
                           $(CMSIS_DIR)/CM3/DeviceSupport/ST/STM32F10x/*.c))

INCLUDE_DIRS := $(INCLUDE_DIRS) \
                   $(STDPERIPH_DIR)/inc \
                   $(CMSIS_DIR)/CM3/CoreSupport \
                   $(CMSIS_DIR)/CM3/DeviceSupport/ST/STM32F10x \

DEVICE_STDPERIPH_SRC = $(STDPERIPH_SRC)

export KBUILD_LDS := board/stm32_flash_f103_128k.ld

ARCH_FLAGS       = -mthumb -mcpu=cortex-m3
BOARD_FLAGS = -D$(BOARD)
DEVICE_FLAGS = -DSTM32F10X_MD -DSTM32F10X


## =================================================================


export STDPERIPH_DIR CMSIS_DIR


# kbuild supports saving output files in a separate directory.
# To locate output files in a separate directory two syntaxes are supported.
# In both cases the working directory must be the root of the kernel src.
# 1) O=
# Use "make O=dir/to/store/output/files/"
#
# 2) Set KBUILD_OUTPUT
# Set the environment variable KBUILD_OUTPUT to point to the directory
# where the output files shall be placed.
# export KBUILD_OUTPUT=dir/to/store/output/files/
# make
#
# The O= assignment takes precedence over the KBUILD_OUTPUT environment
# variable.

# KBUILD_SRC is set on invocation of make in OBJ directory
# KBUILD_SRC is not intended to be used by the regular user (for now)
ifeq ($(KBUILD_SRC),)

# OK, Make called in directory where kernel src resides
# Do we want to locate output files in a separate directory?
ifeq ("$(origin O)", "command line")
  KBUILD_OUTPUT := $(O)
endif

# That's our default target when none is given on the command line
PHONY := _all
_all:

# Cancel implicit rules on top Makefile
$(CURDIR)/Makefile Makefile: ;

ifneq ($(KBUILD_OUTPUT),)
# Invoke a second make in the output directory, passing relevant variables
# check that the output directory actually exists
saved-output := $(KBUILD_OUTPUT)
KBUILD_OUTPUT := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) \
								&& /bin/pwd)
$(if $(KBUILD_OUTPUT),, \
     $(error failed to create output directory "$(saved-output)"))

PHONY += $(MAKECMDGOALS) sub-make

$(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
	@:

sub-make: FORCE
	$(Q)$(MAKE) -C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR) \
	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))

# Leave processing to above invocation of make
skip-makefile := 1
endif # ifneq ($(KBUILD_OUTPUT),)
endif # ifeq ($(KBUILD_SRC),)

# We process the rest of the Makefile if this is the final invocation of make
ifeq ($(skip-makefile),)

# Do not print "Entering directory ...",
# but we want to display it when entering to the output directory
# so that IDEs/editors are able to understand relative filenames.
MAKEFLAGS += --no-print-directory

# Call a source code checker (by default, "sparse") as part of the
# C compilation.
#
# Use 'make C=1' to enable checking of only re-compiled files.
# Use 'make C=2' to enable checking of *all* source files, regardless
# of whether they are re-compiled or not.
#
# See the file "Documentation/sparse.txt" for more details, including
# where to get the "sparse" utility.

ifeq ("$(origin C)", "command line")
  KBUILD_CHECKSRC = $(C)
endif
ifndef KBUILD_CHECKSRC
  KBUILD_CHECKSRC = 0
endif

PHONY += all
_all: all

ifeq ($(KBUILD_SRC),)
        # building in the source tree
        srctree := .
else
        ifeq ($(KBUILD_SRC)/,$(dir $(CURDIR)))
                # building in a subdirectory of the source tree
                srctree := ..
        else
                srctree := $(KBUILD_SRC)
        endif
endif
objtree		:= .
src		:= $(srctree)
obj		:= $(objtree)

VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD),:$(KBUILD_EXTMOD))

export srctree objtree VPATH

# Cross compiling and selecting different set of gcc/bin-utils
# ---------------------------------------------------------------------------
#
# When performing cross compilation for other architectures BOARD shall be set
# to the target architecture. (See board/* for the possibilities).
# BOARD can be set during invocation of make:
# make BOARD=ia64
# Another way is to have BOARD set in the environment.
# The default BOARD is the host where make is executed.

# CROSS_COMPILE specify the prefix used for all executables used
# during compilation. Only gcc and related bin-utils executables
# are prefixed with $(CROSS_COMPILE).
# CROSS_COMPILE can be set on the command line
# make CROSS_COMPILE=ia64-linux-
# Alternatively CROSS_COMPILE can be set in the environment.
# A third alternative is to store a setting in .config so that plain
# "make" in the configured kernel build directory always uses that.
# Default value for CROSS_COMPILE is not to prefix executables
# Note: Some architectures assign CROSS_COMPILE in their board/*/Makefile
BOARD		?= NAZE
#CROSS_COMPILE	?= $(CONFIG_CROSS_COMPILE:"%"=%)
CROSS_COMPILE ?= arm-none-eabi-

# Architecture as present in compile.h
UTS_MACHINE 	:= $(BOARD)
SRCBOARD 	:= $(BOARD)

# Where to locate arch specific headers
hdr-arch  := $(SRCBOARD)

KCONFIG_CONFIG	?= .config
export KCONFIG_CONFIG

# SHELL used by kbuild
CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
	  else if [ -x /bin/bash ]; then echo /bin/bash; \
	  else echo sh; fi ; fi)

HOSTCC       = gcc
HOSTCXX      = g++
HOSTCFLAGS   = -Wall -Wmissing-prototypes -Wstrict-prototypes -O2 -fomit-frame-pointer -std=gnu89
HOSTCXXFLAGS = -O2

ifeq ($(shell $(HOSTCC) -v 2>&1 | grep -c "clang version"), 1)
HOSTCFLAGS  += -Wno-unused-value -Wno-unused-parameter \
		-Wno-missing-field-initializers -fno-delete-null-pointer-checks
endif

# Decide whether to build built-in, modular, or both.
# Normally, just do built-in.

KBUILD_MODULES :=
KBUILD_BUILTIN := 1

export KBUILD_MODULES KBUILD_BUILTIN
export KBUILD_CHECKSRC KBUILD_SRC KBUILD_EXTMOD

# We need some generic definitions (do not try to remake the file).
scripts/Kbuild.include: ;
include scripts/Kbuild.include

# Make variables (CC, etc...)
AS		= $(CROSS_COMPILE)as
LD		= $(CROSS_COMPILE)ld
CC		= $(CROSS_COMPILE)gcc
CPP		= $(CC) -E
AR		= $(CROSS_COMPILE)ar
NM		= $(CROSS_COMPILE)nm
STRIP		= $(CROSS_COMPILE)strip
OBJCOPY		= $(CROSS_COMPILE)objcopy
OBJDUMP		= $(CROSS_COMPILE)objdump
AWK		= awk
INSTALLKERNEL  := installkernel
PERL		= perl
PYTHON		= python
CHECK		= sparse

CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
		  -Wbitwise -Wno-return-void $(CF)
CFLAGS_MODULE   =
AFLAGS_MODULE   =
LDFLAGS_MODULE  =
CFLAGS_KERNEL	=
AFLAGS_KERNEL	=
CFLAGS_GCOV	= -fprofile-arcs -ftest-coverage


# Use USERINCLUDE when you must reference the UAPI directories only.
USERINCLUDE    := \
		-I$(srctree)/board/$(hdr-arch)/include \
                -include $(srctree)/include/kconfig.h \
		-I/usr/lib/gcc/arm-none-eabi/4.9.3/include

# Use LINUXINCLUDE when you must reference the include/ directory.
# Needed to be compatible with the O= option
LINUXINCLUDE    := \
		-Iboard/$(hdr-arch)/include/generated \
		$(if $(KBUILD_SRC), -I$(srctree)/include) \
		-I. -Iinclude \
		$(USERINCLUDE) \
		$(addprefix -I,$(INCLUDE_DIRS)) 

#KBUILD_CPPFLAGS := -D__KERNEL__

KBUILD_CFLAGS   := -MMD -MP \
		   -std=gnu89 $(DEVICE_FLAGS) -DUSE_STDPERIPH_DRIVER $(ARCH_FLAGS) \
                   -D'__FORKNAME__="$(FORKNAME)"' \
                   -D'__BOARD__="$(BOARD)"' \
                   -D'__REVISION__="$(REVISION)"' \
		   -D$(BOARD) \
		    -std=gnu99 \
                   -Wall -Wpedantic -Wextra -Wunsafe-loop-optimizations -Wdouble-promotion -Wundef \
                   -ffunction-sections \
                   -fdata-sections
#-ffreestanding

KBUILD_AFLAGS_KERNEL :=
KBUILD_CFLAGS_KERNEL :=
KBUILD_AFLAGS   := -D__ASSEMBLY__

# Read KERNELRELEASE from include/config/kernel.release (if it exists)
KERNELRELEASE = $(shell cat include/config/kernel.release 2> /dev/null)
KERNELVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)

export VERSION PATCHLEVEL SUBLEVEL KERNELRELEASE KERNELVERSION
export BOARD SRCBOARD CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC
export CPP AR NM STRIP OBJCOPY OBJDUMP
export MAKE AWK PERL PYTHON UTS_MACHINE
export HOSTCXX HOSTCXXFLAGS CHECK CHECKFLAGS

export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_GCOV
export KBUILD_AFLAGS AFLAGS_KERNEL
export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
export KBUILD_ARFLAGS

# Files to ignore in find ... statements

export RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o    \
			  -name CVS -o -name .pc -o -name .hg -o -name .git \) \
			  -prune -o
export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn \
			 --exclude CVS --exclude .pc --exclude .hg --exclude .git

# ===========================================================================
# Rules shared between *config targets and build targets

# Basic helpers built in scripts/
PHONY += scripts_basic
scripts_basic:
	$(Q)$(MAKE) $(build)=scripts/basic
	$(Q)rm -f .tmp_quiet_recordmcount

# To avoid any implicit rule to kick in, define an empty command.
scripts/basic/%: scripts_basic ;

PHONY += outputmakefile
# outputmakefile generates a Makefile in the output directory, if using a
# separate output directory. This allows convenient use of make in the
# output directory.
outputmakefile:
ifneq ($(KBUILD_SRC),)
	$(Q)ln -fsn $(srctree) source
	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile \
	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)
endif

# Support for using generic headers in asm-generic
#PHONY += asm-generic
#asm-generic:
#	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.asm-generic \
	            src=asm obj=board/$(SRCBOARD)/include/generated/asm

# To make sure we do not include .config for any of the *config targets
# catch them early, and hand them over to scripts/kconfig/Makefile
# It is allowed to specify more targets when calling make, including
# mixing *config targets and build targets.
# For example 'make oldconfig all'.
# Detect when mixed targets is specified, and make a second invocation
# of make so .config is not included in this case either (for *config).

no-dot-config-targets := clean mrproper distclean \
			 cscope gtags TAGS tags help% %docs check% coccicheck \
			 headers_% archheaders archscripts \
			 kernelversion %src-pkg

config-targets := 0
mixed-targets  := 0
dot-config     := 1

ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
		dot-config := 0
	endif
endif

ifneq ($(filter config %config,$(MAKECMDGOALS)),)
	config-targets := 1
	ifneq ($(words $(MAKECMDGOALS)),1)
		mixed-targets := 1
	endif
endif

ifeq ($(mixed-targets),1)
# ===========================================================================
# We're called with mixed targets (*config and build targets).
# Handle them one by one.

PHONY += $(MAKECMDGOALS) __build_one_by_one

$(filter-out __build_one_by_one, $(MAKECMDGOALS)): __build_one_by_one
	@:

__build_one_by_one:
	$(Q)set -e; \
	for i in $(MAKECMDGOALS); do \
		$(MAKE) -f $(srctree)/Makefile $$i; \
	done

else
ifeq ($(config-targets),1)
# ===========================================================================
# *config targets only - make sure prerequisites are updated, and descend
# in scripts/kconfig to make the *config target

# Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
# KBUILD_DEFCONFIG may point out an alternative default configuration
# used for 'make defconfig'
include board/$(SRCBOARD)/Makefile
export KBUILD_DEFCONFIG KBUILD_KCONFIG

config: scripts_basic outputmakefile FORCE
	$(Q)$(MAKE) $(build)=scripts/kconfig $@

%config: scripts_basic outputmakefile FORCE
	$(Q)$(MAKE) $(build)=scripts/kconfig $@

else
# ===========================================================================
# Build targets only - this includes cleanflight, arch specific targets, clean
# targets and others. In general all targets except *config targets.

# Additional helpers built in scripts/
# Carefully list dependencies so we do not try to build scripts twice
# in parallel
PHONY += scripts
scripts: scripts_basic include/config/auto.conf
	$(Q)$(MAKE) $(build)=$(@)

# Objects we will link into cleanflight / subdirs we need to visit
init-y		:= startup/ board/ build/  
drivers-y	:= drivers/ sensors/ flight/ fc/ io/
core-y		:= common/ msp/ scheduler/ blackbox/
net-y		:= telemetry/ osd/ config/ rx/ vcp/

ifeq ($(dot-config),1)
# Read in config
-include include/config/auto.conf

# Read in dependencies to all Kconfig* files, make sure to run
# oldconfig if changes are detected.
-include include/config/auto.conf.cmd

# To avoid any implicit rule to kick in, define an empty command
$(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;

# If .config is newer than include/config/auto.conf, someone tinkered
# with it and forgot to run make oldconfig.
# if auto.conf.cmd is missing then we are probably in a cleaned tree so
# we execute the config step to be sure to catch updated Kconfig files
include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
else
# Dummy target needed, because used as prerequisite
include/config/auto.conf: ;
endif # $(dot-config)

# The all: target is the default when no target is given on the
# command line.
# This allow a user to issue only 'make' to build a kernel including modules
# Defaults to cleanflight, but the arch makefile usually adds further targets
all: cleanflight

include board/$(SRCBOARD)/Makefile

KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)

ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
else
KBUILD_CFLAGS	+= -O2
endif

# Tell gcc to never replace conditional load with a non-conditional one
KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)

ifdef CONFIG_READABLE_ASM
# Disable optimizations that make assembler listings hard to read.
# reorder blocks reorders the control in the function
# ipa clone creates specialized cloned functions
# partial inlining inlines only parts of functions
KBUILD_CFLAGS += $(call cc-option,-fno-reorder-blocks,) \
                 $(call cc-option,-fno-ipa-cp-clone,) \
                 $(call cc-option,-fno-partial-inlining)
endif

ifneq ($(CONFIG_FRAME_WARN),0)
KBUILD_CFLAGS += $(call cc-option,-Wframe-larger-than=${CONFIG_FRAME_WARN})
endif

# Handle stack protector mode.
#
# Since kbuild can potentially perform two passes (first with the old
# .config values and then with updated .config values), we cannot error out
# if a desired compiler option is unsupported. If we were to error, kbuild
# could never get to the second pass and actually notice that we changed
# the option to something that was supported.
#
# Additionally, we don't want to fallback and/or silently change which compiler
# flags will be used, since that leads to producing kernels with different
# security feature characteristics depending on the compiler used. ("But I
# selected CC_STACKPROTECTOR_STRONG! Why did it build with _REGULAR?!")
#
# The middle ground is to warn here so that the failed option is obvious, but
# to let the build fail with bad compiler flags so that we can't produce a
# kernel when there is a CONFIG and compiler mismatch.
#
ifdef CONFIG_CC_STACKPROTECTOR_REGULAR
  stackp-flag := -fstack-protector
  ifeq ($(call cc-option, $(stackp-flag)),)
    $(warning Cannot use CONFIG_CC_STACKPROTECTOR_REGULAR: \
             -fstack-protector not supported by compiler)
  endif
else
ifdef CONFIG_CC_STACKPROTECTOR_STRONG
  stackp-flag := -fstack-protector-strong
  ifeq ($(call cc-option, $(stackp-flag)),)
    $(warning Cannot use CONFIG_CC_STACKPROTECTOR_STRONG: \
	      -fstack-protector-strong not supported by compiler)
  endif
else
  # Force off for distro compilers that enable stack protector by default.
  stackp-flag := $(call cc-option, -fno-stack-protector)
endif
endif
KBUILD_CFLAGS += $(stackp-flag)

ifeq ($(shell $(CC) -v 2>&1 | grep -c "clang version"), 1)
COMPILER := clang
else
COMPILER := gcc
endif
export COMPILER

ifeq ($(COMPILER),clang)
KBUILD_CPPFLAGS += $(call cc-option,-Qunused-arguments,)
KBUILD_CPPFLAGS += $(call cc-option,-Wno-unknown-warning-option,)
KBUILD_CFLAGS += $(call cc-disable-warning, unused-variable)
KBUILD_CFLAGS += $(call cc-disable-warning, format-invalid-specifier)
KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
# Quiet clang warning: comparison of unsigned expression < 0 is always false
KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
# CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
# source of a reference will be _MergedGlobals and not on of the whitelisted names.
# See modpost pattern 2
KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
else

# This warning generated too much noise in a regular build.
# Use make W=1 to enable this warning (see scripts/Makefile.build)
KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
endif

ifdef CONFIG_FRAME_POINTER
KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
else
# Some targets (ARM with Thumb2, for example), can't be built with frame
# pointers.  For those, we don't have FUNCTION_TRACER automatically
# select FRAME_POINTER.  However, FUNCTION_TRACER adds -pg, and this is
# incompatible with -fomit-frame-pointer with current GCC, so we don't use
# -fomit-frame-pointer with FUNCTION_TRACER.
ifndef CONFIG_FUNCTION_TRACER
KBUILD_CFLAGS	+= -fomit-frame-pointer
endif
endif

KBUILD_CFLAGS   += $(call cc-option, -fno-var-tracking-assignments)

ifdef CONFIG_DEBUG_INFO
ifdef CONFIG_DEBUG_INFO_SPLIT
KBUILD_CFLAGS   += $(call cc-option, -gsplit-dwarf, -g)
else
KBUILD_CFLAGS	+= -g
endif
KBUILD_AFLAGS	+= -Wa,-gdwarf-2
endif
ifdef CONFIG_DEBUG_INFO_DWARF4
KBUILD_CFLAGS	+= $(call cc-option, -gdwarf-4,)
endif

ifdef CONFIG_DEBUG_INFO_REDUCED
KBUILD_CFLAGS 	+= $(call cc-option, -femit-struct-debug-baseonly) \
		   $(call cc-option,-fno-var-tracking)
endif

# We trigger additional mismatches with less inlining
ifdef CONFIG_DEBUG_SECTION_MISMATCH
KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
endif

# warn about C99 declaration after statement
#KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)

# disable pointer signed / unsigned warnings in gcc 4.0
KBUILD_CFLAGS += $(call cc-disable-warning, pointer-sign)

# disable invalid "can't wrap" optimizations for signed / pointers
KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)

# conserve stack if available
KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)

# disallow errors like 'EXPORT_GPL(foo);' with missing header
KBUILD_CFLAGS   += $(call cc-option,-Werror=implicit-int)

# require functions to have arguments in prototypes, not empty 'int foo()'
#KBUILD_CFLAGS   += $(call cc-option,-Werror=strict-prototypes)

# Prohibit date/time macros, which would make the build non-deterministic
KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)

# use the deterministic mode of AR if available
KBUILD_ARFLAGS := $(call ar-option,D)

# check for 'asm goto'
ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC)), y)
	KBUILD_CFLAGS += -DCC_HAVE_ASM_GOTO
	KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
endif

include scripts/Makefile.extrawarn

# Add any arch overrides and user supplied CPPFLAGS, AFLAGS and CFLAGS as the
# last assignments
KBUILD_CPPFLAGS += $(BOARD_CPPFLAGS) $(KCPPFLAGS)
KBUILD_AFLAGS   += $(BOARD_AFLAGS)   $(KAFLAGS)
KBUILD_CFLAGS   += $(BOARD_CFLAGS)   $(KCFLAGS)

# Use --build-id when available.
LDFLAGS_BUILD_ID = $(patsubst -Wl$(comma)%,%,\
			      $(call cc-ldoption, -Wl$(comma)--build-id,))
KBUILD_LDFLAGS_MODULE += $(LDFLAGS_BUILD_ID)
LDFLAGS_cleanflight += $(LDFLAGS_BUILD_ID)

ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
LDFLAGS_cleanflight	+= $(call ld-option, -X,)
endif

# Default kernel image to build when no specific target is given.
# KBUILD_IMAGE may be overruled on the command line or
# set in the environment
# Also any assignments in board/$(BOARD)/Makefile take precedence over
# this default value
export KBUILD_IMAGE ?= cleanflight

#
# INSTALL_PATH specifies where to place the updated kernel and system map
# images. Default is /boot, but you can set it to other values
export	INSTALL_PATH ?= /obj

mod_strip_cmd = true
export mod_strip_cmd

mod_compress_cmd = true
mod_compress_cmd = gzip -n
export mod_compress_cmd


mod_sign_cmd = true
export mod_sign_cmd

cleanflight-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) \
		     $(core-y) $(drivers-y)  $(net-y) $(libs-y) ))

cleanflight-alldirs	:= $(sort $(cleanflight-dirs) $(patsubst %/,%,$(filter %/, \
		     $(init-) $(core-) $(drivers-) $(net-) $(libs-))))

init-y		:= $(patsubst %/, %/built-in.o, $(init-y))
core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
net-y		:= $(patsubst %/, %/built-in.o, $(net-y))
libs-y1		:= $(patsubst %/, %/lib.a, $(libs-y))
libs-y2		:= $(patsubst %/, %/built-in.o, $(libs-y))
libs-y		:= $(libs-y1) $(libs-y2)

# Externally visible symbols (used by link-cleanflight.sh)
export KBUILD_CLEANFLIGHT_INIT := $(head-y) $(init-y)
export KBUILD_CLEANFLIGHT_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y)


export LDFLAGS_cleanflight
# used by scripts/pacmage/Makefile
export KBUILD_ALLDIRS := $(sort $(filter-out board/%,$(cleanflight-alldirs)) board Documentation include scripts tools)

cleanflight-deps := $(KBUILD_LDS) $(KBUILD_CLEANFLIGHT_INIT) $(KBUILD_CLEANFLIGHT_MAIN)

# Final link of cleanflight
      cmd_link-cleanflight = $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_cleanflight)
quiet_cmd_link-cleanflight = LINK    $@

# Include targets which we want to
# execute if the rest of the kernel build went well.
cleanflight: scripts/link-cleanflight.sh $(cleanflight-deps) FORCE
	$(call if_changed,link-cleanflight)


# The actual objects are generated when descending,
# make sure no implicit rule kicks in
$(sort $(cleanflight-deps)): $(cleanflight-dirs) ;

# Handle descending into subdirectories listed in $(cleanflight-dirs)
# Preset locale variables to speed up the build process. Limit locale
# tweaks to this spot to avoid wrong language settings when running
# make menuconfig etc.
# Error messages still appears in the original language

PHONY += $(cleanflight-dirs)
$(cleanflight-dirs): prepare scripts
	$(Q)$(MAKE) $(build)=$@

define filechk_kernel.release
	echo "$(KERNELVERSION)$$($(CONFIG_SHELL) $(srctree)/scripts/setlocalversion $(srctree))"
endef

# Store (new) KERNELRELEASE string in include/config/kernel.release
include/config/kernel.release: include/config/auto.conf FORCE
	$(call filechk,kernel.release)


# Things we need to do before we recursively start building the kernel
# or the modules are listed in "prepare".
# A multi level approach is used. prepareN is processed before prepareN-1.
# archprepare is used in arch Makefiles and when processed asm symlink,
# version.h and scripts_basic is processed / created.

# Listed in dependency order
PHONY += prepare archprepare prepare0 prepare1 prepare2 

# prepare2 creates a makefile if using a separate output directory
prepare2:  outputmakefile

prepare1: prepare2 include/config/auto.conf

archprepare: archheaders archscripts prepare1 scripts_basic

prepare0: archprepare FORCE
	$(Q)$(MAKE) $(build)=.

# All the preparing..
prepare: prepare0

# Generate some files
# ---------------------------------------------------------------------------

PHONY += headerdep
headerdep:
	$(Q)find $(srctree)/include/ -name '*.h' | xargs --max-args 1 \
	$(srctree)/scripts/headerdep.pl -I$(srctree)/include

# ---------------------------------------------------------------------------
# Kernel headers

#Default location for installed headers
export INSTALL_HDR_PATH = $(objtree)/usr

# If we do an all arch process set dst to asm-$(hdr-arch)
hdr-dst = $(if $(KBUILD_HEADERS), dst=include/asm-$(hdr-arch), dst=include/asm)

PHONY += archheaders
archheaders:

PHONY += archscripts
archscripts:

PHONY += __headers
__headers: scripts_basic archheaders archscripts FORCE
	$(Q)$(MAKE) $(build)=scripts build_unifdef


###
# Cleaning is done on three levels.
# make clean     Delete most generated files
#                Leave enough to build external modules
# make mrproper  Delete the current configuration, and all generated files
# make distclean Remove editor backup files, patch leftover files and the like

# Directories & files removed with 'make mrproper'
MRPROPER_DIRS  += include/config usr/include include/generated          \
		  board/*/include/generated .tmp_objdiff
MRPROPER_FILES += .config .config.old .version .old_version \
		  Module.symvers tags TAGS cscope* GPATH GTAGS GRTAGS GSYMS \
		  signing_key.priv signing_key.x509 x509.genkey		\
		  extra_certificates signing_key.x509.keyid		\
		  signing_key.x509.signer cleanflight-gdb.py

# clean - Delete most, but leave enough to build external modules
#
clean: rm-dirs  := $(CLEAN_DIRS)
clean: rm-files := $(CLEAN_FILES)
clean-dirs      := $(addprefix _clean_, . $(cleanflight-alldirs))

PHONY += $(clean-dirs) clean archclean cleanflightclean
$(clean-dirs):
	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)

cleanflightclean:
	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-cleanflight.sh clean

clean: archclean cleanflightclean

# mrproper - Delete all generated files, including .config
#
mrproper: rm-dirs  := $(wildcard $(MRPROPER_DIRS))
mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
mrproper-dirs      := $(addprefix _mrproper_,scripts)

PHONY += $(mrproper-dirs) mrproper archmrproper
$(mrproper-dirs):
	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)

mrproper: clean archmrproper $(mrproper-dirs)
	$(call cmd,rmdirs)
	$(call cmd,rmfiles)

# distclean
#
PHONY += distclean

distclean: mrproper
	@find $(srctree) $(RCS_FIND_IGNORE) \
		\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
		-o -name '.*.rej' -o -name '*%'  -o -name 'core' \) \
		-type f -print | xargs rm -f


# ---------------------------------------------------------------------------

boards := $(wildcard $(srctree)/board/$(SRCBOARD)/configs/*_defconfig)
boards := $(sort $(notdir $(boards)))
board-dirs := $(dir $(wildcard $(srctree)/board/$(SRCBOARD)/configs/*/*_defconfig))
board-dirs := $(sort $(notdir $(board-dirs:/=)))

help:
	@echo  'Cleaning targets:'
	@echo  '  clean		  - Remove most generated files but keep the config and'
	@echo  '                    enough build support to build external modules'
	@echo  '  mrproper	  - Remove all generated files + config + various backup files'
	@echo  '  distclean	  - mrproper + remove editor backup and patch files'
	@echo  ''
	@echo  'Configuration targets:'
	@$(MAKE) -f $(srctree)/scripts/kconfig/Makefile help
	@echo  ''
	@echo  'Other generic targets:'
	@echo  '  all		  - Build all targets marked with [*]'
	@echo  '* cleanflight	  - Build the bare kernel'
	@echo  '  firmware_install- Install all firmware to INSTALL_FW_PATH'
	@echo  '                    (default: $$(INSTALL_MOD_PATH)/lib/firmware)'
	@echo  '  dir/            - Build all files in dir and below'
	@echo  '  dir/file.[oisS] - Build specified target only'
	@echo  '  dir/file.lst    - Build specified mixed source/assembly target only'
	@echo  '                    (requires a recent binutils and recent build (System.map))'
	@echo  '  dir/file.ko     - Build module including final link'
	@echo  '  tags/TAGS	  - Generate tags file for editors'
	@echo  '  cscope	  - Generate cscope index'
	@echo  '  gtags           - Generate GNU GLOBAL index'
	@echo  '  kernelrelease	  - Output the release version string (use with make -s)'
	@echo  '  kernelversion	  - Output the version stored in Makefile (use with make -s)'
	@echo  '  image_name	  - Output the image name (use with make -s)'
	@echo  '  headers_install - Install sanitised kernel headers to INSTALL_HDR_PATH'; \
	 echo  '                    (default: $(INSTALL_HDR_PATH))'; \
	 echo  ''
	@echo  'Static analysers'
	@echo  '  checkstack      - Generate a list of stack hogs'
	@echo  '  namespacecheck  - Name space analysis on compiled kernel'
	@echo  '  versioncheck    - Sanity check on version.h usage'
	@echo  '  includecheck    - Check for duplicate included header files'
	@echo  '  export_report   - List the usages of all exported symbols'
	@echo  '  headers_check   - Sanity check on exported headers'
	@echo  '  headerdep       - Detect inclusion cycles in headers'
	@$(MAKE) -f $(srctree)/scripts/Makefile.help checker-help
	@echo  ''
	@echo  'Kernel selftest'
	@echo  '  kselftest       - Build and run kernel selftest (run as root)'
	@echo  '                    Build, install, and boot kernel before'
	@echo  '                    running kselftest on it'
	@echo  ''
	@echo  'Kernel packaging:'
	@$(MAKE) $(build)=$(package-dir) help
	@echo  ''
	@echo  'Documentation targets:'
	@$(MAKE) -f $(srctree)/Documentation/DocBook/Makefile dochelp
	@echo  ''
	@echo  'Architecture specific targets ($(SRCBOARD)):'
	@$(if $(archhelp),$(archhelp),\
		echo '  No architecture specific help defined for $(SRCBOARD)')
	@echo  ''
	@$(if $(boards), \
		$(foreach b, $(boards), \
		printf "  %-24s - Build for %s\\n" $(b) $(subst _defconfig,,$(b));) \
		echo '')
	@$(if $(board-dirs), \
		$(foreach b, $(board-dirs), \
		printf "  %-16s - Show %s-specific targets\\n" help-$(b) $(b);) \
		printf "  %-16s - Show all of the above\\n" help-boards; \
		echo '')

	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
	@echo  '  make V=2   [targets] 2 => give reason for rebuild of target'
	@echo  '  make O=dir [targets] Locate all output files in "dir", including .config'
	@echo  '  make C=1   [targets] Check all c source with $$CHECK (sparse by default)'
	@echo  '  make C=2   [targets] Force check of all c source with $$CHECK'
	@echo  '  make RECORDMCOUNT_WARN=1 [targets] Warn about ignored mcount sections'
	@echo  '  make W=n   [targets] Enable extra gcc checks, n=1,2,3 where'
	@echo  '		1: warnings which may be relevant and do not occur too often'
	@echo  '		2: warnings which occur quite often but may still be relevant'
	@echo  '		3: more obscure warnings, can most likely be ignored'
	@echo  '		Multiple levels can be combined with W=12 or W=123'
	@echo  ''
	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
	@echo  'For further info see the ./README file'


help-board-dirs := $(addprefix help-,$(board-dirs))

help-boards: $(help-board-dirs)

boards-per-dir = $(sort $(notdir $(wildcard $(srctree)/board/$(SRCBOARD)/configs/$*/*_defconfig)))

$(help-board-dirs): help-%:
	@echo  'Board specific targets ($(SRCBOARD) $*):'
	@$(if $(boards-per-dir), \
		$(foreach b, $(boards-per-dir), \
		printf "  %-24s - Build for %s\\n" $*/$(b) $(subst _defconfig,,$(b));) \
		echo '')


clean: $(clean-dirs)
	$(call cmd,rmdirs)
	$(call cmd,rmfiles)
	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
		\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
		-o -name '*.ko.*' \
		-o -name '*.dwo'  \
		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
		-o -name '*.symtypes' -o -name 'modules.order' \
		-o -name modules.builtin -o -name '.tmp_*.o.*' \
		-o -name '*.gcno' \) -type f -print | xargs rm -f

# Generate tags for editors
# ---------------------------------------------------------------------------
quiet_cmd_tags = GEN     $@
      cmd_tags = $(CONFIG_SHELL) $(srctree)/scripts/tags.sh $@

tags TAGS cscope gtags: FORCE
	$(call cmd,tags)

# Scripts to check various things for consistency
# ---------------------------------------------------------------------------

PHONY += includecheck coccicheck namespacecheck export_report

includecheck:
	find $(srctree)/* $(RCS_FIND_IGNORE) \
		-name '*.[hcS]' -type f -print | sort \
		| xargs $(PERL) -w $(srctree)/scripts/checkincludes.pl

coccicheck:
	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/$@

namespacecheck:
	$(PERL) $(srctree)/scripts/namespace.pl

export_report:
	$(PERL) $(srctree)/scripts/export_report.pl

endif #ifeq ($(config-targets),1)
endif #ifeq ($(mixed-targets),1)

PHONY += image_name

image_name:
	@echo $(KBUILD_IMAGE)

# Clear a bunch of variables before executing the submake
tools/: FORCE
	$(Q)mkdir -p $(objtree)/tools
	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(O) subdir=tools -C $(src)/tools/

tools/%: FORCE
	$(Q)mkdir -p $(objtree)/tools
	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(filter --j% -j,$(MAKEFLAGS))" O=$(O) subdir=tools -C $(src)/tools/ $*

# Single targets
# ---------------------------------------------------------------------------
# Single targets are compatible with:
# - build with mixed source and output
# - build with separate output dir 'make O=...'
# - external modules
#
#  target-dir => where to store outputfile
#  build-dir  => directory in kernel source tree to use

build-dir  = $(patsubst %/,%,$(dir $@))
target-dir = $(dir $@)

%.s: %.c prepare scripts FORCE
	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
%.i: %.c prepare scripts FORCE
	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
%.o: %.c prepare scripts FORCE
	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
%.lst: %.c prepare scripts FORCE
	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
%.s: %.S prepare scripts FORCE
	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
%.o: %.S prepare scripts FORCE
	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
%.symtypes: %.c prepare scripts FORCE
	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)

# Modules
/: prepare scripts FORCE
	$(cmd_crmodverdir)
	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
	$(build)=$(build-dir)
# Make sure the latest headers are built for Documentation
Documentation/: headers_install
%/: prepare scripts FORCE
	$(cmd_crmodverdir)
	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
	$(build)=$(build-dir)

# FIXME Should go into a make.lib or something
# ===========================================================================

quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
      cmd_rmdirs = rm -rf $(rm-dirs)

quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
      cmd_rmfiles = rm -f $(rm-files)

# Run depmod only if we have System.map and depmod is executable
quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
      cmd_depmod = $(CONFIG_SHELL) $(srctree)/scripts/depmod.sh $(DEPMOD) \
                   $(KERNELRELEASE) "$(patsubst y,_,$(CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX))"

# read all saved command lines

targets := $(wildcard $(sort $(targets)))
cmd_files := $(wildcard .*.cmd $(foreach f,$(targets),$(dir $(f)).$(notdir $(f)).cmd))

ifneq ($(cmd_files),)
  $(cmd_files): ;	# Do not try to update included dependency files
  include $(cmd_files)
endif

endif	# skip-makefile

PHONY += FORCE
FORCE:

# Declare the contents of the .PHONY variable as phony.  We keep that
# information in a variable so we can use it in if_changed and friends.
.PHONY: $(PHONY)
