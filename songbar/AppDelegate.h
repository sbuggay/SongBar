//
//  AppDelegate.h
//  songbar
//
//  Created by Devan Buggay on 12/14/13.
//  Copyright (c) 2013 Devan Buggay. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu *statusMenu;
    __weak NSMenuItem *_playButton;
    NSStatusItem * statusItem;
    NSTimer *timer;
    NSWindowController *preferences;
}
- (BOOL) getPlaying;
- (void) update;

- (IBAction)togglePlay:(id)sender;
- (IBAction)openPreferences:(id)sender;

- (IBAction)openSpotify:(id)sender;
- (IBAction)Quit:(id)sender;
- (IBAction)quitSpotify:(id)sender;


@property (weak) IBOutlet NSMenuItem *playButton;
@end
