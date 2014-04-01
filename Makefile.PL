use ExtUtils::MakeMaker;
WriteMakefile(
	NAME => 'xdg-menu',
	VERSION => '0.01',
	LICENSE => 'perl',
	EXE_FILES => [
		'xdg-icon',
		'xdg-traymenu',
		'xdg-menugen',
	],
	PREREQ_PM => {
		'Getopt::Long' => 0,
	},
	# basically strip the pod out of the .pm file and squeeze blank lines
	PM_FILTER => qq{(sed '/^=[^c]/,/^=cut/d'|cat -s)},
);

sub MY::postamble {
	return <<MAKE_FRAG;

MAKE_FRAG
}
