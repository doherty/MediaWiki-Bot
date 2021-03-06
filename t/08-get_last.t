use strict;
use warnings;
use Test::RequiresInternet 'test.wikipedia.org' => 80;
use Test::More tests => 2;

use MediaWiki::Bot;
my $t = __FILE__;

my $bot = MediaWiki::Bot->new({
    agent   => "MediaWiki::Bot tests (https://metacpan.org/MediaWiki::Bot; $t)",
    host    => 'test.wikipedia.org',
});

cmp_ok($bot->get_last('User:Mike.lifeguard/06-get history.t', 'Not a real editor'),
    '>', 0,     'Find the last revision');

is($bot->get_last('User:Mike.lifeguard/06-get history.t', 'Mike.lifeguard'),
    undef,      'There are no revisions not by Mike.lifeguard');
