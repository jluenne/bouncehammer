# $Id: Makefile.am,v 1.4.2.2 2013/08/28 10:07:46 ak Exp $
# Copyright (C) 2009,2010,2013 Cubicroot Co. Ltd.
# This is the auto-Makefile for bounceHammer/src/lib/Kanadzuchi/Mail/Bounced,
# is processed by automake to create Makefile.in.
distdir = $(BUILDROOT)/dist/lib/Kanadzuchi/Mail/Bounced
pkgdatadir = @libdir@/Kanadzuchi/Mail/Bounced
pkgdata_DATA = Generic.pm

all-am:
	test -d $(distdir) || mkdir -p $(distdir)
	cp -Rp $(pkgdata_DATA) $(distdir)/

.PHONY: clean
clean:
	rm -f $(distdir)/*.pm

