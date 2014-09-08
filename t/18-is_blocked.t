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

# Jimbo is almost certainly not blocked right now
ok(!$bot->is_blocked('Jimbo Wales'), 'current blocks');

# A random old account I chose - it will probably be blocked forever
# (del/undel) 21:48, July 26, 2008 Cometstyles (talk | contribs | block) blocked Hiwhispees (talk | contribs) with an expiry time of infinite (account creation disabled, e-mail blocked) ‎ (bye grawp) (unblock | change block)
ok($bot->is_blocked('User:Hiwhispees'), 'current blocks');
