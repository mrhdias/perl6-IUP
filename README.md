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

    use IUP;

    my $iup = IUP.new();

    my @argv = ("Test");
    $iup.open(@argv);

    my $ih = IUP::IHandle.new();
    (
	    (
		    $ih.label("Hello, world!")
	    ).dialog()
    ).show();

    $iup.main_loop();
    $iup.close();

	exit();

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
