/**
 *
 * CallbacksController.m
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

#import "CallbacksController.h"

#define doSomeMathsFromNative           @"doSomeMathsFromNative"
#define doSomeMathsFromNativeResponse   @"doSomeMathsFromNativeResponse"
#define doSomeMathsFromWeb              @"doSomeMathsFromWeb"
#define autoTestsFromNative             @"autoTestsFromNative"
#define autoTestsFromNativeCallback     @"autoTestsFromNativeCallback"
#define autoTestsFromWeb                @"autoTestsFromWeb"

@implementation CallbacksController
@synthesize dataAuto;
int i = 0;

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark LIFE CYCLE

////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    //[self.navigationController setNavigationBarHidden:YES];
    
    dataAuto = @[@"quotes : it's working \"great\"",
               @"url &eactue;é&12;\n3#23:%20'\\u0020hop",
               @"{ obj_representation : \"test\"}",
               @"emoji \ue415 \\ue415 u{1f604}",
               @"https://cob.s3.amazonaws.com/abcd.jpg?AWSAccessKeyId=1&Expires=1401263985&Signature=xbE%2B49MCgE7/WTKqnvwQ3f4zYmg%3D"] ;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    PubSub *pubsub = [PubSub sharedInstance];
    [pubsub subscribeDelegate:self
                    toChannel:doSomeMathsFromWeb];
    [pubsub subscribeDelegate:self
                    toChannel:doSomeMathsFromNativeResponse];
    [pubsub subscribeDelegate:self
                    toChannel:autoTestsFromWeb];
    [pubsub subscribeDelegate:self
                    toChannel:autoTestsFromNativeCallback];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    PubSub *pubsub = [PubSub sharedInstance];
    [pubsub unsubscribeDelegate:self
                    fromChannel:doSomeMathsFromWeb];
    [pubsub unsubscribeDelegate:self
                    fromChannel:doSomeMathsFromNativeResponse];
    [pubsub unsubscribeDelegate:self
                    fromChannel:autoTestsFromWeb];
    [pubsub unsubscribeDelegate:self
                    fromChannel:autoTestsFromNativeCallback];
}

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark COBALT DELEGATE METHODS

////////////////////////////////////////////////////////////////////////////////////////////////

- (void)didReceiveMessage:(nullable NSDictionary *)message
                onChannel:(nonnull NSString *)channel {
    if ([channel isEqualToString:doSomeMathsFromNativeResponse]) {
        if (message != nil) {
            NSNumber *result = message[kJSResult];
            if (result != nil
                && [result isKindOfClass:[NSNumber class]]) {
                NSString *value = [NSString stringWithFormat:@"result is : %@", result];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"Result"
                                                message:value
                                               delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil] show];
                });
            }
        }
    }
    else if ([channel isEqualToString:doSomeMathsFromWeb]) {
        if (message != nil) {
            NSArray *values = message[kJSValues];
            NSString *callback = message[kJSCallback];
            if (values != nil
                && [values isKindOfClass:[NSArray class]]
                && values.count > 1
                && callback != nil
                && [callback isKindOfClass:[NSString class]]) {
                NSNumber *value1 = values[0];
                NSNumber *value2 = values[1];
                if ([value1 isKindOfClass:[NSNumber class]]
                    && [value2 isKindOfClass:[NSNumber class]]) {
                    NSNumber *result = [NSNumber numberWithDouble:value1.doubleValue + value2.doubleValue];
                    [[PubSub sharedInstance] publishMessage:@{kJSResult: result}
                                                  toChannel:callback];
                }
            }
        }
    }
    else if ([channel isEqualToString:autoTestsFromNativeCallback]) {
        if (message != nil) {
            NSString *messageData = message[kJSData];
            if (messageData != nil
                && [messageData isKindOfClass:[NSString class]]) {
                NSString *data = [dataAuto objectAtIndex:i];
                bool allEquals = true;
                NSLog(@"iOS Native : %@ vs %@", messageData, data);
                if (! [data isEqualToString:messageData]) {
                    allEquals = false;
                    NSLog(@"iOS Native : Error");
                }
                else{
                    NSLog(@"iOS Native : Success");
                }
                i++;
                if (i >= [dataAuto count])
                {
                    i = 0;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (allEquals) {
                            [[[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"All test passed ! No error"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil] show];
                        }
                        else {
                            [[[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Some tests failed !s check logs."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil] show];
                        }
                    });
                }
                else{
                    [self AutoTest:nil];
                }
            }
        }
    }
    else if ([channel isEqualToString:autoTestsFromWeb]) {
        if (message != nil) {
            NSString *callback = message[kJSCallback];
            if (callback != nil
                && [callback isKindOfClass:[NSString class]]) {
                [[PubSub sharedInstance] publishMessage:message
                                              toChannel:callback];
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark INTERACTIONS TO SEND TO JS

////////////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)DoSomeMaths:(id)sender {
    [[PubSub sharedInstance] publishMessage:@{kJSValues: @[@1, @3],
                                              kJSCallback:doSomeMathsFromNativeResponse}
                                  toChannel:doSomeMathsFromNative];
}
    
- (IBAction)AutoTest:(id)sender {
    NSLog(@"passer");
    NSString *data = [dataAuto objectAtIndex:i];
    NSLog(@"iOS Native : %@", data);
    if (data != nil) {
        [[PubSub sharedInstance] publishMessage:@{kJSData: data,
                                                  kJSCallback:autoTestsFromNativeCallback}
                                      toChannel:autoTestsFromNative];
    }
}

@end
