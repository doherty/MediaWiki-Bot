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

ok( $bot->was_blocked('Bad Username'),   'block history - has been blocked');
ok(!$bot->was_blocked('Mike.lifeguard'), 'block history - never blocked'   );
