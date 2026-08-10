#![no_std]
#![no_main]

use core::panic::PanicInfo;

#[unsafe(no_mangle)]
pub extern "C" fn _start() -> ! {
    let video_memory = 0xb8000 as *mut u8;

    unsafe {
        *video_memory = b'L';
        *video_memory.add(1) = 0x0F;

        *video_memory.add(2) = b'I';
        *video_memory.add(3) = 0x0F;

        *video_memory.add(4) = b'N';
        *video_memory.add(5) = 0x0F;

        *video_memory.add(6) = b'O';
        *video_memory.add(7) = 0x0F;

        *video_memory.add(8) = b'S';
        *video_memory.add(9) = 0x0F;
    }

    loop {
        core::hint::spin_loop();
    }
}

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {
        core::hint::spin_loop();
    }
}
