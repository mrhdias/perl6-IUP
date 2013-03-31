use NativeCall;

sub libname($lib) {
	given $*VM{'config'}{'load_ext'} {
		when '.so' { return "$lib.so" }         # Linux
		when '.bundle' { return "$lib.dylib" }  # Mac OS
		default { return $lib }
	}
};

sub find_lib($libname) {
	my $path = $libname;
	for @*INC -> $libdir {
		if "$libdir/$libname".IO ~~ :e {
			$path = "$libdir/$libname";
			last;
		}
	}
	return $path;
}

sub LIBIUP() { return libname("libiup"); }
sub LOCAL_LIB() { return find_lib(libname("IUP")); }

#
# Callback Return Values
#
constant IUP_IGNORE		= -1;
constant IUP_DEFAULT	= -2;
constant IUP_CLOSE		= -3;
constant IUP_CONTINUE	= -4;

class IUP::Callback is repr('CPointer') {}

class IUP::Handle is repr('CPointer') {
	
	sub IupTakeACallback(&cb())
		returns IUP::Callback is native(LOCAL_LIB) { ... };

	sub IupDestroy(IUP::Handle)
		is native(LIBIUP) { ... };

	###

	sub IupPopup(IUP::Handle, int32, int32)
		returns int32 is native(LIBIUP) { ... };

	sub IupShow(IUP::Handle)
		returns int32 is native(LIBIUP) { ... };

	sub IupShowXY(IUP::Handle, int32, int32)
		returns int32 is native(LIBIUP) { ... };
	
	sub IupHide(IUP::Handle)
		returns int32 is native(LIBIUP) { ... };

	###

	sub IupSetAttribute(IUP::Handle, Str, Str)
		is native(LIBIUP) { ... };

	###

	sub IupSetCallback(IUP::Handle, Str, IUP::Callback)
		returns IUP::Callback is native(LIBIUP) { ... };

	###

	sub IupVboxv(CArray[OpaquePointer])
		returns IUP::Handle is native(LIBIUP) { ... };

	###

	sub IupButton(Str, Str)
		returns IUP::Handle is native(LIBIUP) { ... };

	sub IupDialog(IUP::Handle)
		returns IUP::Handle is native(LIBIUP) { ... };
	
	sub IupLabel(Str)
		returns IUP::Handle is native(LIBIUP) { ... };

	### METHODS ###

	method destroy() {
		IupDestroy(self);
	}

	###

	method popup(Int $x, Int $y) {
		return IupPopup(self, $x, $y);
	}

	multi method show() {
		return IupShow(self);
	}

	multi method show(Int $x, Int $y) {
		return IupShowXY(self, $x, $y);
	}

	method hide() {
		return IupHide(self);
	}

	###

	multi method set_attribute(Str $name, Str $value) {
		IupSetAttribute(self, uc($name), $value);
	}

	multi method set_attribute(*%attributes) {
		for %attributes.kv -> $name, $value {			
			IupSetAttribute(self, uc($name), $value);
		}
	}

	###

	method set_callback(Str $name, $function) {
		return IupSetCallback(self, uc($name), IupTakeACallback($function));
	}

	###

	method vboxv(*@child) {
		my @array_child := CArray[OpaquePointer].new();
		my $i = 0;
		for @child -> $c {
			@array_child[$i] = $c;
			$i++;
		}
		return IupVboxv(@array_child);
	}

	method vbox(*@child) {
		return self.vboxv(@child);
	}

	###

	method button(Str $title, Str $action) {
		return IupButton($title, $action);
	}

	method dialog() {
		return IupDialog(self);
	}

	method label(Str $str) {
		return IupLabel($str);
	}
}

class IUP {

	sub IupOpen(CArray[int32], CArray[CArray[Str]])
		returns int32 is native(LIBIUP) { ... };

	sub IupClose()
		is native(LIBIUP) { ... };

	sub IupImageLibOpen()
		is native(LIBIUP) { ... };

	sub IupMainLoop()
		returns int32 is native(LIBIUP) { ... };

	sub IupLoopStep()
		returns int32 is native(LIBIUP) { ... };

	sub IupLoopStepWait()
		returns int32 is native(LIBIUP) { ... };

	sub IupMainLoopLevel()
		returns int32 is native(LIBIUP) { ... };

	sub IupFlush()
		is native(LIBIUP) { ... };

	sub IupExitLoop()
		is native(LIBIUP) { ... };

	### METHODS ###

	method open(@argv) {
		my @argcounter := CArray[int32].new();
		@argcounter[0] = @argv.elems;

		my @argvptr := CArray[CArray[Str]].new();
		my @argvector := CArray[Str].new();

		for @argv -> $a {
			@argvector[0] = $a;
		}
		@argvptr[0] = @argvector;

		return IupOpen(@argcounter, @argvptr);
	}

	method close() {
		IupClose();
	}

	method image_lib_open() {
		IupImageLibOpen();
	}

	method main_loop() {
		return IupMainLoop();
	}

	method loop_step(Bool $wait = False) {
		return $wait ?? IupLoopStepWait() !! IupLoopStep();
	}
	
	method main_loop_level() {
		return IupMainLoopLevel();
	}
	
	method flush() {
		IupFlush();
	}

	method exit_loop() {
		IupExitLoop();
	}
}
