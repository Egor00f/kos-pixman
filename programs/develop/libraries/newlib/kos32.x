/* Default linker script, for normal executables */
OUTPUT_FORMAT("kos32")
OUTPUT_ARCH("")
ENTRY(_start)
SECTIONS
{
    .text 0x000000:
    {
        LONG(0x554e454D);
        LONG(0x32305445);
        LONG(1);
        LONG(_start);
        LONG(___iend);
        LONG(___memsize);
        LONG(___stacktop);
        LONG(___cmdline);
        LONG(___pgmname);     /*  full path    */
        LONG(0);              /*FIXME tls data */
        *(.init)
        *(.text)
        *(SORT(.textkos32))
        *(.text.*)
        *(.glue_7t)
        *(.glue_7)
        ___CTOR_LIST__ = .; __CTOR_LIST__ = . ;
                        LONG (-1);*(.ctors); *(.ctor); *(SORT(.ctors.*));  LONG (0);
        ___DTOR_LIST__ = .; __DTOR_LIST__ = . ;
                        LONG (-1); *(.dtors); *(.dtor); *(SORT(.dtors.*));  LONG (0);
        *(.fini)
    /* ??? Why is .gcc_exc here?  */
        *(.gcc_exc)
        PROVIDE (etext = .);
        *(.gcc_except_table)
    }
    .rdata ALIGN(16) :
    {
        *(.rdata)
        *(SORT(.rdatakos32))
        ___RUNTIME_PSEUDO_RELOC_LIST__ = .;
        __RUNTIME_PSEUDO_RELOC_LIST__ = .;
        *(.rdata_runtime_pseudo_reloc)
        ___RUNTIME_PSEUDO_RELOC_LIST_END__ = .;
        __RUNTIME_PSEUDO_RELOC_LIST_END__ = .;
    }
    .CRT ALIGN(16) :
    {
         ___crt_xc_start__ = . ;
        *(SORT(.CRT*))  /* C initialization */
        ___crt_xc_end__ = . ;
        ___crt_xi_start__ = . ;
        *(SORT(.CRT*))  /* C++ initialization */
        ___crt_xi_end__ = . ;
        ___crt_xl_start__ = . ;
        *(SORT(.CRT*))  /* TLS callbacks */
    /* ___crt_xl_end__ is defined in the TLS Directory support code */
        ___crt_xp_start__ = . ;
        *(SORT(.CRT*))  /* Pre-termination */
        ___crt_xp_end__ = . ;
        ___crt_xt_start__ = . ;
        *(SORT(.CRT*))  /* Termination */
        ___crt_xt_end__ = . ;
    }
    .data ALIGN(16) :
    {
        __data_start__ = . ;
        *(.data)
        *(.data2)
        *(SORT(.datakos32))
        *(.jcr)
        __CRT_MT = .;
        LONG(0);
        __data_end__ = . ;
        *(.data_cygwin_nocopy)
    }
    .eh_frame ALIGN(16) :
    {
        *(.eh_frame)
        ___iend = . ;
    }
    bss ALIGN(16):
    {
        *(.bss)
        *(COMMON)
        . = ALIGN(16);
        ___cmdline = .;
        . = . + 256;
        ___pgmname = .;
        ___menuet__app_path_area = .;
        . = . + 1024 + 16;
        ___stacktop = .;
        ___memsize = . ;
    }
  /DISCARD/ :
  {
    *(.debug)
    *(.debug)
    *(.debug)
    *(.drectve)
    *(.note.GNU-stack)
    *(.comment)
    *(.debug_abbrev)
    *(.debug_info)
    *(.debug_line)
    *(.debug_frame)
    *(.debug_loc)
    *(.debug_pubnames)
    *(.debug_aranges)
    *(.debug_ranges)
  }
}

