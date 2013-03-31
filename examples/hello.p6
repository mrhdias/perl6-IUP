#!/usr/bin/env perl6

BEGIN { @*INC.push('../lib') };

use IUP;

my $iup = IUP.new();

my @argv = ("Test");

#
# initialize iup
#
$iup.open(@argv);

my $ih = IUP::Handle.new();

#
# create widgets and set their attributes
#
my $btn = $ih.button("&Ok", "");
$btn.set_callback("ACTION", &exit_callback);

$btn.set_attribute(
	expand => "YES",
	tip    => "Exit button"
);

#$btn.set_attribute("EXPAND", "YES");
#$btn.set_attribute("TIP", "Exit button");

my $lbl = $ih.label("Hello, world!");

my $vb = $ih.vbox($lbl, $btn);
$vb.set_attribute(
	margin    => "10x10",
	gap       => "10",
	alignment => "ACENTER"
);

#
# Another alternative to set the attributes.
#
#$vb.set_attribute("MARGIN", "10x10");
#$vb.set_attribute("GAP", "10");
#$vb.set_attribute("ALIGNMENT", "ACENTER");

my $dlg = $vb.dialog();
$dlg.set_attribute("TITLE", "Hello");

#
# Map widgets and show dialog
#
$dlg.show();

#
# Wait for user interaction
#
$iup.main_loop();

#
# Clean up
#
$dlg.destroy();

$iup.close();

exit();

sub exit_callback() {
	return IUP_CLOSE;
}
