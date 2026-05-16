# CH32 BLE OTA Web Updater - FAST244 Flow Control

## How to run

Do not open `index.html` directly with `file:///` for real BLE use.

1. Unzip this folder.
2. Double-click `start_local_server.cmd`.
3. Open Chrome / Edge:

```text
http://localhost:8080
```

## Default settings

- Default BLE scan: **All BLE** checked.
- Default transfer mode: **Fast**.
- Fast packet size: **244 bytes**.
- Firmware payload per packet: **240 bytes**.
- Fast packet delay: **0 ms**.
- Fast mode uses a **batch write queue + dynamic flow control**.

## Flow control logic

The page sends multiple `writeValueWithoutResponse()` operations in a burst, then adjusts the burst size dynamically:

- initial burst: 12 packets
- min burst: 2 packets
- max burst: 48 packets
- target speed: about 100 KB/s

If a burst write fails, the burst size is reduced and the same address is retried. If the browser/BLE stack cannot handle 244-byte packets, use Custom mode with 128 bytes.

## Recommended fallback settings

If Fast 244 is unstable:

- Custom packet size: 128
- Delay: 0 ~ 3 ms

If still unstable:

- Custom packet size: 64
- Delay: 3 ~ 8 ms

## Notes

Web Bluetooth cannot force MTU like Android `requestMtu()`. This version attempts to send 244-byte packets. Whether it reaches 100 KB/s depends on browser, OS Bluetooth stack, adapter, and device firmware.

## Timing display update

This version only adds timing display to the existing OTA progress UI:

- Total elapsed time is displayed before the total percentage.
- Each OTA step displays its elapsed time before the status mark.
- The transfer logic, packet format, flow control, BLE scan logic, and OTA commands are unchanged.

## Optional Skip Verify

A new checkbox is available in **3. OTA Parameters**:

- **Skip Verify Image (faster)**

When unchecked, the tool keeps the original behavior: it sends the VERIFY phase after PROGRAM and waits for the final verify response.

When checked, the tool skips the VERIFY phase and sends END directly after PROGRAM. This saves time, but the firmware is not byte-by-byte verified after writing. Use it only after the OTA path has already been tested as stable.

## UI update in this version

- Added the Designer-ZH logo to the top-left header.
- Added the same logo as the browser tab favicon.
- Added the credit line: Designed By Heng ZHANG (HKU).
- Compressed the left OTA Parameters panel:
  - Fast and Standard show fixed packet settings only.
  - Custom mode shows editable packet size and delay fields.
  - BIN start address is shown only for BIN files.
- Increased the firmware drop area height for easier drag-and-drop.
