//
//  MangmntdetailsViewController.h
//  Newproject
//
//  Created by GMSIndia1 on 4/3/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subcontract.h"

@interface MangmntdetailsViewController : UIViewController




@property(strong,nonatomic)NSMutableArray *detailsarray;
@property(strong,nonatomic)subcontract *subcntrct;
/*tabbarbuttons*/
- (IBAction)paymntbtn:(id)sender;
- (IBAction)volumebtn:(id)sender;
- (IBAction)laborbtn:(id)sender;
- (IBAction)equpbtn:(id)sender;
- (IBAction)othrtermsbtn:(id)sender;
- (IBAction)markupbtn:(id)sender;
- (IBAction)basebtn:(id)sender;
- (IBAction)fuelbtn:(id)sender;
- (IBAction)nonfuelbtn:(id)sender;
- (IBAction)SMRbtn:(id)sender;
- (IBAction)Orbtn:(id)sender;
- (IBAction)deliveryratebtn:(id)sender;
- (IBAction)srsbtn:(id)sender;
- (IBAction)docubtn:(id)sender;





/*payment*/

@property (strong, nonatomic) IBOutlet UIView *paymentview;
@property (strong, nonatomic) IBOutlet UITextView *clausetxtview;
@property (strong, nonatomic) IBOutlet UITextField *nettextfld;

/*volume*/
@property (strong, nonatomic) IBOutlet UIView *volumeview;
@property (strong, nonatomic) IBOutlet UITextView *vlumeclautxtview;
@property (strong, nonatomic) IBOutlet UITableView *vlumetable;
@property (strong, nonatomic) IBOutlet UIView *volumetitle;

/*labor*/

@property (strong, nonatomic) IBOutlet UIView *labrview;
@property (strong, nonatomic) IBOutlet UITextView *lbrclaustxtview;
@property (strong, nonatomic) IBOutlet UITextField *weekhrstxtfld;
@property (strong, nonatomic) IBOutlet UITextField *subcntrctbtn;
@property (strong, nonatomic) IBOutlet UIButton *overtimechecklbl;
@property (strong, nonatomic) IBOutlet UIButton *minimumchecklbl;
@property (strong, nonatomic) IBOutlet UIButton *holidayschecklbl;

- (IBAction)overcheckbtn:(id)sender;
- (IBAction)minimumhrsbtn:(id)sender;
- (IBAction)holidaysbtn:(id)sender;

/*Equipment View*/
@property (strong, nonatomic) IBOutlet UIView *equpview;

@property (strong, nonatomic) IBOutlet UITextView *equpclause;
@property (strong, nonatomic) IBOutlet UITableView *cfetable;
@property (strong, nonatomic) IBOutlet UITableView *tretable;
@property (strong, nonatomic) IBOutlet UIButton *thirdequbtnlbl;
@property (strong, nonatomic) IBOutlet UIButton *conequpbtnlbl;

- (IBAction)conequpbtn:(id)sender;
- (IBAction)thirdequpbtn:(id)sender;

/*Otherterms view*/
@property (strong, nonatomic) IBOutlet UIView *othrtrmsview;
@property (strong, nonatomic) IBOutlet UITextView *othrtermsclause;

@property (strong, nonatomic) IBOutlet UIButton *swpbtn;
@property (strong, nonatomic) IBOutlet UIButton *consumblebtn;
@property (strong, nonatomic) IBOutlet UIButton *smalltoolbillingbtn;

- (IBAction)shopcheckbtn:(id)sender;
- (IBAction)consublebtn:(id)sender;
- (IBAction)smalltoolbtn:(id)sender;

/*markup view*/


@property (strong, nonatomic) IBOutlet UIView *markupview;
@property (strong, nonatomic) IBOutlet UIButton *markupbtnlbl;
@property (strong, nonatomic) IBOutlet UITextField *overtimetextfield;
@property (strong, nonatomic) IBOutlet UITextField *premiumtimetxtfld;
- (IBAction)selectmarkupbtn:(id)sender;
/*base view */
@property (strong, nonatomic) IBOutlet UIView *baseview;
@property (strong, nonatomic) IBOutlet UIView *basetitle;
@property (strong, nonatomic) IBOutlet UITableView *basetable;
/*fuel view*/
@property (strong, nonatomic) IBOutlet UIView *fuelview;
@property (strong, nonatomic) IBOutlet UIView *fueltitle;
@property (strong, nonatomic) IBOutlet UITableView *fueltable;

/*non fuel view*/
@property (strong, nonatomic) IBOutlet UIView *nonfuelview;

@property (strong, nonatomic) IBOutlet UIView *nonfueltitle;

@property (strong, nonatomic) IBOutlet UITableView *nonfueltable;

/*smrview */
@property (strong, nonatomic) IBOutlet UIView *smrview;
@property (strong, nonatomic) IBOutlet UIView *smrtitle;

@property (strong, nonatomic) IBOutlet UITableView *smrtable;

/*other rates */

@property (strong, nonatomic) IBOutlet UIView *othrratesview;
@property (strong, nonatomic) IBOutlet UITextField *temtxtfld;
@property (strong, nonatomic) IBOutlet UITextField *leasemarkuptxtfld;
@property (strong, nonatomic) IBOutlet UITextField *rentalmarkuptxtfld;
@property (strong, nonatomic) IBOutlet UITextField *materialpurchasetxtfld;

/*delivery rate*/
@property (strong, nonatomic) IBOutlet UIView *deliveryview;
@property (strong, nonatomic) IBOutlet UITextView *deliveryclausetxtview;
/*srs view*/
@property (strong, nonatomic) IBOutlet UIView *srsview;
@property (strong, nonatomic) IBOutlet UITextView *srstxtview;
/*documnt view */
@property (strong, nonatomic) IBOutlet UIView *doctitle;
@property (strong, nonatomic) IBOutlet UITableView *docutable;

@property (strong, nonatomic) IBOutlet UIView *docuview;

- (IBAction)clsebtn:(id)sender;


@end