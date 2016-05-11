/**
 *
 * PluginsController.m
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

#import "PluginsController.h"

@implementation PluginsController

////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark WEBSERVICES STORAGE DELEGATE METHODS

////////////////////////////////////////////////////////////////////////////////////////////////

- (id) processData: (id) data withParameters: (NSDictionary *) parameters {
    if (parameters) {
        NSString * countParameter = [parameters objectForKey: @"count"];

        if (countParameter && [data isKindOfClass: [NSDictionary class]]) {
            int count = [countParameter intValue];

            NSMutableDictionary * dataToReturn = [(NSDictionary *) data mutableCopy];
            NSMutableArray * imageList = [[data objectForKey: @"result"]  mutableCopy];
            NSMutableArray * filteredImageList = [NSMutableArray array];

            if (imageList) {
                unsigned long max = MIN(count, [imageList count]);

                for (int i = 0; i < max; i++) {
                    int randomIndex = arc4random_uniform((int) [imageList count]);
                    id randomImage = [imageList objectAtIndex: randomIndex];
                    [filteredImageList addObject: randomImage];
                }

                [dataToReturn setObject: filteredImageList forKey: @"result"];

                return dataToReturn;
            }
        }
    }

    return data;
}


@end
