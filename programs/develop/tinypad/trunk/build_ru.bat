@erase lang.inc
@echo lang fix ru >lang.inc
@fasm tinypad.asm tinypad.bin
@erase lang.inc
@pause