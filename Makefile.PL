use ExtUtils::MakeMaker;
my $VERSION = '0.01';
if (-d ".git") {
	$VERSION = `git describe --tags`;
	$VERSION =~ s/-.*$//;
}
WriteMakefile(
	NAME => 'xdg-menu',
	VERSION => $VERSION,
	LICENSE => 'perl',
	ABSTRACT => 'XDG compliant system tray and root menu generator',
	AUTHOR => 'Brian Bidulock <bidulock@openss7.org>',
	EXE_FILES => [
		'xdg-icon',
		'xdg-traymenu',
		'xdg-menugen',
		'wm-winlist',
		'wm-winmenu',
	],
	PREREQ_PM => {
		'Carp' => 0,			# perl
		'Encode' => 0,			# perl
		'File::Path' => 0,		# perl
		'Getopt::Long' => 0,		# perl
		'Glib' => 0,			# glib-perl
		'Gtk2' => 0,			# gtk2-perl
		'Gtk2::Unique' => 0,		# perl-gtk2-unique
		'I18N::Langinfo' => 0,		# perl
		'POSIX' => 0,			# perl
		'XML::SAX::ParserFactory' => 0,	# perl-xml-sax
	},
	# basically strip the pod out of the .pm file and squeeze blank lines
	PM_FILTER => qq{(sed '/^=[^c]/,/^=cut/d'|cat -s)},
);

sub MY::postamble {
	return <<MAKE_FRAG;

.PHONY: install_desktop
install:: install_desktop

install_desktop:
	install -Dm0644 xdg-traymenu.desktop "\$(DESTDIR)/usr/share/applications/xdg-traymenu.desktop"
	install -Dm0644 xdg-traymenu.desktop "\$(DESTDIR)/etc/xdg/autostart/xdg-traymenu.desktop"

MAKE_FRAG
}
