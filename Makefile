# Copyright (C) 2002 John Goerzen
# <jgoerzen@complete.org>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
SHELL=/bin/bash

clean:
	-python2.2 setup.py clean --all
	-rm -f `find . -name "*~"`
	-rm -f `find . -name "*.tmp"`
	-rm -f bin/offlineimapc
	-rm -f `find . -name "*.pyc"`
	-rm -f `find . -name "*.pygc"`
	-rm -f `find . -name "*.class"`
	-rm -f `find . -name "*.bak"`
	-rm -f `find . -name ".cache*"`
	-rm manpage.links
	-rm manpage.refs
	-find . -name auth -exec rm -vf {}/password {}/username \;
	-svn cleanup

changelog:
	svn log -v > ChangeLog

docs:
	docbook2man offlineimap.sgml
	docbook2man offlineimap.sgml
	docbook2html -u offlineimap.sgml
	mv offlineimap.html manual.html
	man -t -l offlineimap.1 > manual.ps
	ps2pdf manual.ps
	groff -Tascii -man offlineimap.1 | sed $$'s/.\b//g' > manual.txt
	-rm manpage.links manpage.refs

