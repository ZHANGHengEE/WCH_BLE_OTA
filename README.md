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


## v1.1 branding and logging updates

- Added Designer-Z.H logo as the browser tab favicon and top-left web logo.
- Header subtitle now includes: Designed By Heng ZHANG (HKU).
- Added an optional checkbox: Log every PROGRAM / VERIFY packet. It is disabled by default to avoid slowing OTA transfer.
