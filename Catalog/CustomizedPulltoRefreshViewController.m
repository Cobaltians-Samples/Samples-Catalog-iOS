/**
 *
 * CustomizedPulltoRefreshViewController.m
 * Cobalt Catalog
 *
 * The MIT License (MIT)
 *
 * Copyright (c) 2014 Cobaltians
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

#import "CustomizedPulltoRefreshViewController.h"

@interface CustomizedPulltoRefreshViewController ()

@end

@implementation CustomizedPulltoRefreshViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.refreshControl.tintColor = [UIColor redColor];
    
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:@"Pull to refresh"];
    
    NSInteger _stringLength=[attString length];
    
    UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:22.0f];
    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _stringLength)];
    [attString addAttribute:NSStrokeColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, _stringLength)];
    [attString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:3.0] range:NSMakeRange(0, _stringLength)];
    
    NSMutableAttributedString *attRefreshString=[[NSMutableAttributedString alloc] initWithString:@"Refreshing"];
    
    _stringLength=[attRefreshString length];
    
    [attRefreshString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, _stringLength)];
    [attRefreshString addAttribute:NSStrokeColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, _stringLength)];
    [attRefreshString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:3.0] range:NSMakeRange(0, _stringLength)];
    
    [self customizeRefreshControlWithAttributedRefreshText: attString  andAttributedRefreshText: attRefreshString andTintColor: [UIColor redColor]];
}

@end
