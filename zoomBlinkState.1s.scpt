#!/usr/bin/osascript
# <bitbar.title>zoomBlinkState</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Sebastian</bitbar.author>
# <bitbar.author.github>brookssw</bitbar.author.github>
# <bitbar.desc>Zoom Meeting State with Blink1 Control</bitbar.desc>
# <bitbar.dependencies>Applescript, blink1-tool</bitbar.dependencies>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>false</swiftbar.hideSwiftBar>

property btnTitle : "Mute audio"
set inMeeting to false
set isMuted to false

try
    if application "zoom.us" is running then
        tell application "System Events"
            tell application process "zoom.us"
                if exists (menu bar item "Meeting" of menu bar 1) then
                    set inMeeting to true
                    
                    # Check mute status - if "Mute audio" exists as menu item, we're unmuted
                    if exists (menu item btnTitle of menu 1 of menu bar item "Meeting" of menu bar 1) then
                        set isMuted to false
                    else
                        set isMuted to true
                    end if
                end if
            end tell
        end tell
        
        # Control blink(1) based on meeting and mute state
        if inMeeting then
            if isMuted then
                do shell script "/opt/homebrew/bin/blink1-tool --yellow"
            else
                do shell script "/opt/homebrew/bin/blink1-tool --red"
            end if
        else
            do shell script "/opt/homebrew/bin/blink1-tool --off"
        end if
    else
        do shell script "/opt/homebrew/bin/blink1-tool --off"
    end if
    
on error errMsg
    # Silent error handling
end try

return " | size=0"