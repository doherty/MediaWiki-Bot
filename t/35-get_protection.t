use strict;
use warnings;
use Test::RequiresInternet 'test.wikipedia.org' => 80;
use Test::More 0.96 tests => 2;

use MediaWiki::Bot;
my $t = __FILE__;

my $bot = MediaWiki::Bot->new({
    agent   => "MediaWiki::Bot tests (https://metacpan.org/MediaWiki::Bot; $t)",
    host    => 'test.wikipedia.org',
});

subtest protected => sub {
    plan tests => 3;

    my @pages = ('Main Page', 'SyntaxHighlight GeSHi');
    my $result = $bot->get_protection(\@pages);

    isa_ok($result,                         'HASH',     'Return value of get_protection()');
    isa_ok($result->{'Main Page'},          'ARRAY',    '[[Main Page]] protection');
    is($result->{'SyntaxHighlight GeSHi'},  undef,      '[[SyntaxHighlight GeSHi]] protection');
};

subtest unprotected => sub {
    plan tests => 1;
    # [[User talk:Mike.lifeguard]] is probably not protected
    my $result = $bot->get_protection('User talk:Mike.lifeguard');
    is($result,             undef,      '[[User talk:Mike.lifeguard]] protection');
};
