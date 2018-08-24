local bool_vals = {
        [0] = "False",
        [1] = "True",
}
local sensativity_vals = {
        [1]  = "-5",
        [2]  = "-4",
        [3]  = "-3",
        [4]  = "-2",
        [5]  = "-1",
        [6]  = "0",
        [7]  = "1",
        [8]  = "2",
        [9]  = "3",
        [10] = "4",
        [11] = "5",
}

local pool_rate_vals = {
        [0]  = "125 Hz",
        [1]  = "250 Hz",
        [2]  = "500 Hz",
        [3]  = "1000 Hz",
}

local light_effect_vals = {
        [0]  = "All lights off",
        [1]  = "Fully lighted",
        [2]  = "Blinking",
        [3]  = "Breathing",
        [4]  = "Heartbeat",
}

local color_flow_vlas = {
        [0]  = "No color flow (Off)",
        [1]  = "All lights simultaneously",
        [2]  = "Flow direction - Up",
        [3]  = "Flow direction - Down",
        [4]  = "Flow direction - Left",
        [5]  = "Flow direction - Right",
}

local effect_speed_vals = {
        [1]  = "Slow",
        [2]  = "Normal",
        [3]  = "Fast",
}

local key_id_vals = {
        [1]  = "Left Button",
        [2]  = "Right Button",
        [3]  = "Middle Button",
        [4]  = "Mouse 4 (Forward)",
        [5]  = "Mouse 5 (Backward)",
        [6]  = "Mouse Wheel Left",
        [7]  = "Mouse Wheel Right",
        [8]  = "Scroll Up",
        [9]  = "Scroll Down",
       [10]  = "Plus Button",
       [11]  = "Minus Button",
       [12]  = "Mouse 12 (Menu)",
}


local roccat_kone_xtd = Proto("konextd","Roccat Kone XTD USB Protocol")


local message_type = ProtoField.new("Message Type", "konextd.msgtype", ftypes.UINT8)
local unused_byte = ProtoField.new("Unused Byte", "konextd.unused", ftypes.UINT8)
local msg_3_submessage_type = ProtoField.new("Sub Message Type", "konextd.submsgtype", ftypes.UINT8)
local profile = ProtoField.new("Profile Index", "konextd.profile", ftypes.UINT8)

-- AlienFX
local alienfxdisabled = ProtoField.new("AlienFX Disabled", "konextd.fxdisabled", ftypes.BOOLEAN)
local alienfxenabled = ProtoField.new("AlienFX Enabled", "konextd.fenabled", ftypes.BOOLEAN)

local pollrate = ProtoField.new("Polling Rate", "konextd.pollrate", ftypes.UINT8, pool_rate_vals)

-- Mouse sensitivity
local advsense = ProtoField.new("Advanced Sensitivity Enabled", "konextd.advsense", ftypes.BOOLEAN)
local xsense = ProtoField.new("X Axis Sensitivity", "konextd.xsense", ftypes.UINT8, sensativity_vals, base.DEC)
local ysense = ProtoField.new("Y Axis Sensitivity", "konextd.ysense", ftypes.UINT8, sensativity_vals, base.DEC)

-- LEDs settings
local led1on = ProtoField.new("Led 1 (Top Left) On", "konextd.led1on", ftypes.UINT8, bool_vals, base.DEC, 0x01)
local led2on = ProtoField.new("Led 2 (Bottom Left) On", "konextd.led2on", ftypes.UINT8, bool_vals, base.DEC, 0x02)
local led3on = ProtoField.new("Led 3 (Top Right) On", "konextd.led3on", ftypes.UINT8, bool_vals, base.DEC, 0x04)
local led4on = ProtoField.new("Led 4 (Bottom Right) On", "konextd.led4on", ftypes.UINT8, bool_vals, base.DEC, 0x08)

-- DPI settings
local dpi1on = ProtoField.new("DPI Setting 1 On", "konextd.led1on", ftypes.UINT8, bool_vals, base.DEC, 0x01)
local dpi2on = ProtoField.new("DPI Setting 2 On", "konextd.dpi2on", ftypes.UINT8, bool_vals, base.DEC, 0x02)
local dpi3on = ProtoField.new("DPI Setting 3 On", "konextd.dpi3on", ftypes.UINT8, bool_vals, base.DEC, 0x04)
local dpi4on = ProtoField.new("DPI Setting 4 On", "konextd.dpi4on", ftypes.UINT8, bool_vals, base.DEC, 0x08)
local dpi5on = ProtoField.new("DPI Setting 5 On", "konextd.dpi5on", ftypes.UINT8, bool_vals, base.DEC, 0x10)

