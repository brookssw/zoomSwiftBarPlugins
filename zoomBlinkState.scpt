#!/usr/bin/osascript
# <bitbar.title>zoomBlinkState</bitbar.title>
# <bitbar.version>v2.0</bitbar.version>
# <bitbar.author>Sebastian</bitbar.author>
# <bitbar.author.github>brookssw</bitbar.author.github>
# <bitbar.desc>Zoom Meeting State with Blink1 Control</bitbar.desc>
# <bitbar.dependencies>Applescript, blink1-tool</bitbar.dependencies>

# <swiftbar.type>streamable</swiftbar.type>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>false</swiftbar.hideSwiftBar>

# Streamable: one long-lived process polls Zoom and only calls blink1-tool when
# the state changes. Spawning a fresh osascript every second leaks a Mach port
# in WindowServer per launch and eventually gets WindowServer killed.

use AppleScript version "2.4"
use framework "Foundation"
use scripting additions

property btnTitle : "Mute audio"
property blinkTool : "/opt/homebrew/bin/blink1-tool"

on emit(s)
	set d to (current application's NSString's stringWithString:s)'s dataUsingEncoding:(current application's NSUTF8StringEncoding)
	(current application's NSFileHandle's fileHandleWithStandardOutput())'s writeData:d
end emit

-- Returns "off" (no meeting), "muted", or "live".
on currentState()
	try
		if application "zoom.us" is running then
			tell application "System Events" to tell application process "zoom.us"
				if exists (menu bar item "Meeting" of menu bar 1) then
					-- "Mute audio" in the Meeting menu means we're unmuted.
					if exists (menu item btnTitle of menu 1 of menu bar item "Meeting" of menu bar 1) then return "live"
					return "muted"
				end if
			end tell
		end if
	end try
	return "off"
end currentState

on setLight(state)
	set arg to "--off"
	if state is "muted" then set arg to "--yellow"
	if state is "live" then set arg to "--red"
	try
		do shell script quoted form of blinkTool & " " & arg & " >/dev/null 2>&1"
		return true
	on error
		return false -- device unplugged etc.; retry next tick
	end try
end setLight

emit(" | size=0" & linefeed)

set lastState to missing value
repeat
	set s to currentState()
	if s is not lastState then
		if setLight(s) then set lastState to s
	end if
	delay 1
end repeat
