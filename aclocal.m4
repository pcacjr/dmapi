# aclocal.m4 generated automatically by aclocal 1.6.3 -*- Autoconf -*-

# Copyright 1996, 1997, 1998, 1999, 2000, 2001, 2002
# Free Software Foundation, Inc.
# This file is free software; the Free Software Foundation
# gives unlimited permission to copy and/or distribute it,
# with or without modifications, as long as this notice is preserved.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# 
# Generic macro, sets up all of the global packaging variables.
# The following environment variables may be set to override defaults:
#   DEBUG OPTIMIZER MALLOCLIB PLATFORM DISTRIBUTION INSTALL_USER INSTALL_GROUP
#   BUILD_VERSION
#
AC_DEFUN([AC_PACKAGE_GLOBALS],
  [ pkg_name="$1"
    AC_SUBST(pkg_name)

    . ./VERSION
    pkg_version=${PKG_MAJOR}.${PKG_MINOR}.${PKG_REVISION}
    AC_SUBST(pkg_version)
    pkg_release=$PKG_BUILD
    test -z "$BUILD_VERSION" || pkg_release="$BUILD_VERSION"
    AC_SUBST(pkg_release)

    DEBUG=${DEBUG:-'-DDEBUG'}		dnl  -DNDEBUG
    debug_build="$DEBUG"
    AC_SUBST(debug_build)

    OPTIMIZER=${OPTIMIZER:-'-g'}	dnl  -O2
    opt_build="$OPTIMIZER"
    AC_SUBST(opt_build)

    MALLOCLIB=${MALLOCLIB:-''}		dnl  /usr/lib/libefence.a
    malloc_lib="$MALLOCLIB"
    AC_SUBST(malloc_lib)

    PKG_USER=${INSTALL_USER:-'root'}
    pkg_user="$PKG_USER"
    AC_SUBST(pkg_user)

    PKG_GROUP=${INSTALL_GROUP:-'root'}
    pkg_group="$PKG_GROUP"
    AC_SUBST(pkg_group)

    pkg_distribution=`uname -s`
    test -z "$DISTRIBUTION" || pkg_distribution="$DISTRIBUTION"
    AC_SUBST(pkg_distribution)

    pkg_platform=`uname -s | tr 'A-Z' 'a-z' | sed -e 's/irix64/irix/'`
    test -z "$PLATFORM" || pkg_platform="$PLATFORM"
    AC_SUBST(pkg_platform)
  ])

#
# Check for specified utility (env var) - if unset, fail.
# 
AC_DEFUN([AC_PACKAGE_NEED_UTILITY],
  [ if test -z "$2"; then
        echo
        echo FATAL ERROR: $3 does not seem to be installed.
        echo $1 cannot be built without a working $4 installation.
        exit 1
    fi
  ])