-- Colors effects
local colorfloweffect = ProtoField.new("Color Flow Effect", "konextd.colorflow", ftypes.UINT8, color_flow_vlas)
local lighteffect = ProtoField.new("Light Effect", "konextd.lighteffect", ftypes.UINT8, light_effect_vals)
local effectspeed = ProtoField.new("Effect Speed", "konextd.effectspeed", ftypes.UINT8, effect_speed_vals)

-- Colors
local ledcolor = ProtoField.new("Led # Color", "konextd.ledcolor", ftypes.NONE)
local colorindex = ProtoField.new("Color Index", "konextd.colorindx", ftypes.UINT8, nil, base.DEC, 0, "Index of the color in the driver's GUI")
local colorred = ProtoField.new("Red", "konextd.red", ftypes.UINT8)
local colorgreen = ProtoField.new("Green", "konextd.green", ftypes.UINT8)
local colorblue = ProtoField.new("Blue", "konextd.blue", ftypes.UINT8)

-- Key Assignment
local standardkeys = ProtoField.new("Standard Button Assignments", "konextd.standardkeys", ftypes.NONE)
local easyshiftkeys = ProtoField.new("Easy-Shift[+] Button Assignments", "konextd.easyshiftkeys", ftypes.NONE)
local keyid = ProtoField.new("Key # ", "konextd.key.id", ftypes.NONE)
local keyvassignment = ProtoField.new("Key Assignment", "konextd.key.assignment", ftypes.UINT8) -- TODO values
local keyshortcutmodifiers = ProtoField.new("Shortcut Modifiers", "konextd.key.shortcut.modifiers", ftypes.UINT8) -- TODO dissect bits
local keyshortcutbutton = ProtoField.new("Shortcut Button", "konextd.key.shortcut.button", ftypes.UINT8) -- TODO values

-- Statistics
local distance = ProtoField.new("Distance", "konextd.distance", ftypes.UINT8)
local clicks = ProtoField.new("Clicks", "konextd.clicks", ftypes.UINT8)
local scrolls = ProtoField.new("Scrolls", "konextd.scrolls", ftypes.UINT8)

-- Movement
local right_left = ProtoField.new("Right/Left", "konextd.rl", ftypes.INT16)
local down_up = ProtoField.new("Down/Up", "konextd.du", ftypes.INT16)
local up_down_scroll = ProtoField.new("Scroll Up/Down", "konextd.udscroll", ftypes.INT8)

-- Button presses
local lbutton   = ProtoField.new("Left Button Pressed", "konextd.rbutton", ftypes.UINT8, bool_vals, base.DEC, 0x01)
local rbutton   = ProtoField.new("Right Button Pressed", "konextd.lbutton", ftypes.UINT8, bool_vals, base.DEC, 0x02)
local midbutton = ProtoField.new("Middle Button Pressed", "konextd.midbutton", ftypes.UINT8, bool_vals, base.DEC, 0x04)
local m5button  = ProtoField.new("Mouse 5 (Back) Button Pressed", "konextd.m5button", ftypes.UINT8, bool_vals, base.DEC, 0x08)
local m4button  = ProtoField.new("Mouse 4 (Fwd) Button Pressed", "konextd.m4button", ftypes.UINT8, bool_vals, base.DEC, 0x10)

-- Checksum
local checksum = ProtoField.new("Checksum", "konextd.checksum", ftypes.UINT16, nil, base.HEX)

roccat_kone_xtd.fields = { data,
    message_type,
    unused_byte,
    msg_3_submessage_type,
    distance,
    clicks,
    scrolls,
    right_left,
    down_up,
    up_down_scroll,
    rbutton,
    lbutton,
    midbutton,
    m5button,
    m4button,
    profile,
    dpi1on,
    dpi2on,
    dpi3on,
    dpi4on,
    dpi5on,
    alienfxdisabled,
    alienfxenabled,
    pollrate,
    advsense,
    xsense,
    ysense,
    colorfloweffect,
    lighteffect,
    effectspeed,
    ledcolor,
    colorindex,
    colorred,
    colorgreen,
    colorblue,
    led1on,
    led2on,
    led3on,
    led4on,
    standardkeys,
    easyshiftkeys,
    keyid,
    keyvassignment,
    keyshortcutmodifiers,
    keyshortcutbutton,
    checksum
}

local data_dis = Dissector.get( "data" )

