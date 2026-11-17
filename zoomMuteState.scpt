#!/usr/bin/osascript
# <bitbar.title>zoomMuteState</bitbar.title>
# <bitbar.version>v2.0</bitbar.version>
# <bitbar.author>Sebastian</bitbar.author>
# <bitbar.author.github>brookssw</bitbar.author.github>
# <bitbar.desc>Zoom Mute State</bitbar.desc>
# <bitbar.dependencies>Applescript</bitbar.dependencies>

# <swiftbar.type>streamable</swiftbar.type>
# <swiftbar.hideAbout>true</swiftbar.hideAbout>
# <swiftbar.hideRunInTerminal>true</swiftbar.hideRunInTerminal>
# <swiftbar.hideLastUpdated>true</swiftbar.hideLastUpdated>
# <swiftbar.hideDisablePlugin>true</swiftbar.hideDisablePlugin>
# <swiftbar.hideSwiftBar>false</swiftbar.hideSwiftBar>

# Streamable: one long-lived process polls Zoom and writes to stdout only when
# the state changes. Spawning a fresh osascript every second leaks a Mach port
# in WindowServer per launch and eventually gets WindowServer killed.

use AppleScript version "2.4"
use framework "Foundation"
use scripting additions

property btnTitle : "Mute audio"
property pluginName : "zoomMuteState"
property iconOn : "􀊱 | size=18 color=#45e307"
property iconOff : "􀊳 | size=18 color=red"
property iconIdle : "􀊳 | size=18 color=black"

on emit(title)
	set s to "~~~" & linefeed & title & linefeed & "---" & linefeed & pluginName & linefeed
	set d to (current application's NSString's stringWithString:s)'s dataUsingEncoding:(current application's NSUTF8StringEncoding)
	(current application's NSFileHandle's fileHandleWithStandardOutput())'s writeData:d
end emit

on currentTitle()
	try
		if application "zoom.us" is running then
			tell application "System Events" to tell application process "zoom.us"
				if exists (menu bar item "Meeting" of menu bar 1) then
					if exists (menu item btnTitle of menu 1 of menu bar item "Meeting" of menu bar 1) then return iconOn
					return iconOff
				end if
			end tell
		end if
	end try
	return iconIdle
end currentTitle

set lastTitle to missing value
repeat
	set t to currentTitle()
	if t is not lastTitle then
		emit(t)
		set lastTitle to t
	end if
	delay 1
end repeat
