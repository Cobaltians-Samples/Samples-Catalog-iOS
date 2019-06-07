/**
 *
 * EventsController.m
 * Cobalt Catalog
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2013 Cobaltians
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import "EventsController.h"

#define setZoom                 @"setZoom"
#define kDefaultTextZoomLevel   @"textSizeZoomLevel"
#define defaultTextZoomLevel    10
#define hello                   @"hello"

@implementation EventsController

@synthesize textSizeCurrentZoomLevel,
            textSizeMaxZoomLevel,
            textSizeMinZoomLevel,
            zoomInButton,
            zoomOutButton;

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark LIFE CYCLE

////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    //[self.navigationController setNavigationBarHidden:YES];

    textSizeMaxZoomLevel = [NSNumber numberWithInt:20];
    textSizeMinZoomLevel = [NSNumber numberWithInt:5];
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger currentSize = [standardUserDefaults integerForKey:kDefaultTextZoomLevel];
    currentSize = (currentSize && currentSize >= textSizeMinZoomLevel.integerValue && textSizeMaxZoomLevel.integerValue >= currentSize) ? currentSize : defaultTextZoomLevel;
    textSizeCurrentZoomLevel =[NSNumber numberWithInteger:currentSize];
    [self setZoomLevelInWebView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [Cobalt subscribeDelegate:self
                    toChannel:hello];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [Cobalt unsubscribeDelegate:self
                    fromChannel:hello];
}

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark PUBSUB DELEGATE METHODS

////////////////////////////////////////////////////////////////////////////////////////////////

- (void)didReceiveMessage:(nullable NSDictionary *)message
                onChannel:(nonnull NSString *)channel {
    if ([channel isEqualToString:hello]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"hello"
                                        message:@"hello world"
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
        });
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark METHODS

////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)onZoomInButton:(id)sender
{
    BOOL enabled = YES;
    
    textSizeCurrentZoomLevel = [NSNumber numberWithInt:([textSizeCurrentZoomLevel intValue] + 1)];
    if ([textSizeCurrentZoomLevel intValue] >= [textSizeMaxZoomLevel intValue]) {
        enabled = NO;
    }
    
    [zoomInButton setEnabled:enabled];
    [zoomOutButton setEnabled:YES];
    
    [self setZoomLevelInWebView];
    [self saveZoomLevelToUserDefaults:textSizeCurrentZoomLevel];
}

- (IBAction)onZoomOutButton:(id)sender
{
    BOOL enabled = YES;
    
    textSizeCurrentZoomLevel = [NSNumber numberWithInt:([textSizeCurrentZoomLevel intValue] - 1)];
    
    if ([textSizeCurrentZoomLevel intValue] <= [textSizeMinZoomLevel intValue]) {
        enabled = NO;
    }
    
    [zoomOutButton setEnabled:enabled];
    [zoomInButton setEnabled:YES];
    
    [self setZoomLevelInWebView];
    [self saveZoomLevelToUserDefaults:textSizeCurrentZoomLevel];
}

- (void)setZoomLevelInWebView
{
    [Cobalt publishMessage:@{kJSValue: textSizeCurrentZoomLevel}
                 toChannel:setZoom];
}


- (void)saveZoomLevelToUserDefaults:(NSNumber *)zoomLevel
{
    NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setInteger:[zoomLevel integerValue] forKey:kDefaultTextZoomLevel];
        [standardUserDefaults synchronize];
    }
}

@end
