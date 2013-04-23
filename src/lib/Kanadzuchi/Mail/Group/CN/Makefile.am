# $Id: Makefile.am,v 1.1.2.2 2013/04/18 10:56:28 ak Exp $
# Copyright (C) 2009-2011 Cubicroot Co. Ltd.
# This is the auto-Makefile for bounceHammer/src/lib/Kanadzuchi/Mail/Group/CN,
# is processed by automake to create Makefile.in.

distdir = $(BUILDROOT)/dist/lib/Kanadzuchi/Mail/Group/CN
pkgdatadir = @libdir@/Kanadzuchi/Mail/Group/CN
pkgdata_DATA = Cellphone.pm Smartphone.pm WebMail.pm

all-am:
	test -d $(distdir) || mkdir -p $(distdir)
	cp -Rp $(pkgdata_DATA) $(distdir)/

.PHONY: clean
clean:
	rm -f $(distdir)/*.pm

