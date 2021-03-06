//
//  MovementtileViewController.h
//  Newproject
//
//  Created by GMSIndia1 on 6/9/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EqothersViewController.h"
#import "RMLaborViewController.h"
#import "Rightscheck.h"
@interface MovementtileViewController : UIViewController
{
    BOOL recordResults;
    NSString *userid;
}
@property (strong, nonatomic) IBOutlet UIView *labourview;
@property (strong, nonatomic) IBOutlet UIView *equview;
@property (strong, nonatomic)EqothersViewController*EquVCtrl;
@property (strong, nonatomic)RMLaborViewController*labrVCtrl;
- (IBAction)clsebtn:(id)sender;

/* xmlparser*/
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSMutableData *webData;

@property(strong,nonatomic)Rightscheck *rights;
@property(readwrite)NSInteger Moduleid;
@property(strong,nonatomic)NSMutableArray *userrightsarray;
@property(strong,nonatomic)NSString *result;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *EQothersindicator;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *LbrIndictr;

@end
