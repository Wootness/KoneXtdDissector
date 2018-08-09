# KoneXtdDissector
Wireshark dissector for Roccat Kone XTD USB protocol

Dissector currently dissects the following message types*:
* Message Type 1: General mouse interrupts (moving,clicking,scrolling)
* Message Type 3: Statistics reports (Distance moved, Amount of clicks/scrolls)
* Message Type 6: Profile updates (colors changes, DPI settings etc)

*Message type is the first byte of the packets

## Usage
Place lua file in:

(new wireshark versions)

\*wireshark dir\*\\plugins\\\*version number\*\epan\

(Older wireshark versions)

\*wireshark dir\*\\plugins\\\*version number\*\

Use USBPcap to capture your Roccat Kone XTD's usb communication

NOTE: The dissector uses a very weak heuristic to identify possible Kone XTD packets (only checks packet lengths)
so it might accidently dissect other USB packets as well.
