#
# Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
#

TOPDIR = .
HAVE_BUILDDEFS = $(shell test -f $(TOPDIR)/include/builddefs && echo yes || echo no)

ifeq ($(HAVE_BUILDDEFS), yes)
include $(TOPDIR)/include/builddefs
endif

CONFIGURE = configure include/builddefs
LSRCFILES = configure configure.in aclocal.m4 Makepkgs install-sh README VERSION

LDIRT = config.log .dep config.status config.cache confdefs.h conftest* \
	Logs/* built .census install.* install-dev.* *.gz

LIB_SUBDIRS = include libdm
TOOL_SUBDIRS = m4 man doc debian build

SUBDIRS = $(LIB_SUBDIRS) $(TOOL_SUBDIRS)

default: include/builddefs
ifeq ($(HAVE_BUILDDEFS), no)
	$(MAKE) -C . $@
else
	$(MAKE) $(SUBDIRS)
endif

# tool/lib dependencies
# There don't appear to be any dependencies between subdirs

ifeq ($(HAVE_BUILDDEFS), yes)
include $(BUILDRULES)
else
clean:	# if configure hasn't run, nothing to clean
endif

configure include/builddefs:
	autoconf
	./configure \
		--prefix=/ \
		--exec-prefix=/ \
		--sbindir=/bin \
		--bindir=/usr/bin \
		--libdir=/lib \
		--libexecdir=/usr/lib \
		--enable-lib64=yes \
		--includedir=/usr/include \
		--mandir=/usr/share/man \
		--datadir=/usr/share \
		$$LOCAL_CONFIGURE_OPTIONS
	touch .census

aclocal.m4::
	aclocal --acdir=`pwd`/m4 --output=$@

install: default $(addsuffix -install,$(SUBDIRS))
ifneq ($(PKG_DISTRIBUTION), debian)
	$(INSTALL) -m 755 -d $(PKG_DOC_DIR)
	$(INSTALL) -m 644 README $(PKG_DOC_DIR)
endif

install-dev: default $(addsuffix -install-dev,$(SUBDIRS))

%-install:
	$(MAKE) -C $* install

%-install-dev:
	$(MAKE) -C $* install-dev

realclean distclean: clean
	rm -f $(LDIRT) $(CONFIGURE)
	rm -rf autom4te.cache Logs
