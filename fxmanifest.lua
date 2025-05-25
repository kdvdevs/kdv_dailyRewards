fx_version 'adamant'

game 'gta5'
-- Rất biết ơn nếu bạn giữ nguyên phần này
-- I would be very grateful if you keep this part unchanged
author 'KDV Dev'
description 'Daily Rewards System'
version '1.0.0'

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}

shared_scripts {
    'config.lua'
}

ui_page 'ui/index.html'

files {
    'ui/index.html',
    'ui/style.css',
    'ui/script.js',
    'ui/imgs/*.png',
}