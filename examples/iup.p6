#!/usr/bin/env perl6

use NativeCall;

BEGIN { @*INC.push('../lib') };

use IUP;

my $iup = IUP.new();

my @argv = ("Test");
$iup.open(@argv);

my $ih = IUP::Handle.new();

(
	(
		$ih.label("Hello, world!")
	).dialog()
).show();

$iup.main_loop();
$iup.close();

exit();