local function dissect_scrolling_byte(tvbuf,pktinfo,tree,offset)
    ti = tree:add_le(up_down_scroll, tvbuf:range(offset,1))
    value = tvbuf:range(offset,1):int()
    if value > 0 then
        ti:append_text(" (Up)")
        pktinfo.cols.info:append("Scrolling Up")
    elseif value < 0 then
        ti:append_text(" (Down)")
        pktinfo.cols.info:append("Scrolling Down")
    else
        ti:append_text(" (No scrolling)")
        pktinfo.cols.info:append("Not Scrolling")
    end
end

local function dissect_led_color(tvbuf,pktinfo,tree,offest,led_num)
    ti = tree:add(ledcolor,tvbuf:range(offset,4))
    ti:add_le(colorindex, tvbuf:range(offset,1))
    offset = offset + 1
    
    red = tvbuf:range(offset,1):uint()
    ti:add_le(colorred, tvbuf:range(offset,1))
    offset = offset + 1
    
    green = tvbuf:range(offset,1):uint()
    ti:add_le(colorgreen, tvbuf:range(offset,1))
    offset = offset + 1
    
    blue = tvbuf:range(offset,1):uint()
    ti:add_le(colorblue, tvbuf:range(offset,1))
    offset = offset + 1
    
    ti:set_text("Led " .. led_num .. " Color (" .. red .."," .. green .."," .. blue ..")")
    return offset;
end

local function dissect_key_assignment(tvbuf,pktinfo,tree,offest,key_num)
    ti = tree:add(keyid,tvbuf:range(offset,3))
    ti:set_text("Key " .. key_num .. " (" .. key_id_vals[key_num] ..")")

    ti:add_le(keyvassignment, tvbuf:range(offset,1))
    offset = offset + 1

    ti:add_le(keyshortcutmodifiers, tvbuf:range(offset,1))
    offset = offset + 1

    ti:add_le(keyshortcutbutton, tvbuf:range(offset,1))
    offset = offset + 1

    return offset;
end

local function sum_bytes(pktinfo,tvb)
    len = tvb:len()
    total = 0
    for i=0,(len-3) do
        total = total+ tvb:range(i,1):uint()
    end
    return total
end

local function dissect_konextd_msg_1(tvbuf,pktinfo,tree)
    pktinfo.cols.info:set("Kone XTD interrupt: ")
    offset = 1;

    tree:add_le(m4button, tvbuf:range(offset,1))
    tree:add_le(m5button, tvbuf:range(offset,1))
    tree:add_le(midbutton, tvbuf:range(offset,1))
    tree:add_le(rbutton, tvbuf:range(offset,1))
    tree:add_le(lbutton, tvbuf:range(offset,1))
    offset = offset + 1;

    info_added = false
    ti = tree:add_le(right_left, tvbuf:range(offset,2))
    value = tvbuf:range(offset,2):int()
    if value > 0 then
        ti:append_text(" (Right)")
        pktinfo.cols.info:append("Moving Right")
        info_added = true
    elseif value < 0 then
        ti:append_text(" (Left)")
        pktinfo.cols.info:append("Moving Left")
        info_added = true
    else
        ti:append_text(" (No movement)")
    end
    offset = offset + 2;

    ti = tree:add_le(down_up, tvbuf:range(offset,2))
    value = tvbuf:range(offset,2):int()
    if value > 0 then
        ti:append_text(" (Down)")
        if info_added then
            pktinfo.cols.info:append(", ")
        end
        pktinfo.cols.info:append("Moving Down")
        info_added = true
    elseif value < 0 then
        ti:append_text(" (Up)")
        if info_added then
            pktinfo.cols.info:append(", ")
        end
        pktinfo.cols.info:append("Moving Up")
        info_added = true
    else
        ti:append_text(" (No movement)")
    end
    offset = offset + 2;
    
    if info_added then
        pktinfo.cols.info:append(", ")
    else
        pktinfo.cols.info:append("Not Moving, ")
    end

    dissect_scrolling_byte(tvbuf,pktinfo,tree,offset)
    
    return pktlen;
end

