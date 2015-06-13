//
//  ViewController.m
//  ScreenshotHelper
//
//  Created by Damian Balandowski on 13.06.2015.
//  Copyright (c) 2015 DamianB. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.fileExtCombo selectItemAtIndex:0];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}
- (IBAction)selectPathClick:(id)sender {
    
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    [panel setAllowsMultipleSelection:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanChooseFiles:NO];
    [panel setCanCreateDirectories:YES];
    [panel setCanSelectHiddenExtension:NO];
    
    if([panel runModal] != NSFileHandlingPanelCancelButton)
    {
        self.path = [[panel URL] absoluteString];
        
        NSString * fixedPath = [self.path mutableCopy];
        fixedPath = [fixedPath substringFromIndex:7];
        
        
        self.path = fixedPath;
        [self.PathControl setStringValue:self.path];
        
    }
    
}

// sets default screenshot location to desktop
- (IBAction)defaultPathClick:(id)sender {
    
    self.path = @"~/Desktop";
    
    [self.PathControl setStringValue:self.path];

}

- (IBAction)applyClick:(id)sender {

    [self updateScreenshotLocation]; // update screenshot location to our new location
    [self updateScreenshotExtenstion]; // update screenshot extenstion to new extenstion
    
    [self killUIServer]; // update UI
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"Success"
                                     defaultButton:@"OK" alternateButton:nil
                                       otherButton:nil informativeTextWithFormat:
                      @""];
    
    [alert runModal];

    
}

- (void)updateScreenshotLocation {
    
    NSString* fullExecPath = [NSString stringWithFormat:@"defaults write com.apple.screencapture location %@", (NSString*)self.path];
    
    [self runCommand:fullExecPath];
    
}

- (void)updateScreenshotExtenstion {
    
    NSString* newExtenstion = (NSString*)[self.fileExtCombo objectValueOfSelectedItem];
    NSString* fullExecPath = [NSString stringWithFormat:@"defaults write com.apple.screencapture type %@", newExtenstion];

    [self runCommand:fullExecPath];
}

- (void)killUIServer {
    
    [self runCommand:@"killall SystemUIServer"];
    
}

// http://stackoverflow.com/questions/412562/execute-a-terminal-command-from-a-cocoa-app @ kenial
- (void)runCommand:(NSString *)commandToRun
{
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/sh"];
    
    NSArray *arguments = [NSArray arrayWithObjects:
                          @"-c" ,
                          [NSString stringWithFormat:@"%@", commandToRun],
                          nil];
    [task setArguments:arguments];
    
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    
    [task launch];
}

- (IBAction)comboSelected:(id)sender {
    
   // NSLog([self.fileExtCombo objectValueOfSelectedItem]);
    
}

- (IBAction)resetToDefaults:(id)sender {
    
    NSAlert *alert = [NSAlert alertWithMessageText:@"Success"
                                     defaultButton:@"OK" alternateButton:nil
                                       otherButton:nil informativeTextWithFormat:
                      @"Default values are restored."];
    
    [alert runModal];

    
    [self runCommand:@"defaults write com.apple.screencapture location ~/Desktop"];
    [self runCommand:@"defaults write com.apple.screencapture type png"];
    [self runCommand:@"killall SystemUIServer"];

}

@end
