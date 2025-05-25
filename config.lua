Config = {}

Config.ShowTimer = true -- If true, show the timer; if false, hide the timer
Config.ShowGlow = true  -- If true, show glow effect for rewards; if false, hide glow

Config.OpenCommand = "daily" -- Type /daily to open the UI
Config.OpenKey = "F9"        -- Press F9 to open the UI (can be changed to "F5", "F6", etc.)

-- Daily rewards configuration
Config.DailyRewards = {
    [1]  = { type = "item",    item = "water",    amount = 2,     label = "Water",    glow = "white" },
    [2]  = { type = "item",    item = "phone",    amount = 1,     label = "Phone",    glow = "white" },
    [3]  = { type = "item",    item = "radio",    amount = 1,     label = "Radio",    glow = "white" },
    [4]  = { type = "item",    item = "lockpick", amount = 1,     label = "Lockpick", glow = "blue" },
    [5]  = { type = "item",    item = "burger",   amount = 3,     label = "Burger",   glow = "blue" },
    [6]  = { type = "item",    item = "medikit",  amount = 2,     label = "Medikit",  glow = "blue" },
    [7]  = { type = "item",    item = "bandage",  amount = 2,     label = "Bandage",  glow = "blue" },
    [8]  = { type = "money",   item = "money",    amount = 5000,  label = "Cash",     glow = "blue" },
    [9]  = { type = "item",    item = "lockpick", amount = 2,     label = "Lockpick", glow = "blue" },
    [10] = { type = "item",    item = "armour",   amount = 1,     label = "Armour",   glow = "pink" },
    [11] = { type = "money",   item = "money",    amount = 1000,  label = "Cash",     glow = "pink" },
    [12] = { type = "weapon",  item = "weapon_pistol",      amount = 10,    label = "Pistol",      glow = "pink" },
    [13] = { type = "item",    item = "water",    amount = 4,     label = "Water",    glow = "pink" },
    [14] = { type = "weapon",  item = "weapon_bat",      amount = 1,     label = "Bat",      glow = "pink" },
    [15] = { type = "item",    item = "water",    amount = 2,     label = "Water",    glow = "pink" },
    [16] = { type = "item",    item = "phone",    amount = 1,     label = "Phone",    glow = "pink" },
    [17] = { type = "item",    item = "radio",    amount = 1,     label = "Radio",    glow = "pink" },
    [18] = { type = "item",    item = "lockpick", amount = 1,     label = "Lockpick", glow = "pink" },
    [19] = { type = "item",    item = "burger",   amount = 3,     label = "Burger",   glow = "pink" },
    [20] = { type = "item",    item = "medikit",  amount = 2,     label = "Medikit",  glow = "yellow" },
    [21] = { type = "item",    item = "bandage",  amount = 2,     label = "Bandage",  glow = "yellow" },
    [22] = { type = "money",   item = "money",    amount = 1000,  label = "Cash",     glow = "yellow" },
    [23] = { type = "item",    item = "lockpick", amount = 2,     label = "Lockpick", glow = "yellow" },
    [24] = { type = "item",    item = "armour",   amount = 1,     label = "Armour",   glow = "yellow" },
    [25] = { type = "money",   item = "money",    amount = 1000,  label = "Cash",     glow = "yellow" },
    [26] = { type = "weapon",  item = "weapon_switchblade", amount = 10, label = "Pistol", glow = "yellow" },
    [27] = { type = "item",    item = "water",    amount = 4,     label = "Water",    glow = "yellow" },
    [28] = { type = "weapon",  item = "weapon_candycane",   amount = 1,  label = "Bat",    glow = "yellow" },
    [29] = { type = "money",   item = "money",    amount = 1000,  label = "Cash",     glow = "yellow" },
    [30] = { type = "money",   item = "money",    amount = 1000,  label = "Cash",     glow = "yellow" },
    [31] = { type = "vehicle", item = "adder",    amount = 1,     label = "Adder",    glow = "green" },
}

-- If you don't set these, don't worry, it will automatically display in English
-- Config.Texts = { 
--     -- UI translations
--     daily = "HÀNG NGÀY",
--     rewards = "PHẦN THƯỞNG",
--     next_reward = "PHẦN THƯỞNG TIẾP THEO",
--     collect = "NHẬN",
--     collected = "ĐÃ NHẬN",
--     locked = "KHÓA",
--     already_claimed = "Bạn đã nhận phần thưởng này rồi!",
--     not_time = "Chưa đến lúc nhận phần thưởng này!",
--     received = "Bạn đã nhận %s x%s",
--     day = "NGÀY",
--     timer = "%sH : %sM : %sS"

--     -- Server translations
--     already_claimed = "Bạn đã nhận quà hôm nay rồi!",
--     all_claimed = "Bạn đã nhận hết phần thưởng tháng này!",
--     received_item = "Bạn nhận được ~b~%sx %s",
--     received_money = "Bạn nhận được ~g~$%s",
--     received_weapon = "Bạn nhận được vũ khí ~y~%s ~s~x%s",
--     received_vehicle = "Bạn nhận được xe ~b~%s~s~ biển số ~y~%s",
--     vehicle_error = "Có lỗi khi thêm xe, vui lòng liên hệ admin!"
-- }