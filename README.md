perl6-IUP
=========

![IUP Logo](logotype/logo_32x32.png)  
Perl 6 interface to the IUP toolkit for building GUI's.

Description
-----------
Perl 6 interface to the [IUP][2] toolkit. [IUP][2] is a multi-platform toolkit for
building graphical user interfaces. IUP's purpose is to allow a program
source code to be compiled in different systems without any modification.
Its main advantages are:

* it offers a simple API.
* high performance, due to the fact that it uses native interface elements.
* fast learning by the user, due to the simplicity of its API.

You will need the Linux `libiup` library installed in order to use perl6-IUP (version 3).
You can download the library binaries or sources for your platform from [here][5].

Synopsis
--------
WARNING: This module is Work in Progress, which means: this interface is
not final. This will perhaps change in the future.  
A sample of the code can be seen below.

<p align="center">
<img src="https://raw.github.com/mrhdias/perl6-IUP/master/examples/images/hello_world.png" alt="Hello World IUP Application"/>
</p>

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
		tip    => "Exit button");

	my $lbl = $ih.label("Hello, world!");

	my $vb = $ih.vbox($lbl, $btn);
	$vb.set_attribute(
		margin    => "10x10",
		gap       => "10",
		alignment => "ACENTER");

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

	sub exit_callback() returns Int {
		return IUP_CLOSE;
	}

Author
------
Henrique Dias <mrhdias@gmail.com>

See Also
--------
* [IUP Perl6 Module Documentation][1]
* [IUP Site][2]  
* [IUP Source Repository][3]
* [C examples from IUP source repository][4]

License
-------

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

[1]: lib/IUP.pod "IUP Perl6 Module Documentation"
[2]: http://www.tecgraf.puc-rio.br/iup/ "IUP - Portable User Interface"
[3]: http://iup.cvs.sourceforge.net/viewvc/iup/iup/ "IUP Source Repository"
[4]: http://iup.cvs.sourceforge.net/viewvc/iup/iup/test/ "C examples from IUP source repository"
[5]: http://sourceforge.net/projects/iup/files/3.7/ "IUP Downloads"
