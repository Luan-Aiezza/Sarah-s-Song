# Sarah's Song

🏆 **Swift Student Challenge 2025 winner**

An interactive story and virtual keyboard for **people with hearing impairments**. Each piano note has its own **haptic vibration**, so you can feel music through your fingers. Built as a Swift Playgrounds app (`.swiftpm`) for iPhone.

## The idea

Sarah has loved games and music since she was a child, but an ear infection slowly took her hearing. When she discovered **Music Haptics**, she thought of Beethoven, who kept playing by feeling the piano's vibrations. This project explores the same idea: a vibration pattern for each musical note.

## How it works

1. **Dialogue scene:** Sarah tells her story and introduces the keyboard.
2. **Piano scene:** a 13-key keyboard (Dó to Dó2, including sharps) where each key plays a sampled note and a Core Haptics vibration with its own intensity. A demo button plays a melody for first-time players, and an information popover explains how to use it.
3. **Closing scene:** a short message about hearing loss and how haptics can help.

## Tech stack

![Swift](https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white) ![SwiftUI](https://img.shields.io/badge/SwiftUI-007AFF?style=for-the-badge&logo=swift&logoColor=white) ![SpriteKit](https://img.shields.io/badge/SpriteKit-000000?style=for-the-badge&logo=apple&logoColor=white) ![Core Haptics](https://img.shields.io/badge/Core%20Haptics-FF2D55?style=for-the-badge&logo=apple&logoColor=white) ![AVFoundation](https://img.shields.io/badge/AVFoundation-34C759?style=for-the-badge&logo=apple&logoColor=white)

- **SwiftUI + SpriteKit:** `SpriteView` hosts the menu, dialogue, piano and end scenes.
- **Core Haptics:** `HapticsManager` plays one transient haptic event per note.
- **AVFoundation:** note samples (`.m4a`), background music and click sounds.
- Custom font and vector (SVG) artwork.

## Project structure

```
Sarah's Song.swiftpm
├── MyApp.swift, ContentView.swift   App entry point and SpriteView host
├── MainMenuScene.swift              Main menu
├── DialogueScene.swift, DialogueScene2.swift, EndScene.swift
├── MainScene/                       PianoScene, PianoKeysManager, HapticsManager, PopoverManager
├── BackgroundMusic.swift, FontManager.swift
└── Resources/                       Note samples, music, font
```

## Running the project

Requirements: an **iPhone with a Taptic Engine** (haptics do not work in the simulator), running **iOS 17.6 or later**. The app runs in landscape.

1. Clone the repository:
   ```bash
   git clone https://github.com/Luan-Aiezza/SarahsSong.git
   ```
2. Open `Sarah's Song.swiftpm` in **Xcode** or **Swift Playgrounds**.
3. Select your iPhone and press **Run**.

`Sarah's Song.zip` is the packaged submission.

## Author

[Luan Aiezza](https://github.com/Luan-Aiezza)
