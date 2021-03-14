# Kone XTD Dissector
Wireshark dissector for Roccat Kone XTD USB protocol

Dissector currently dissects the following message types*:
* Message Type 1: General mouse interrupts (moving,clicking,scrolling)
* Message Type 3: Uages reports (Distance moved statistics, Amount of clicks/scrolls statistics, Profile changes)
* Message Type 5: Set active profile
* Message Type 6: Profile settings updates (colors changes, DPI settings etc)
* Message Type 7: Profile buttons updates (Standard/Easy-Shift Button Assignment)

*Message type is the first byte of the packets

NOTE: This dissector is based entirely on my try of reverse engineering the traffic I could generate
with the mouse and driver's GUI, some fields/features might be inaccurate or just plain wrong.


## Usage
Place lua file in:

(new wireshark versions)
```
wireshark\plugins\*version number*\epan\
```
(Older wireshark versions)
```
wireshark\plugins\*version number*\
```
Use USBPcap to capture your Roccat Kone XTD's usb communication

NOTE: The dissector uses a very weak heuristic to identify possible Kone XTD packets (only checks packet lengths)
so it might accidently dissect other USB packets as well.
