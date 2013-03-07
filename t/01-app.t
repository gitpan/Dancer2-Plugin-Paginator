#!perl

use strict;
use warnings;

use Test::More tests => 3;

use Dancer2 qw(:syntax :tests);
use Dancer2::Plugin::Paginator;

use t::lib::App;
use Dancer2::Test apps => ['t::lib::App'];

use JSON ();

my ( $res, $expected, $got );

$expected = {
    'next'       => 5,
    'first'      => 1,
    'prev'       => 4,
    'curr'       => 5,
    'base_url'   => '/foo/bar/etc',
    'last'       => 5,
    'frame_size' => 5,
    'end'        => 5,
    'page_size'  => 10,
    'begin'      => 3,
    'items'      => 42
};
my $paginator = paginator(
    curr     => 7,
    items    => 42,
    base_url => '/foo/bar/etc',
);
is_deeply( $paginator, $expected, 'Testing default data' );

$expected = {
    'next'       => 6,
    'first'      => 1,
    'prev'       => 4,
    'curr'       => 5,
    'base_url'   => '/foo/bar',
    'last'       => 10,
    'frame_size' => 5,
    'end'        => 7,
    'page_size'  => 10,
    'begin'      => 3,
    'items'      => 100
};
$res = dancer_response [ GET => '/config' ];
$got = JSON::from_json( $res->content );
is_deeply( $got, $expected, 'Testing config data' );

$expected = {
    'next'       => 6,
    'first'      => 1,
    'prev'       => 4,
    'curr'       => 5,
    'base_url'   => '/foo/bar',
    'last'       => 15,
    'frame_size' => 3,
    'end'        => 6,
    'page_size'  => 7,
    'begin'      => 4,
    'items'      => 100
};
$res = dancer_response [ GET => '/custom' ];
$got = JSON::from_json( $res->content );
is_deeply( $got, $expected, 'Testing custom data' );

