package Dancer2::Plugin::Paginator;
{
  $Dancer2::Plugin::Paginator::VERSION = '1.000000';
}

use strict;
use warnings;

use Dancer2 ':syntax';
use Dancer2::Plugin;

use Paginator::Lite;

register paginator => sub {
    my ( $dsl, %params ) = plugin_args(@_);

    my $conf = plugin_setting;
    $conf->{frame_size} ||= 5;
    $conf->{page_size}  ||= 10;
    
    return Paginator::Lite->new( %{$conf}, %params );
};

register_plugin for_versions => [2];

1;

# ABSTRACT: Dancer2 plugin for Paginator::Lite

__END__

=pod

=head1 NAME

Dancer2::Plugin::Paginator - Dancer2 plugin for Paginator::Lite

=head1 VERSION

version 1.000000

=head1 SYNOPSIS

    use Dancer2;
    use Dancer2::Plugin::Paginator;
    
    get '/list' => sub {
        my $paginator = paginator(
            'curr'     => $page,
            'items'    => rset('Post')->count,
            'base_url' => '/posts/page/',
        );
        
        template 'list', { paginator => $paginator };
    };
    
    dance;

=head1 FUNCTIONS

=head2 paginator %params

This keyword returns a Paginator::Lite object. Receives same parameters that
the L<Paginator::Lite> constructor.

=head1 CONFIGURATION

Configuration can be done in your L<Dancer2> config file as described below:

    plugins:
        Paginator:
            frame_size: 3
            page_size: 7

=head1 SEE ALSO

=over 4

=item L<Paginator::Lite>

=back

=head1 AUTHOR

Blabos de Blebe <blabos@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Blabos de Blebe.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