local function dissect_konextd_msg_3(tvbuf,pktinfo,tree)
    pktinfo.cols.info:set("Kone XTD Statistics report ")
    offset = 1;
    tree:add_le(unused_byte, tvbuf:range(offset,1))
    offset = offset + 1;

    ti = tree:add_le(msg_3_submessage_type, tvbuf:range(offset,1))
    value = tvbuf:range(offset,1):uint()
    offset = offset + 1;

    if value == 0xea then
        -- Movement statistics
        ti:append_text(" (Movement statistics)")
        value = tvbuf:range(offset,1):int()
        ti = tree:add_le(distance,tvbuf:range(offset,1))
        if value == 0x0a then
            ti:append_text(" (Mouse moved another 0.25 m)")
        else
            ti:append_text(" (Unknown value)")
        end
    elseif value == 0xe1 then
        ti:append_text(" (Right clicks statistics)")
        value = tvbuf:range(offset,1):int()
        ti = tree:add_le(clicks,tvbuf:range(offset,1))
        ti:append_text(" (Button clicked another " .. value .. " times)")
    elseif value == 0xe2 then
        ti:append_text(" (Left clicks statistics)")
        value = tvbuf:range(offset,1):int()
        ti = tree:add_le(clicks,tvbuf:range(offset,1))
        ti:append_text(" (Button clicked another " .. value .. " times)")
    elseif value == 0xe3 then
        ti:append_text(" (Middle clicks statistics)")
        value = tvbuf:range(offset,1):int()
        ti = tree:add_le(clicks,tvbuf:range(offset,1))
        ti:append_text(" (Button clicked another " .. value .. " times)")
    elseif value == 0xe4 then
        ti:append_text(" (Mouse 4 clicks statistics)")
        value = tvbuf:range(offset,1):int()
        ti = tree:add_le(clicks,tvbuf:range(offset,1))
        ti:append_text(" (Button clicked another " .. value .. " times)")
    elseif value == 0xe5 then
        ti:append_text(" (Mouse 5 clicks statistics)")
        value = tvbuf:range(offset,1):int()
        ti = tree:add_le(clicks,tvbuf:range(offset,1))
        ti:append_text(" (Button clicked another " .. value .. " times)")
    elseif value == 0xe6 then
        ti:append_text(" (Up scrolling statistics)")
        value = tvbuf:range(offset,1):int()
        ti = tree:add_le(scrolls,tvbuf:range(offset,1))
        ti:append_text(" (Scrolled another " .. value .. " times)")
        dissect_scrolling_byte(tvbuf,pktinfo,tree,offset + 3)
    elseif value == 0xe7 then
        ti:append_text(" (Down scrolling statistics)")
        value = tvbuf:range(offset,1):int()
        ti = tree:add_le(scrolls,tvbuf:range(offset,1))
        ti:append_text(" (Scrolled another " .. value .. " times)")
        dissect_scrolling_byte(tvbuf,pktinfo,tree,offset + 3)
    end
end

local function dissect_konextd_msg_5(tvbuf,pktinfo,tree)
    offset = 2
    value = tvbuf:range(offset,1):uint() + 1
    ti = tree:add_le(profile, tvbuf:range(offset,1))
    ti:append_text(" (Profile " .. (value) .. ")")
    pktinfo.cols.info:set("Kone XTD Change to Profile " .. value)
end


local function dissect_konextd_msg_6(tvbuf,pktinfo,tree)
    offset = 2
    value = tvbuf:range(offset,1):uint() + 1
    ti = tree:add_le(profile, tvbuf:range(offset,1))
    ti:append_text(" (Profile " .. (value) .. ")")
    pktinfo.cols.info:set("Updating Kone XTD Profile " .. value .. " settings")
    offset = offset + 1

    tree:add_le(advsense, tvbuf:range(offset,1))
    offset = offset + 1

    tree:add_le(xsense, tvbuf:range(offset,1))
    offset = offset + 1

    tree:add_le(ysense, tvbuf:range(offset,1))
    offset = offset + 1

    tree:add_le(dpi1on, tvbuf:range(offset,1))
    tree:add_le(dpi2on, tvbuf:range(offset,1))
    tree:add_le(dpi3on, tvbuf:range(offset,1))
    tree:add_le(dpi4on, tvbuf:range(offset,1))
    tree:add_le(dpi5on, tvbuf:range(offset,1))
    offset = offset + 12

    -- TODO: DPI Values go here

    tree:add_le(alienfxdisabled, tvbuf:range(offset,1))
    value = tvbuf:range(offset,1):uint()
    if value == 0 then 
        enabled = 1
    else
        enabled = 0
    end
    ti = tree:add_le(alienfxenabled, tvbuf:range(offset,1), enabled)
    ti:set_generated()
    offset = offset + 1
    tree:add_le(pollrate, tvbuf:range(offset,1))
    offset = offset + 1


    tree:add_le(led1on, tvbuf:range(offset,1))
    tree:add_le(led2on, tvbuf:range(offset,1))
    tree:add_le(led3on, tvbuf:range(offset,1))
    tree:add_le(led4on, tvbuf:range(offset,1))
    offset = offset + 2;
    
    tree:add_le(colorfloweffect, tvbuf:range(offset,1))
    offset = offset + 1
    
    tree:add_le(lighteffect, tvbuf:range(offset,1))
    offset = offset + 1

    tree:add_le(effectspeed, tvbuf:range(offset,1))
    offset = offset + 1
    for led_num=1,4 do
        offset = dissect_led_color(tvbuf,pktinfo,tree,offset, led_num)
    end
    
    -- Checking checksum: Last 2 bytes should contain SUM of all previous bytes
    calc_sum = sum_bytes(pktinfo,tvbuf)
    reported_sum = tvbuf:range(offset,2):le_uint()
    ti = tree:add_le(checksum, tvbuf:range(offset,2))
    if calc_sum == reported_sum then
        ti:append_text(" (Correct)")
    else
        --TODO: Expert info
        ti:append_text(" (Incorrect, should be 0x" .. string.format("%04x",tvbuf:range(offset,2):le_uint()) .. ")")
    end
