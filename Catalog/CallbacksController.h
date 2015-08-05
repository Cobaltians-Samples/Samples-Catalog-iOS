//
//  CallbacksController.h
//  HPHybridCatalog
//
//  Created by Diane on 11/04/13.
//  Copyright (c) 2013 Haploid. All rights reserved.
//

#import "SimpleController.h"

#import <Cobalt/CobaltViewController.h>

@interface CallbacksController : SimpleController <CobaltDelegate>

@property (nonatomic,retain) NSArray* dataAuto;
- (IBAction)DoSomeMaths:(id)sender;
- (IBAction)AutoTest:(id)sender;
@end
