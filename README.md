# FiveM Daily Login Rewards System

A modern, customizable daily login rewards system for ESX-based FiveM servers. Supports item, money, weapon, and vehicle rewards with a beautiful and easy-to-configure UI.
![Screenshot 2025-05-26 064240](https://github.com/user-attachments/assets/3d09306b-0baf-44cb-8cc9-a1953b88e963)
![Screenshot 2025-05-26 064300](https://github.com/user-attachments/assets/62def650-592d-4ece-a338-8aa0aa0f51da)

## Features

- Daily login rewards for players (customizable for each day)
- Supports items, money, weapons, and vehicles
- Easily customizable UI, multi-language ready via `config.lua`
- Glow effects for special rewards
- Countdown timer for the next reward
- Easy configuration via `config.lua`
- If an image is missing, it will automatically use `imgs/default.png`
- You can add your own images in the `ui/imgs` folder

## Installation

1. **Download or clone this repo** into your `resources` folder.
2. **SQL Table:** The script will automatically create the `daily_rewards` table if it doesn't exist.
3. **Add to your `server.cfg`:**
    ```
    ensure kdv_dailyRewards
    ```
4. **Configure rewards and language** in the `config.lua` file.

## Configuration
Open `config.lua` to edit:
![image](https://github.com/user-attachments/assets/81146da9-dd61-4a3f-9402-b111f42fe7a7)

- **Daily rewards:**  
  Edit the `Config.DailyRewards` table to set up rewards for each day.
- **UI & server translations:**  
  Edit `Config.Texts` for your preferred language, or leave as is for English.
- **Other options:**  
  - `Config.ShowTimer`: Enable/disable countdown timer
  - `Config.ShowGlow`: Enable/disable glow effect
  - `Config.OpenCommand`: Command to open UI (default: `/daily`)
  - `Config.OpenKey`: Key to open UI (default: `F9`)

## Usage

- Players open the rewards UI by typing `/daily` or pressing the configured key (default: F9).
- Click "COLLECT" to claim the reward for the current day.

## License

This project is free and open-source. Please keep the credit in `fxmanifest.lua`.

## Support

For support, questions, or suggestions, join our Discord:  
**KDV Dev** [https://discord.gg/z3RM2p3rWm](https://discord.gg/z3RM2p3rWm)
