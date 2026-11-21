%ifndef I80C186_ENHANC_PERIPHERALMAP_NASM_SENTRY
%define I80C186_ENHANC_PERIPHERALMAP_NASM_SENTRY

%define PERIPHERAL_DEFAULT_BASE_ADRS 0xFF00
%define PERIPHERAL_RELOC_REG_DEFAUT_VAL 0x20FF

struc IC186_SoC_Map
.Bottom resb 20h
    .PIC resb 3Eh-20h
.Rsrvd0 resb 50h-3Eh
    .Timer0 resb 58h-50h
    .Timer1 resb 60h-58h
    .Timer2 resb 66h-60h
.Rsrvd1 resb 0xA0-66h
    .ChipSel resb 3
.Rsrvd2  resb 0xC0-0xA3
    .DMA0    resb 0xCA-0xC0
.Rsrvd3  resb 0xD0-0xCA
    .DMA1    resb 0xDA-0xD0
.Rsrvd4  resb 0xE0-0xDA
    .Rfrsh   resb 4
.Rsrvd5  resb 0xF0-0xE4
    .PWRsaveREG resb 1
.Rsrvd6 resb 0xFE-0xF0
    .RelocReg resb 1
endstruc

struc RelocReg_Bitfield
    .Address resb 12
    .IsInRAM resb 1
    .Rsrvd resb 1
    .PICisSlave resb 1
    .TrapOnEsc resb 1
endstruc

struc ChipSel_Block
    .UpCS resb 2
    .LowCS resb 2
    .PortCS resb 2
    .MemCSBase resb 2
    .CSOther resb 2
endstruc
struc ChipSel_RdyBitsEnum
    .AtLeast0 resb 1
    .AtLeast1 resb 1
    .AtLeast2 resb 1
    .AtLeast3 resb 1
    .Insert0 resb 1
    .Insert1 resb 1
    .Insert2 resb 1
    .Insert3 resb 1
endstruc
%define CSRdyBits_AllowMask 7


struc UpCS_reg
    .WaitBitfield resb 3
    .Zeroed resb 3
    .FirstAdrs_17_10 resb 8
    .Zeroed2 resb 2
endstruc
%define UpCS_AllowMask 0b00_11111111_000_111

struc LowCS_Reg
    .WaitBitfield resb 3
    .Zeroed resb 3
    .LastAdrs_17_10 resb 8
    .Zeroed2 resb 2
endstruc
%define LowCS_AllowMask 0b00_11111111_000_111


struc PortCS_Reg
    .WaitBitfield resb 3
    .Zeroed resb 3
    .Adrs_19_10 resb 10
endstruc
%define PortCS_AllowMask 0b1111111111_000_111


struc MemCSBase_Reg
    .WaitBitfield resb 3
    .Zeroed resb 3
    .StrangeBits resb 3
    .Adrs_19_13 resb 7
endstruc
%define MemCSBase_AllowMask 0b1111111_000000_111

struc CSOther_Reg
    .PCS456_Waitfield resb 3
    .Zeroed resb 3
    .PCSIsMMIO resb 1
    .PCS56_IsNot_A12 resb 1
    .MCSis8k resb 1
    .MCSis16k resb 1
    .MCSis32k resb 1
    .MCSis64k resb 1
    .MCSis128k resb 1
    .MCSis256k resb 1
    .MCSis512k resb 1
    .ZeroBit resb 1
endstruc
%define CSOther_AllowMask 0b0_1111111_11_000_111

%define UpCS_ResetSize 1024
%define UpCS_ResetBase 0x1_0_0000 - UpCS_ResetSize


%endif