package XDG::Menu::Tray::Jwm;
use base qw(XDG::Menu::Tray::Base);
use strict;
use warnings;

=head1 NAME

 XDG::Menu::Tray::Jwm - generate a JWM system tray menu from an XDG::Menu tree

=head1 SYNOPSIS

 my $parser = new XDG::Menu::Parser;
 my $tree = $parser->parse_menu('/etc/xdg/menus/applications.menu');
 my $tray = new XDG::Menu::Tray::Jwm;
 my $menu = $tray->create($tree);

=head1 DESCRIPTION

B<XDG::Menu::Tray::Jwm> is a module that reads an XDG::Menu::Layout
tree and generates a Gtk2 menu for JWM.

=head1 METHODS

B<XDG::Menu::Tray::Jwm> has the following methods:

=over

=item $tray->B<create_wmmenu>() => Gtk2::MenuItem

Creates the window manager specific Gtk2 menu and returns the menu as
a Gtk2::MenuItem object, to be included in a superior menu.

=back

=cut

sub create_wmmenu {
	my $self = shift;
}

1;

__END__

=head1 AUTHOR

Brian Bidulock <bidulock@cpan.org>

=head1 SEE ALSO

L<XDG::Menu(3pm)>,
L<XDG::Menu::Tray(3pm)>

=cut

# vim: set sw=4 tw=72 fo=tcqlorn foldmarker==head,=head foldmethod=marker:


