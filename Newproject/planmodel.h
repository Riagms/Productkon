//
//  planmodel.h
//  Newproject
//
//  Created by GMSIndia 2 on 13/02/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface planmodel : NSObject

@property(readwrite)NSInteger planid;
@property(strong,nonatomic)NSString *customername;
@property(readwrite)NSInteger leadid;
@property(readwrite)NSInteger customerid;
@property(readwrite)NSInteger idvalue;

@end
