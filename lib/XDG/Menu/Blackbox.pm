package XDG::Menu::Blackbox;
use strict;
use warnings;

=head1 NAME

 XDG::Menu::Blackbox - generate a Blackbox menu from an XDG::Menu tree.

=head1 SYNOPSIS

 my $parser = new XDG::Menu::Parser;
 my $tree = $parser->parse_uri('/etc/xdg/menus/applications.menu');
 my $blackbox = new XDG::Menu::Blackbox;
 print $blackbox->create($tree);

=head1 DESCRIPTION

B<XDG::Menu::Blackbox> is a module that reads an XDG::Menu::Layout tree
and generates a blackbox style menu.

=head1 METHODS

B<XDG::Menu::Blackbox> has the following methods:

=over

=item XDG::Menu::Blackbox->B<new>() => XDG::Menu::Blackbox

Creates a new XDG::Menu::Blackbox instance for creating blackbox menus.

=cut

sub new {
	return bless {}, shift;
}

=item $blackbox->B<create>($tree) => scalar

Creates the blackbox menu from menu tree, C<$tree>, and returns the menu
in a scalar string.  C<$tree> must have been created as the result of
parsing the XDG menu using XDG::Menu::Parser (see L<XDG::Menu(3pm)>).

=back

=cut

sub create {
	my ($self,$item) = @_;
	my $text = '';
	$text .= sprintf "%s\n", '[begin] (Blackbox)';
	$text .= $self->build($item,'  ');
	$text .= sprintf "%s\n", '  [exit] (Exit)';
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
	return sprintf "%s[nop] (%s)\n",
	       $indent, $item->Name;
}
sub Separator {
	my ($self,$item,$indent) = @_;
	return sprintf "%s[separator]\n",
	       $indent;
}
sub Application {
	my ($self,$item,$indent) = @_;
	return sprintf "%s[exec] (%s) {%s}\n",
	       $indent, $item->Name, $item->Exec;
}
sub Directory {
	my ($self,$item,$indent) = @_;
	my $text = '';
	$text .= sprintf "%s[submenu] (%s) {%s}\n",
		$indent, $item->Name, $item->Name." Menu";
	$text .= $self->build($item->{Menu},$indent.'  ');
	$text .= sprintf "%s[end]\n",
		$indent;
	return $text;
}

1;

=head1 SEE ALSO

L<XDG::Menu(3pm)>

=cut


