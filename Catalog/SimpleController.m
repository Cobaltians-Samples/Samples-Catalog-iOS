/**
 *
 * SimpleController.m
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

#import "SimpleController.h"

@implementation SimpleController

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark LIFE CYCLE

////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    [self setDelegate:self];
    
    if([self respondsToSelector: @selector(setAutomaticallyAdjustsScrollViewInsets:)])
        self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.toolbar.translucent = NO;
    //self.webView.scrollView.contentInset = UIEdgeInsetsMake(44.0, 0.0, 0.0, 0.0);
}

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark COBALT DELEGATE METHODS

////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)onUnhandledMessage:(NSDictionary *)message
{
    return NO;
}

- (BOOL)onUnhandledEvent:(NSString *)event withData:(NSDictionary *)data andCallback:(NSString *)callback
{
    // SET TEXTS
    if ([event isEqualToString: @"setTexts"]) {
        NSString * title = [data objectForKey: @"title"];
        
        if (title != nil
            && [title isKindOfClass:[NSString class]]) {
            self.navigationItem.title = title;
        }
        
        return YES;
    }
    
    return NO;
}

- (BOOL)onUnhandledCallback:(NSString *)callback withData:(NSDictionary *)data
{
    return NO;
}

@end
