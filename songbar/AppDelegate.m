//
//  AppDelegate.m
//  songbar
//
//  Created by Devan Buggay on 12/14/13.
//  Copyright (c) 2013 Devan Buggay. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{

}

-(void)awakeFromNib{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setMenu:statusMenu];
    [statusItem setHighlightMode:YES];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(update) userInfo:nil repeats:YES];

}

-(void)update{
    NSMutableString *checkText = [NSMutableString stringWithString:@"tell application \"System Events\" to (name of processes) contains \"Spotify\"\n"];
    NSAppleScript *check = [[NSAppleScript alloc] initWithSource:checkText];
    NSAppleEventDescriptor *checkResult = [check executeAndReturnError:nil];
    
    if([[checkResult stringValue] isEqualToString:@"true"]) {
        NSMutableString *scriptText = [NSMutableString stringWithString:@"tell application \"Spotify\" to set artistName to artist of current track\n"];
        [scriptText appendString:@"tell application \"Spotify\" to set songName to name of current track\n"];
        [scriptText appendString:@"return artistName & \" - \" & songName\n"];
        NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptText];
        NSAppleEventDescriptor *result = [script executeAndReturnError:nil];
        
        NSMutableString *title = [NSMutableString stringWithString:[result stringValue]];
        
        [statusItem setTitle:title];
        if([self getPlaying]) {
            [_playButton setTitle:@"Pause"];
        }
        else {
            [_playButton setTitle:@"Play"];
        }
    }
    else {
        [statusItem setTitle:@"No song"];
    }
    
}

- (IBAction)togglePlay:(id)sender {
    if([self getPlaying]) {
        NSMutableString *scriptText = [NSMutableString stringWithString:@"tell application \"Spotify\" to pause\n"];
        NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptText];
        [script executeAndReturnError:nil];
        
    }
    else {
        NSMutableString *scriptText = [NSMutableString stringWithString:@"tell application \"Spotify\" to play\n"];
        NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptText];
        [script executeAndReturnError:nil];
        
    }
}

- (IBAction)openPreferences:(id)sender {
    preferences = [[NSWindowController alloc] initWithWindowNibName:@"Preferences"];
    [preferences showWindow:self];
}

- (IBAction)next:(id)sender {
    NSMutableString *scriptText = [NSMutableString stringWithString:@"tell application \"Spotify\" to next track\n"];
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptText];
    [script executeAndReturnError:nil];
}

-(BOOL)getPlaying{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"getPlayingStatus" ofType:@"scpt"];
    NSURL* url = [NSURL fileURLWithPath:path];NSDictionary* errors = [NSDictionary dictionary];
    NSAppleScript* appleScript = [[NSAppleScript alloc] initWithContentsOfURL:url error:&errors];
    NSAppleEventDescriptor *result = [appleScript executeAndReturnError:nil];
    if([[result stringValue] isEqualToString:@"playing"]) {

        return YES;
    }
    else {

        return NO;
    }
}

- (IBAction)openSpotify:(id)sender {
    NSMutableString *scriptText = [NSMutableString stringWithString:@"tell application \"Spotify\" to activate\n"];
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptText];
    [script executeAndReturnError:nil];
}

- (IBAction)Quit:(id)sender {
    
    [[NSApplication sharedApplication] terminate:nil];
}

- (IBAction)quitSpotify:(id)sender {
    NSMutableString *scriptText = [NSMutableString stringWithString:@"tell application \"Spotify\" to quit\n"];
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:scriptText];
    [script executeAndReturnError:nil];
    [[NSApplication sharedApplication] terminate:nil];

}
@end