#
# Generic macro, sets up all of the global build variables.
# The following environment variables may be set to override defaults:
#  CC MAKE LIBTOOL TAR ZIP MAKEDEPEND AWK SED ECHO SORT
#  MSGFMT MSGMERGE RPM
#
AC_DEFUN([AC_PACKAGE_UTILITIES],
  [ AC_PROG_CC
    cc="$CC"
    AC_SUBST(cc)
    AC_PACKAGE_NEED_UTILITY($1, "$cc", cc, [C compiler])

    if test -z "$MAKE"; then
        AC_PATH_PROG(MAKE, gmake,, /usr/bin:/usr/local/bin:/usr/freeware/bin)
    fi
    if test -z "$MAKE"; then
        AC_PATH_PROG(MAKE, make,, /usr/bin)
    fi
    make=$MAKE
    AC_SUBST(make)
    AC_PACKAGE_NEED_UTILITY($1, "$make", make, [GNU make])

    if test -z "$LIBTOOL"; then
	AC_PATH_PROG(LIBTOOL, glibtool,, /usr/bin)
    fi
    if test -z "$LIBTOOL"; then
	AC_PATH_PROG(LIBTOOL, libtool,, /usr/bin:/usr/local/bin:/usr/freeware/bin)
    fi
    libtool=$LIBTOOL
    AC_SUBST(libtool)
    AC_PACKAGE_NEED_UTILITY($1, "$libtool", libtool, [GNU libtool])

    if test -z "$TAR"; then
        AC_PATH_PROG(TAR, tar,, /usr/freeware/bin:/bin:/usr/local/bin:/usr/bin)
    fi
    tar=$TAR
    AC_SUBST(tar)
    if test -z "$ZIP"; then
        AC_PATH_PROG(ZIP, gzip,, /bin:/usr/bin:/usr/local/bin:/usr/freeware/bin)
    fi

    zip=$ZIP
    AC_SUBST(zip)

    if test -z "$MAKEDEPEND"; then
        AC_PATH_PROG(MAKEDEPEND, makedepend, /bin/true)
    fi
    makedepend=$MAKEDEPEND
    AC_SUBST(makedepend)

    if test -z "$AWK"; then
        AC_PATH_PROG(AWK, awk,, /bin:/usr/bin)
    fi
    awk=$AWK
    AC_SUBST(awk)

    if test -z "$SED"; then
        AC_PATH_PROG(SED, sed,, /bin:/usr/bin)
    fi
    sed=$SED
    AC_SUBST(sed)

    if test -z "$ECHO"; then
        AC_PATH_PROG(ECHO, echo,, /bin:/usr/bin)
    fi
    echo=$ECHO
    AC_SUBST(echo)

    if test -z "$SORT"; then
        AC_PATH_PROG(SORT, sort,, /bin:/usr/bin)
    fi
    sort=$SORT
    AC_SUBST(sort)

    dnl check if symbolic links are supported
    AC_PROG_LN_S

    if test "$enable_gettext" = yes; then
        if test -z "$MSGFMT"; then
                AC_PATH_PROG(MSGFMT, msgfmt,, /usr/bin:/usr/local/bin:/usr/freeware/bin)
        fi
        msgfmt=$MSGFMT
        AC_SUBST(msgfmt)
        AC_PACKAGE_NEED_UTILITY($1, "$msgfmt", msgfmt, gettext)

        if test -z "$MSGMERGE"; then
                AC_PATH_PROG(MSGMERGE, msgmerge,, /usr/bin:/usr/local/bin:/usr/freeware/bin)
        fi
        msgmerge=$MSGMERGE
        AC_SUBST(msgmerge)
        AC_PACKAGE_NEED_UTILITY($1, "$msgmerge", msgmerge, gettext)
    fi

    if test -z "$RPM"; then
        AC_PATH_PROG(RPM, rpm,, /bin:/usr/bin:/usr/freeware/bin)
    fi
    rpm=$RPM
    AC_SUBST(rpm)

    dnl .. and what version is rpm
    rpm_version=0
    test -x "$RPM" && rpm_version=`$RPM --version \
                        | awk '{print $NF}' | awk -F. '{V=1; print $V}'`
    AC_SUBST(rpm_version)
    dnl At some point in rpm 4.0, rpm can no longer build rpms, and
    dnl rpmbuild is needed (rpmbuild may go way back; not sure)
    dnl So, if rpm version >= 4.0, look for rpmbuild.  Otherwise build w/ rpm
    if test $rpm_version -ge 4; then
        AC_PATH_PROG(RPMBUILD, rpmbuild)
        rpmbuild=$RPMBUILD
    else
        rpmbuild=$RPM
    fi
    AC_SUBST(rpmbuild)
  ])

AC_DEFUN([AC_PACKAGE_NEED_XFS_LIBXFS_H],
  [ AC_CHECK_HEADERS([xfs/libxfs.h])
    if test "$ac_cv_header_xfs_libxfs_h" != "yes"; then
        echo
        echo 'FATAL ERROR: cannot find a valid <xfs/libxfs.h> header file.'
        echo 'Install or upgrade the XFS development package.'
        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
        exit 1
    fi
  ])

