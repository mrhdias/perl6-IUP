use NativeCall;

# point NativeCall to correct library
# (may become obsolete in the future)
sub LIBIUP  {
	given $*VM{'config'}{'load_ext'} {
		when '.so'      { return 'libiup.so' }		# Linux
		when '.bundle'  { return 'libiup.dylib' }	# Mac OS
		default         { return 'libiup' }
	}
}

class IUP::IHandle is repr('CPointer') {

	sub IupDialog(IUP::IHandle)
		returns IUP::IHandle is native(LIBIUP) { ... };

	sub IupPopup(IUP::IHandle, int32, int32)
		returns int32 is native(LIBIUP) { ... };

	sub IupShow(IUP::IHandle)
		returns int32 is native(LIBIUP) { ... };

	sub IupShowXY(IUP::IHandle, int32, int32)
		returns int32 is native(LIBIUP) { ... };
	
	sub IupHide(IUP::IHandle)
		returns int32 is native(LIBIUP) { ... };
	
	sub IupLabel(Str)
		returns IUP::IHandle is native(LIBIUP) { ... };

	method label(Str $str) {
		return IupLabel($str);
	}

	method dialog() {
		return IupDialog(self);
	}

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
		return $wait ?? IupLoopStep() !! IupLoopStepWait();
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
