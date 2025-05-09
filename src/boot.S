[bits 16]
[org 0x7c00]

start:
    cli
    xor ax, ax
    mov ds, ax

    ; 顯示啟動訊息
    mov si, startup_msg
    call print_message

    ; 記憶體檢查
    mov ah, 0x88        ; 記憶體大小查詢
    int 0x15
    jc memory_failed    ; 如果出錯則跳轉

    ; 顯示記憶體檢查成功訊息
    mov si, memory_ok
    call print_message
    jmp hang

memory_failed:
    mov si, memory_fail
    call print_message
    jmp hang

print_message:
    lodsb
    or al, al
    jz done
    mov ah, 0x0e        ; BIOS TTY 輸出
    int 0x10
    jmp print_message
done:
    ret

hang:
    cli
    hlt

startup_msg db 'BIOS Boot: Initialization Started.', 0
memory_ok db 'Memory Check Passed!', 0
memory_fail db 'Memory Check Failed!', 0

times 510-($-$$) db 0
dw 0xAA55

