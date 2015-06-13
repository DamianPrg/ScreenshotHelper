//
//  ViewController.h
//  ScreenshotHelper
//
//  Created by Damian Balandowski on 13.06.2015.
//  Copyright (c) 2015 DamianB. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property NSString* path;
@property NSString* extenstion;

@property (strong) IBOutlet NSTextField *PathText;
@property (strong) IBOutlet NSPathControl *PathControl;
@property (strong) IBOutlet NSComboBox *fileExtCombo;

- (void)updateScreenshotLocation;
- (void)updateScreenshotExtenstion;
- (void)killUIServer;
- (void)runCommand:(NSString *)commandToRun;
- (IBAction)comboSelected:(id)sender;
- (IBAction)resetToDefaults:(id)sender;


@end

