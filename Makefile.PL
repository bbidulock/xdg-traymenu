use ExtUtils::MakeMaker;
WriteMakefile(
	NAME => 'xdg-menu',
	VERSION => '0.01',
	EXE_FILES => [
		'xdg-icon',
		'xdg-traymenu',
		'xdg-menugen',
	],
	PREREQ_PM => {
		'Getopt::Long' => 0,
	},
);
