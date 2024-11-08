#!/usr/bin/osascript
# <bitbar.title>zoomShareScreenState</bitbar.title>
# <bitbar.version>v1.1</bitbar.version>
# <bitbar.author>Sebastian</bitbar.author>
# <bitbar.author.github>brookssw</bitbar.author.github>
# <bitbar.desc>Zoom Screen Share State</bitbar.desc>
# <bitbar.dependencies>Applescript</bitbar.dependencies>

# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>false</swiftbar.hideSwiftBar>

property btnTitle : "Start Share"

if application "zoom.us" is running then
	tell application "System Events"
		tell application process "zoom.us"
			if exists (menu bar item "Meeting" of menu bar 1) then
				if exists (menu item btnTitle of menu 1 of menu bar item "Meeting" of menu bar 1) then
					set returnValue to "􁏴 | size=18 color=black"
				else
					set returnValue to "􁏴 | size=18 color=yellow"
				end if
			else
				set returnValue to "􁏴 | size=18 color=black"
			end if	
		end tell
	end tell
else
	set returnValue to "􁏴 | size=18 color=black"
end if

return returnValue & "
---
zoomScreenShareState"