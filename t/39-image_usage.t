use strict;
use warnings;
use Test::RequiresInternet 'test.wikipedia.org' => 80;
use Test::More tests => 5;

use MediaWiki::Bot;
my $t = __FILE__;

my $bot = MediaWiki::Bot->new({
    agent   => "MediaWiki::Bot tests (https://metacpan.org/MediaWiki::Bot; $t)",
    host    => 'test.wikipedia.org',
});

my $file = 'File:Wiki.png';

my @pages = $bot->image_usage($file, undef, undef, { max => 1 });

ok(     @pages,                                             'No error');
cmp_ok( scalar @pages,                  '>', 1,             'More than one result');
ok(     defined($pages[0]),                                 'Something was returned');
like(   $pages[0],                      qr/\w+/,            'The title looks valid');

$bot->image_usage($file, undef, 'nonredirects', { hook => \&mysub, max => 5 });
my $is_redir = 1;
sub mysub {
    my $res = shift;
    $is_redir = exists $res->[0]->{redirect};
}
isnt(     $is_redir,                                        'We got a normal link when we asked for no redirects');
