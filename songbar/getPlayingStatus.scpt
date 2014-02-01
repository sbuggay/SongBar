set playStatus to "notPlaying"
tell application "Spotify"
	if player state is playing then
		set playStatus to "playing"
	end if
end tell
return playStatus