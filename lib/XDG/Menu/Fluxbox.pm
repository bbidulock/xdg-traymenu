package XDG::Menu::Fluxbox;
use strict;
use warnings;

=head1 NAME

 XDG::Menu::Fluxbox - generate a Fluxbox menu from an XDG::Menu tree.

=head1 SYNOPSIS

 my $parser = new XDG::Menu::Parser;
 my $tree = $parser->parse_uri('/etc/xdg/menus/applications.menu');
 my $fluxbox = new XDG::Menu::Fluxbox;
 print $fluxbox->create($tree);

=head1 DESCRIPTION

B<XDG::Menu::Fluxbox> is a module that reads an XDG::Menu::Layout tree
and generates a fluxbox style menu.

=head1 METHODS

B<XDG::Menu::Fluxbox> has the folllowing methods:

=over

=item XDG::Menu::Fluxbox->B<new>($tree) => XDG::Menu::Fluxbox

Creates a new XDG::Menu::Fluxbox instance for creating fluxbox menus.

=cut

sub new {
	return bless {}, shift;
}

=item $fluxbox->B<create>($tree) => scalar

Creates the fluxbox menu from menu tree, C<$tree>, and returns the menu
in a scalar string.  C<$tree> must have been created as the result of
parsing the XDG menu using XDG::Menu::Parser (see L<XDG::Menu(3pm)>).

=back

=cut

sub create {
	my ($self,$item) = @_;
	my $text = '';
	$text .= sprintf "%s\n", '[begin] (Fluxbox)';
	$text .= sprintf "%s\n", '[encoding] {UTF-8}';
	$text .= $self->build($item,'  ');
	$text .= sprintf "%s\n", '  [exit] (Exit)';
	$text .= sprintf "%s\n", '[endencoding]';
	$text .= sprintf "%s\n", '[end]';
	return $text;
}
sub build {
	my ($self,$item,$indent) = @_;
	my $name = ref($item);
	$name =~ s{.*\:\:}{};
	return $self->$name($item,$indent) if $self->can($name);
	return '';
}
sub Menu {
	my ($self,$item,$indent) = @_;
	my $text = '';
	if ($item->{Elements}) {
		foreach (@{$item->{Elements}}) {
			next unless $_;
			$text .= $self->build($_,$indent.'  ');
		}
	}
	return $text;
}
sub Header {
	my ($self,$item,$indent) = @_;
	return sprintf "%s[nop] (%s) <%s>\n",
	       $indent, $item->Name, $item->Icon([qw(png xpm)]);
}
sub Separator {
	my ($self,$item,$indent) = @_;
	return sprintf "%s[separator]\n",
	       $indent;
}
sub Application {
	my ($self,$item,$indent) = @_;
	return sprintf "%s[exec] (%s) {%s} <%s>\n",
	       $indent, $item->Name, $item->Exec, $item->Icon([qw(png xpm)]);
}
sub Directory {
	my ($self,$item,$indent) = @_;
	my $text = '';
	$text .= sprintf "%s[submenu] (%s) {%s} <%s>\n",
		$indent, $item->Name, $item->Name." Menu",
		$item->Icon([qw(png xpm)]);
	$text .= $self->build($item->{Menu},$indent.'  ');
	$text .= sprintf "%s[end]\n",
		$indent;
	return $text;
}

1;

=head1 SEE ALSO

L<XDG::Menu(3pm)>

=cut


