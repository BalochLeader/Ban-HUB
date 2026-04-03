# Ban Hub [BETA] - Script Architecture & Features

## UI Framework: Rayfield (Modern & Categorized)
The script will use the **Rayfield UI Library** for a professional, sleek, and modern look.

### 1. Dashboard (Main)
- **Welcome Message**: "Welcome, @uginkbhai"
- **Status**: "Connected to Roblox Database (Fake)"
- **Global Announcements**: A scrolling text box showing fake global bans (e.g., "User [X] has been banned for Exploiting").

### 2. Ban Panel (The Prank Core)
- **Target Selection**: Dropdown to select players in the server or a TextBox for manual Username entry.
- **Ban Reason**: Dropdown (Exploiting, Toxicity, Admin Abuse).
- **Ban Button**: Triggers the "Visual Ban" sequence.
    - **Sequence**: 
        1. "Connecting to Roblox Admin API..."
        2. "Bypassing 2FA..."
        3. "Injecting Ban Packet..."
        4. **Notification**: "{username} has been successfully banned from {game_name}."
        5. **Visual Effect**: The target player disappears *only for the user* (Set Transparency to 1 and Disable Shadows).

### 3. Admin Tools (Visual & Real)
- **Ban Hammer**: Gives the user a tool. When they hit a player, it triggers the visual ban sequence.
- **Player Banner**: A special UI that pops up on the user's screen showing the target's avatar and a "BAN" button.
- **Fly**: Functional flying script.
- **NoClip**: Functional noclip script.
- **Speed/Jump**: Sliders for local character modification.

### 4. Visual Pranks (Extra)
- **Fake Console**: A window that prints fake "Hacking" logs.
- **Server Message**: A fake "System Message" that appears in the user's chat (only visible to them).
- **Emotes**: Quick access to Roblox emotes.

## Technical Implementation
- **Local-Only**: All "Ban" effects will be handled via `LocalScript` logic so they only affect the user's view, making it a perfect prank.
- **Rayfield Library**: Loaded via `loadstring(game:HttpGet(...))`.
