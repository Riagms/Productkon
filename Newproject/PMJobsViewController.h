//
//  PMJobViewController.h
//  Newproject
//
//  Created by Riya on 1/7/15.
//  Copyright (c) 2015 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinkViewController.h"
#import "PurchaseViewController.h"
#import "PMjobsmdl.h"
@interface PMJobsViewController : UIViewController{
    UIButton *button;
    BOOL  recordResults;
    NSInteger webtype;
}

@property (strong, nonatomic)PurchaseViewController *purchaseVCtrl;
@property (strong, nonatomic)PMjobsmdl *jobmdl;
@property (strong, nonatomic)NSMutableArray *jobarray;
/* xmlparser*/
@property(strong,nonatomic)NSXMLParser *xmlParser;
@property(strong,nonatomic)NSMutableString *soapResults;
@property(strong,nonatomic)NSMutableData *webData;
/*comment*/
@property (strong, nonatomic) IBOutlet UIView *titleview;
@property (strong, nonatomic) IBOutlet UITableView *jobtable;
@property (strong, nonatomic) IBOutlet UITableViewCell *jobcell;
@property (strong, nonatomic)NSMutableArray *disclurearray;
@property(strong,nonatomic)UITableView *popovertableview;
@property(strong,nonatomic)UIPopoverController *popovercontroller;

- (IBAction)clsebtn:(id)sender;

/*cell outlets */

@property (strong, nonatomic) IBOutlet UILabel *numbrcell;
@property (strong, nonatomic) IBOutlet UILabel *bidlbl;
@property (strong, nonatomic) IBOutlet UILabel *datelbl;
@property (strong, nonatomic) IBOutlet UILabel *custmrlbl;

@property (strong, nonatomic) IBOutlet UILabel *cntrctlbl;
@property (strong, nonatomic) IBOutlet UILabel *Amtlbl;
@property (strong, nonatomic) IBOutlet UILabel *manhrlbl;
@property (strong, nonatomic) IBOutlet UILabel *eqhrlbl;
@property (strong, nonatomic) IBOutlet UILabel *manpwrlbl;
@property (strong, nonatomic) IBOutlet UILabel *equlbl;
@property (strong, nonatomic) IBOutlet UILabel *matlbl;
@property (strong, nonatomic) IBOutlet UILabel *othrlbl;
@property (strong, nonatomic) IBOutlet UIButton *disclsurbtnlbl;
- (IBAction)disclurebtn:(id)sender;


/*link view */
@property (strong, nonatomic) IBOutlet UIView *linkview;
@property (strong, nonatomic) IBOutlet UIButton *linkbtn;
@property (strong, nonatomic) IBOutlet UIButton *updatebtnlbl;

- (IBAction)updatebtn:(id)sender;
- (IBAction)linkclsebtn:(id)sender;



@end