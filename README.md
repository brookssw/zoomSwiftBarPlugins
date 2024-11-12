# Zoom State Scripts

AppleScripts for use with SwiftBar to monitor the various states of Zoom

## About

`zoomMuteState` `zoomScreenShareState` `zoomVideoState` display icons in your menu bar showing whether you are muted or not, screen sharing or not, and sharing video or not.

`zoomBlinkState` will control an attached "blink1" light.

When in a meeting:
- Muted: yellow
- Unmuted: red

## Installation

1. Install [SwiftBar](https://github.com/swiftbar/SwiftBar)
2. Install "blink1" (command line tool that controls the light) with homebrew: `brew install blink1`
3. Locate your SwiftBar plugin folder. By default, it is `~/Library/Application Support/SwiftBar/Plugins`.
4. Place the scripts in your SwiftBar plugins directory.
5. The scripts will automatically run and display the current state in your menu bar.

## Blink1 Device

To use the `zoomBlinkState.1s.scpt` script, you will need a Blink1 device. You can purchase the Blink1 mk3 from [thingm](https://blink1.thingm.com/buy/) or [Amazon](https://www.amazon.com/dp/B07Q8944QK)
