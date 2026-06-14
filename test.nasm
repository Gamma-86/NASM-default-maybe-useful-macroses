bits 16
CPU 8086

shl   bx, 1
mov   bx, [bx + 1000]
jmp   ax    


%xdefine uint32_t dword

%define size_t uint32_t

%define avava size_t
%ifidni avava, size_t

%endif

