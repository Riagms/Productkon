//
//  MovementtileViewController.h
//  Newproject
//
//  Created by GMSIndia1 on 6/9/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EqothersViewController.h"
@interface MovementtileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *labourview;
@property (strong, nonatomic) IBOutlet UIView *equview;
@property (strong, nonatomic)EqothersViewController*EquVCtrl;
- (IBAction)clsebtn:(id)sender;

@end
