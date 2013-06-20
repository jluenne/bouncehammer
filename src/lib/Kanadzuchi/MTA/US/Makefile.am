# $Id: Makefile.am,v 1.1.2.3 2013/06/20 11:37:05 ak Exp $
# Copyright (C) 2009,2010 Cubicroot Co. Ltd.
# This is the auto-Makefile for bounceHammer/src/lib/Kanadzuchi/MTA/US,
# is processed by automake to create Makefile.in.

distdir = $(BUILDROOT)/dist/lib/Kanadzuchi/MTA/US
pkgdatadir = @libdir@/Kanadzuchi/MTA/US
pkgdata_DATA = Google.pm Facebook.pm Verizon.pm

all-am:
	test -d $(distdir) || mkdir -p $(distdir)
	cp -Rp $(pkgdata_DATA) $(distdir)/

.PHONY: clean
clean:
	rm -f $(distdir)/*.pm

