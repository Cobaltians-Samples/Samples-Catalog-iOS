/**
 *
 * EventsController.h
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

#import <Cobalt/CobaltViewController.h>

@interface EventsController : SimpleController <CobaltDelegate>

@property (strong, nonatomic) IBOutlet UIButton * zoomOutButton;
@property (strong, nonatomic) IBOutlet UIButton * zoomInButton;

@property (strong,nonatomic) NSNumber * textSizeCurrentZoomLevel;
@property (strong,nonatomic) NSNumber * textSizeMaxZoomLevel;
@property (strong,nonatomic) NSNumber * textSizeMinZoomLevel;

/*!
 @method		- (IBAction)onZoomInButton:(id)sender
 @abstract		Processes the action when the zoom in button is clicked.
 @param         sender  The object posting the action.
 */
- (IBAction)onZoomOutButton:(id)sender;

/*!
 @method		- (IBAction)onZoomOutButton:(id)sender
 @abstract		Processes the action when the zoom out button is clicked.
 @param         sender  The object posting the action.
 */
- (IBAction)onZoomInButton:(id)sender;

@end
