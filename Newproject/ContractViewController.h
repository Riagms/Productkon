//
//  ContractViewController.h
//  Newproject
//
//  Created by GMSIndia1 on 3/12/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MangmntdetailsViewController.h"

@interface ContractViewController : UIViewController



@property(strong,nonatomic)MangmntdetailsViewController *mgmtdetails;

/*IBActions*/
-(IBAction)closethecontractpage:(id)sender;

/*IBOutlets*/
@property(strong,nonatomic)IBOutlet UITableView *contracttable;
@property(strong,nonatomic)IBOutlet UIView *contracttitleview;
-(IBAction)tomgmt:(id)sender;
@end