end

local function dissect_konextd_msg_7(tvbuf,pktinfo,tree)
    offset = 2
    value = tvbuf:range(offset,1):uint() + 1
    ti = tree:add_le(profile, tvbuf:range(offset,1))
    ti:append_text(" (Profile " .. (value) .. ")")
    pktinfo.cols.info:set("Updating Kone XTD Profile " .. value .." buttons assignment")
    offset = offset + 1

    -- Standard Button Assignments
    subtree = tree:add(standardkeys,tvbuf:range(offset,36))
    for key_num=1, 12 do
        offset = dissect_key_assignment(tvbuf,pktinfo,subtree,offest,key_num)
    end
    
    -- Easy-Shift Button Assignments
    subtree = tree:add(easyshiftkeys,tvbuf:range(offset,36))
    for key_num=1, 12 do
        offset = dissect_key_assignment(tvbuf,pktinfo,subtree,offest,key_num)
    end

    calc_sum = sum_bytes(pktinfo,tvbuf)
    reported_sum = tvbuf:range(offset,2):le_uint()
    ti = tree:add_le(checksum, tvbuf:range(offset,2))
    if calc_sum == reported_sum then
        ti:append_text(" (Correct)")
    else
        --TODO: Expert info
        ti:append_text(" (Incorrect, should be 0x" .. string.format("%04x",tvbuf:range(offset,2):le_uint()) .. ")")
    end
end

local function heur_dissect_interrupt_konextd(tvbuf,pktinfo,root)
    pktlen = tvbuf:len()
    if pktlen ~= 8 then
        return 0;
    end

    offset = 0;
    local tree = root:add(roccat_kone_xtd, tvbuf:range(offset,pktlen))
    pktinfo.cols.protocol:set("KoneXTD")
    pktinfo.cols.info:set("")

    ti = tree:add_le(message_type, tvbuf:range(offset,1))
    value = tvbuf:range(offset,1):int()
    if value == 0x01 then
        dissect_konextd_msg_1(tvbuf,pktinfo,tree)
    elseif value == 0x03 then
        dissect_konextd_msg_3(tvbuf,pktinfo,tree)
    else
        data_dis(tvbuf,pktinfo,root);
    end

    return pktlen
end

local function heur_dissect_control_konextd(tvbuf,pktinfo,root)
    pktlen = tvbuf:len()
    is_msg_5 = (pktlen == 3) and (tvbuf:range(0,1):int() == 5) and (tvbuf:range(1,1):int() == 3)
    if is_msg_5 == false and pktlen ~= 43 and pktlen ~= 77 then
        return 0;
    end

    offset = 0;
    local tree = root:add(roccat_kone_xtd, tvbuf:range(offset,pktlen))
    pktinfo.cols.protocol:set("KoneXTD")
    pktinfo.cols.info:set("")

    ti = tree:add_le(message_type, tvbuf:range(offset,1))
    value = tvbuf:range(offset,1):int()
    if value == 0x05 then
        dissect_konextd_msg_5(tvbuf,pktinfo,tree)
    elseif value == 0x06 then
        dissect_konextd_msg_6(tvbuf,pktinfo,tree)
    elseif value == 0x07 then
        dissect_konextd_msg_7(tvbuf,pktinfo,tree)
    else
        data_dis(tvbuf,pktinfo,root);
    end

    return pktlen
end

roccat_kone_xtd:register_heuristic("usb.interrupt", heur_dissect_interrupt_konextd)
roccat_kone_xtd:register_heuristic("usb.control", heur_dissect_control_konextd)
