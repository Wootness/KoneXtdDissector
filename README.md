# KoneXtdDissector
Wireshark dissector for Roccat Kone XTD USB protocol

Dissector currently dissects the following message types*:
* Message Type 1: General mouse interrupts (moving,clicking,scrolling)
* Message Type 3: Statistics reports (Distance moved, Amount of clicks/scrolls)
* Message Type 6: Profile updates (colors changes, DPI settings etc)


*Message type is the first byte of the packets