//
//  DetailplanViewController.h
//  Newproject
//
//  Created by GMSIndia 2 on 13/02/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailplanViewController : UIViewController
{
    BOOL recordResults;
}

@property(strong,nonatomic)NSString *planid;


/*IBActions*/
-(IBAction)closeplan:(id)sender;
- (IBAction)Scaffoldslection:(id)sender;
- (IBAction)InsulationSelection:(id)sender;
- (IBAction)fireproofingselection:(id)sender;

/*IBOutlets*/
@property(strong,nonatomic)IBOutlet UIBarButtonItem *scaffoldbtn;
@property(strong,nonatomic)IBOutlet UIBarButtonItem *insulationbtn;
@property(strong,nonatomic)IBOutlet UIBarButtonItem *fireproofingbtn;

@property(strong,nonatomic)IBOutlet UIView *scaffoldview;
//@property(strong,nonatomic)IBOutlet UIView *insulationview;
//@property(strong,nonatomic)IBOutlet UIView *fireproofingview;
@property(strong,nonatomic)IBOutlet UIView *scaffoldtabletitleview;
@property(strong,nonatomic)IBOutlet UITableViewCell *scaffoldcell;
@property(strong,nonatomic)IBOutlet UITableView *scaffoldtable;

/*outlets in cell*/
@property(strong,nonatomic)IBOutlet UILabel *unitcelllabel;
@property(strong,nonatomic)IBOutlet UILabel *equipcelllabel;
@property(strong,nonatomic)IBOutlet UILabel *pjctheadercelllabel;
@property(strong,nonatomic)IBOutlet UILabel *scaffoldcellalbel;
@property(strong,nonatomic)IBOutlet UILabel *lengthcelllabel;
@property(strong,nonatomic)IBOutlet UILabel *heightcelllabel;
@property(strong,nonatomic)IBOutlet UILabel *widthcelllabel;
@property(strong,nonatomic)IBOutlet UILabel *quantitycelllabel;
@property(strong,nonatomic)IBOutlet UILabel *elevationcelllabel;
@property(strong,nonatomic)IBOutlet UILabel *manhourslabel;


/*xmlParser*/
@property(strong,nonatomic)NSMutableData *webData;
@property(strong,nonatomic)NSMutableString *soapresults;
@property(strong,nonatomic)NSXMLParser *xmlparser;

-(IBAction)addplan:(id)sender;


/*arrays and Dicts*/
@property(strong,nonatomic)NSMutableArray *scaffoldingplanlistarray;
@end