AC_DEFUN([AC_PACKAGE_NEED_XFS_XQM_H],
  [ AC_CHECK_HEADERS([xfs/xqm.h])
    if test "$ac_cv_header_xfs_xqm_h" != "yes"; then
        echo
        echo 'FATAL ERROR: cannot find a valid <xfs/xqm.h> header file.'
        echo 'Install or upgrade the XFS development package.'
        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
        exit 1
    fi
  ])

AC_DEFUN([AC_PACKAGE_NEED_XFS_HANDLE_H],
  [ AC_CHECK_HEADERS([xfs/handle.h])
    if test "$ac_cv_header_xfs_handle_h" != "yes"; then
        echo
        echo 'FATAL ERROR: cannot find a valid <xfs/handle.h> header file.'
        echo 'Install or upgrade the XFS development package.'
        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
        exit 1
    fi
  ])

AC_DEFUN([AC_PACKAGE_NEED_LIBXFSINIT_LIBXFS],
  [ AC_CHECK_LIB(xfs, libxfs_init,, [
        echo
        echo 'FATAL ERROR: could not find a valid XFS base library.'
        echo 'Install or upgrade the XFS library package.'
        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
        exit 1
    ])
    libxfs="-lxfs"
    test -f `pwd`/../xfsprogs/libxfs/libxfs.la && \
        libxfs="`pwd`/../xfsprogs/libxfs/libxfs.la"
    test -f /usr/lib/libxfs.la && libxfs="/usr/lib/libxfs.la"
    AC_SUBST(libxfs)
  ])

AC_DEFUN([AC_PACKAGE_NEED_OPEN_BY_FSHANDLE],
  [ AC_CHECK_LIB(handle, open_by_fshandle,, [
        echo
        echo 'FATAL ERROR: could not find a current XFS handle library.'
        echo 'Install or upgrade the XFS library package.'
        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
        exit 1
    ])
    libhdl="-lhandle"
    test -f `pwd`/../xfsprogs/libhandle/libhandle.la && \
        libhdl="`pwd`/../xfsprogs/libhandle/libhandle.la"
    test -f /usr/lib/libhandle.la && libhdl="/usr/lib/libhandle.la"
    AC_SUBST(libhdl)
  ])

AC_DEFUN([AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE],
  [ AC_CHECK_LIB(handle, attr_list_by_handle,, [
        echo
        echo 'FATAL ERROR: could not find a current XFS handle library.'
        echo 'Install or upgrade the XFS library package.'
        echo 'Alternatively, run "make install-lib" from the xfsprogs source.'
        exit 1
    ])
    libhdl="-lhandle"
    test -f `pwd`/../xfsprogs/libhandle/libhandle.la && \
        libhdl="`pwd`/../xfsprogs/libhandle/libhandle.la"
    test -f /usr/lib/libhandle.la && libhdl="/usr/lib/libhandle.la"
    AC_SUBST(libhdl)
  ])

AC_DEFUN([AC_PACKAGE_NEED_XFSCTL_MACRO],
  [ AC_MSG_CHECKING([xfsctl from xfs/libxfs.h])
    AC_TRY_LINK([#include <xfs/libxfs.h>], [ int x = xfsctl(0, 0, 0, 0); ],
      [ echo ok ],
      [ echo
        echo 'FATAL ERROR: cannot find required macros in the XFS headers.'
        echo 'Upgrade your XFS programs (xfsprogs) development package.'
        echo 'Alternatively, run "make install-dev" from the xfsprogs source.'
        exit 1
      ])
  ])

# 
# Find format of installed man pages.
# Always gzipped on Debian, but not Redhat pre-7.0.
# We don't deal with bzip2'd man pages, which Mandrake uses,
# someone will send us a patch sometime hopefully. :-)
# 
AC_DEFUN([AC_MANUAL_FORMAT],
  [ have_zipped_manpages=false
    for d in ${prefix}/share/man ${prefix}/man ; do
        if test -f $d/man1/man.1.gz
        then
            have_zipped_manpages=true
            break
        fi
    done
    AC_SUBST(have_zipped_manpages)
  ])

