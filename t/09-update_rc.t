use strict;
use warnings;
use Test::RequiresInternet 'test.wikipedia.org' => 80;
use Test::More tests => 5;
use Test::Warn;

use MediaWiki::Bot;
my $t = __FILE__;

my $bot = MediaWiki::Bot->new({
    agent   => "MediaWiki::Bot tests (https://metacpan.org/MediaWiki::Bot; $t)",
    host    => 'test.wikipedia.org',
});

my $num = 2;
my @rc;
warning_is(
    sub { @rc = $bot->update_rc($num); },
    'update_rc is deprecated, and may be removed in a future release. Please use recentchanges(), which provides more data, including rcid',
    'update_rc is deprecated'
);

is(scalar(@rc), $num,                   'Right number of results returned');
isa_ok($rc[0], 'HASH',                  'Right kind of data structure');
ok(defined $rc[0]->{title},             'Has a title');
ok(defined $rc[0]->{timestamp},         'Has a timestamp');
