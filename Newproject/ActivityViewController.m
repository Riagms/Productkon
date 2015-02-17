//
//  ActivityViewController.m
//  Newproject
//
//  Created by GMSIndia1 on 6/17/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=NSLocalizedString(@"Activity", @"Activity");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    self.scroll.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    _newviewactivity.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    _composecmtview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    [[self.descptionTextview layer] setBorderColor:[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor];
    [[self.descptionTextview layer] setBorderWidth:2];
    [[self.descptionTextview layer] setCornerRadius:10];

    self.openviewindex=NSNotFound;
    _SearchingBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    _SearchingBar.delegate = (id)self;
    _SearchingBar.tintColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    //searchBar.tintColor=[UIColor cyanColor];
    self.activityTable.tableHeaderView =_SearchingBar;
    
    UISearchDisplayController* searchController = [[UISearchDisplayController alloc] initWithSearchBar:_SearchingBar contentsController:self];
    searchController.searchResultsDataSource = (id)self;
    searchController.searchResultsDelegate =(id)self;
    searchController.delegate = (id)self;

    NSDate*date1=[NSDate date];
    NSLog(@"%@",date1);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString*curntdate = [dateFormat stringFromDate:date1];
 NSLog(@"%@",curntdate);
    NSLog(@"%d",_leadid);
    _scroll.frame=CGRectMake(0, 0, 1024,708);
    [_scroll setContentSize:CGSizeMake(1024,760)];
    _activityTable.layer.borderWidth = 2.0;
    _activityTable.layer.borderColor = [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor;
//    _activityTable.separatorColor= [UIColor colorWithRed:219.0/255.0f green:236.0/255.0f blue:244.0/255.0f alpha:1.0f];
self.navigationController.navigationBar.tintColor=[UIColor blackColor];
   // self.newviewactivity.hidden=YES;
     _view2.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
//    _activityNav.tintColor= [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
   _btnArray=[[NSMutableArray alloc]initWithObjects:@"New Activity",@"Edit Activity",@"Delete Activity" ,nil];
    _popoverArray=[[NSMutableArray alloc]initWithObjects:@"Comments",nil];
    self.navigationController.navigationBar.tintColor=[UIColor grayColor];
   // _activitytypeArray=[[NSMutableArray alloc]initWithObjects:@"Email Follow UP",@"Phone Follow UP",@"Launch Appointment",@"Golf Game", nil];
    [[self.cmttxtbox layer] setBorderColor:[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor];
    [[self.cmttxtbox layer] setBorderWidth:2];
    [[self.cmttxtbox layer] setCornerRadius:10];
    _cmttable.layer.borderWidth = 2.0;
    _cmttable.layer.borderColor = [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor;
    _disclosurearray=[[NSMutableArray alloc]initWithObjects:@"Comments", nil];

       // Do any additional setup after loading the view from its nib.
    
   
}
-(void)viewWillAppear:(BOOL)animated{
    self.openviewindex=NSNotFound;
    [super viewWillAppear:animated];
   
    [self Employeeselect];
     [self getLeadActivity];
        _savebtnlbl.enabled=YES;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (tableView==_popOverTableView) {
        
        if (poptype==1) {
            
        
                
                return [_folloarray count];
        }
        else if (poptype==13){
            return [_empdict count];
        }
        else
        {
            return [_disclosurearray count];
        }
        

       
        
    }
    if (tableView==_activityTable)
    {
    return [_activityArray count];
    }
    if(tableView==_cmttable)
    {
        return [_cmntarray count];
    }
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (tableView==_activityTable) {

        [[NSBundle mainBundle]loadNibNamed:@"ActivityCustomCell" owner:self options:nil];
        cell=_actvityCell;
        }
        if (tableView==_cmttable) {
            [[NSBundle mainBundle]loadNibNamed:@"customcommentforactivitycell" owner:self options:nil];
            
            cell=_cmtcell;
            [self.cmttable.layer setBorderColor:[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor];
        }

        
    }
    //cell.textLabel.text=@"Leads";
      if (tableView==_popOverTableView) {
          
          if (poptype==1) {
              
           Craftreqmtmdl*submdl=(Craftreqmtmdl *)[_folloarray objectAtIndex:indexPath.row];
         
          cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
          cell.textLabel.font = [UIFont systemFontOfSize:12.0];
          
          cell.textLabel.text=submdl.Brdescriptn;
          }
          
          
            else if (poptype==13) {
                  
                  cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
                  cell.textLabel.font = [UIFont systemFontOfSize:12.0];
                NSArray*values=[_empdict allValues];
                NSArray*keys=[_empdict allKeys];
                
                  
               cell.textLabel.text=[NSString stringWithFormat:@"%@-%@",[values objectAtIndex:indexPath.row],[keys objectAtIndex:indexPath.row]];

                
              }
              else{
                  cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
                  cell.textLabel.font = [UIFont systemFontOfSize:12.0];
                  
                  cell.textLabel.text=[_disclosurearray objectAtIndex:indexPath.row];
                  
              }


          
      }
    if(tableView==_activityTable)
    {
        activityInfo*info=(activityInfo*)[_activityArray objectAtIndex:indexPath.row];
        _activityname=(UILabel*)[cell viewWithTag:1];
        _activityname.text=info.activity;
        
        _datetext=(UILabel*)[cell viewWithTag:2];
        NSArray *dateArray=[[NSArray alloc]init];
        dateArray=[info.datest componentsSeparatedByString:@"T"];
        NSString *date1 =[dateArray objectAtIndex:0];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *dates = [dateFormat dateFromString:date1];
        [dateFormat setDateFormat:@"MM/dd/yyyy"];
        NSString *myFormattedDate = [dateFormat stringFromDate:dates];
        
        _datetext.text=myFormattedDate;
        
        _employee=(UILabel*)[cell viewWithTag:3];
        _employee.text=info.ename;
        
        _detailslbl=(UILabel*)[cell viewWithTag:4];
        _detailslbl.text=info.actdesion;
        
        _status=(UILabel*)[cell viewWithTag:5];
        _status.text=info.status;
//        carbtn=[UIButton buttonWithType:UIButtonTypeCustom];
//        [carbtn setImage:[UIImage imageNamed:@"carat"] forState:UIControlStateNormal];
//        carbtn.tag=indexPath.row;
//        [carbtn addTarget:self action:@selector(showactions:) forControlEvents:UIControlEventTouchUpInside];
//        carbtn.frame = CGRectMake(270.0, 1.0, 50.0, 40.0);
//        [cell.contentView addSubview:carbtn];

    }
    if (tableView==_cmttable) {
        commentmdl*cmtmdl=(commentmdl *)[_cmntarray  objectAtIndex:indexPath.row];
        
        _commentcellview=(UITextView*)[cell viewWithTag:1];
//        [[self.commentcellview layer] setBorderColor:[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor];
//        [[self.commentcellview layer] setBorderWidth:2];
//        [[self.commentcellview layer] setCornerRadius:10];
        _commentcellview.text=cmtmdl.comments;
        _titilelbl=(UILabel*)[cell viewWithTag:2];
        _titilelbl.text=cmtmdl.commentdate;
        
    }
    return cell;
    
    
}

//-(void)showactions:(UIButton*)sender{
//    // [_animatedview removeFromSuperview];
//    _commentlabel.hidden=YES;
//    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{ _animatedview
//        .frame =  CGRectMake(300, 10, 0, 0);} completion:nil];
//    
//    _animatedview.hidden=YES;
//    //Empmdl *empmdl=(Empmdl *)[_employeelistarray objectAtIndex:sender.tag];
//    
//    
//    
//    
//      button = (UIButton *)sender;
//    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
//    CGPoint center= button.center;
//    CGPoint rootViewPoint = [button.superview convertPoint:center toView:self.activityTable];
//    NSIndexPath *textFieldIndexPath = [self.activityTable indexPathForRowAtPoint:rootViewPoint];
//    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
//    btnindex=textFieldIndexPath.row;
//    
//    
//    
//    //create uiview
//    _animatedview=[[UIView alloc]initWithFrame:CGRectMake(300, 10, 0, 25)];
//    _animatedview.backgroundColor=[UIColor colorWithRed:99.0/255.0f green:184.0/255.0f blue:255.0/255.0f alpha:1.0f];
//    _commentlabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 25)];
//    _commentlabel.font = [UIFont fontWithName:@"Helvetica Neue" size:12];
//    _commentlabel.textColor=[UIColor blackColor];
//    _commentlabel.text=@"Comments";
//    [self.animatedview addSubview:_commentlabel];
//    
//    _commentlabel.hidden=YES;
//    
//    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentpopover)];
//    [self.animatedview addGestureRecognizer:tap];
//   [cell addSubview:_animatedview];
//    
//    _animatedview.hidden=NO;
//    [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{ _animatedview
//        .frame =  CGRectMake(300, 10, 70, 25);} completion:nil];
//    
//    _commentlabel.hidden=NO;
////    NSLog(@"%@",empmdl.badgeflag);
////    if ([empmdl.badgeflag isEqualToString:@"true"]) {
////        //_badgelbl.enabled=NO;
////        _animatedview.userInteractionEnabled=NO;
////        //_animatedview.
////        
////    }
//    
//    [self showviewWithUserAction:YES];
//}
//
//-(void)showviewWithUserAction:(BOOL)userAction{
//    
//    // Toggle the disclosure button state.
//    
//    carbtn.selected = !carbtn.selected;
//    
//    if (userAction) {
//        if (carbtn.selected) {
//            _animatedview.hidden=NO;
//            [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{ _animatedview
//                .frame =  CGRectMake(300, 10, 70, 25);} completion:nil];
//            [self viewopened:btnindex];
//            _commentlabel.hidden=NO;
//            
//            
//            
//        }
//        else{
//            [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{ _animatedview
//                .frame =  CGRectMake(300, 10, 70, 25);} completion:nil];
//            [self viewclosed:btnindex];
//            //_venderlbl.hidden=YES;
//            
//        }
//        
//        
//    }
//}
//-(void)viewopened:(NSInteger)viewopened{
//    
//    
//    selectedcell=viewopened;
//    NSInteger previousOpenviewIndex = self.openviewindex;
//    
//    if (previousOpenviewIndex != NSNotFound) {
//        [UIView animateWithDuration:0.5f delay:0.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{  _animatedview
//            .frame =  CGRectMake(300, 10, 0, 0);} completion:nil];
//        
//        _animatedview.hidden=YES;
//        
//        
//        // }
//        
//        
//    }
//    
//    self.openviewindex=viewopened;
//    
//    
//    
//    
//    
//    
//}
//-(void)viewclosed:(NSInteger)viewclosed
//{
//    
//    viewclosed=btnindex;
//    _animatedview.hidden=YES;
//    self.openviewindex = NSNotFound;
//    
//    
//}

#pragma mark - Table View delegate
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //alternating cell back ground color
    if(tableView==_activityTable)
    {
    if (indexPath.row%2 == 0) {
        [cell setBackgroundColor:[UIColor whiteColor]];
    }else
    {
        
        //[cell setBackgroundColor:[UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0f]];
        
        [cell setBackgroundColor: [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f]];

            }
    }
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView==_activityTable)
    {
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
       path =indexPath.row;
        
       
        [self UserLogActivitydelete];
        [self deleteActivity];
        
        [_activityArray removeObject:indexPath];
        
        
        
        
        
    }
    }
    }
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_cmttable||tableView==_popOverTableView)
        
    {
        return self.editing ;
    }
    return YES;

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_popOverTableView) {
        if (poptype==1) {
            
        
         Craftreqmtmdl*submdl=(Craftreqmtmdl *)[_folloarray objectAtIndex:indexPath.row];
        [_activityTypeBtn setTitle:submdl.Brdescriptn forState:UIControlStateNormal];
            [self.popOverController dismissPopoverAnimated:YES];
             }
        else if (poptype==2)
        {
            [self.popOverController dismissPopoverAnimated:YES];
            [self UserLogCommentview];
            [self commentpopover];
        }
        else if (poptype==13)
        {
            NSArray*values=[_empdict allValues];
            NSArray*keys=[_empdict allKeys];
              NSString*name=[NSString stringWithFormat:@"%@-%@",[values objectAtIndex:indexPath.row],[keys objectAtIndex:indexPath.row]];
              [_empbtnlbl setTitle:name forState:UIControlStateNormal];
            [self.popOverController dismissPopoverAnimated:YES];
       
        }
        
        
        
       
        
        
    
    }
  //[self.popOverController dismissPopoverAnimated:YES];
    
    
    }

- (IBAction)Addcmtbtn:(id)sender {
  
    _composecmtview.backgroundColor= [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
     _savebtnlbl.enabled=YES;
    _composecmtview.hidden=NO;
    
        
}
-(IBAction)selectActivityType:(id)sender
{     poptype=1;

    [self createPopover];
    [self FollowuptypeSelect];
}

-(void)createPopover
{
    
    poptype=1;
       UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 239, 200)];
    
    popoverView.backgroundColor = [UIColor lightTextColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 239, 200)];
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
   
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(239, 200);
    
    //create a popover controller
    self.popOverController = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    self.popOverController.popoverContentSize=CGSizeMake(239.0f, 200.0f);
    self.popOverController=_popOverController;

    [self.popOverController presentPopoverFromRect:_activityTypeBtn.frame
                                            inView:_newviewactivity
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    
    
    
}



#pragma mark - Calendar
-(void)createCalenderPopover
{
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 315, 330)];
    
    popoverView.backgroundColor = [UIColor lightTextColor];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(315, 330);
    
    CKCalendarView *calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    
    NSDate *date = [NSDate date];
    
    // format it
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MM/YYYY"];
    
    // convert it to a string
    NSString *dateString = [dateFormat stringFromDate:date];
    //NSLog(@"datestring%@",dateString);
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    calendar.selectedDate = [self.dateFormatter dateFromString:dateString];
    
    calendar.minimumDate = [self.dateFormatter dateFromString:@"09/07/2011"];
    calendar.maximumDate = [self.dateFormatter dateFromString:@"1/07/2050"];
    calendar.shouldFillCalendar = YES;
    calendar.adaptHeightToNumberOfWeeksInMonth = NO;
    
    calendar.frame = CGRectMake(10, 10, 300, 320);
    [popoverView addSubview:calendar];
    
       
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(localeDidChange) name:NSCurrentLocaleDidChangeNotification object:nil];
    
    
    //create a popover controller
    self.popOverController = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    self.popOverController.popoverContentSize=CGSizeMake(320.0f, 335.0f);
    self.popOverController=_popOverController;

    [self.popOverController presentPopoverFromRect:_dateBtn.frame
                                            inView:self.newviewactivity
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    
}
  


- (void)localeDidChange {
    [self.calendar setLocale:[NSLocale currentLocale]];
}



#pragma mark - CKCalendarDelegate

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    [_dateBtn setTitle:dateString forState:UIControlStateNormal];
      [self.popOverController dismissPopoverAnimated:YES];
}



#pragma mark - Buttons

-(IBAction)addNewActivity:(id)sender
{
    [self FollowuptypeSelect];
      [self Employeeselect];
    _updatebtnlbl.enabled=YES;
    self.openviewindex=NSNotFound;
    _activityTable.userInteractionEnabled=NO;
    _cancelbtnlbl.enabled=YES;
    butnidtfr=1;
    [_dateBtn setTitle:@"Select" forState:UIControlStateNormal];
    [_activityTypeBtn setTitle:@"Select" forState:UIControlStateNormal];
    [_empbtnlbl setTitle:@"Select" forState:UIControlStateNormal];
    
     self.activityNav.title = @"Create";
    _employerTxtfld.text=@"";
    
    _statusTxtFld.text=@"";
    
    _descptionTextview.text=@"";
    _activityTxtFld.text=@"";
    _dateBtn.backgroundColor=nil;
    _activityTxtFld.backgroundColor=nil;
    _employerTxtfld.backgroundColor=nil;
    
    _newviewactivity.hidden=NO;
//    //_view2.hidden=NO;
//    _newviewactivity.frame = CGRectMake(510, 346, 0, 0);
//    //    CGPoint origin = _hidenview.frame.origin;
//    [UIView animateWithDuration: 1.0f animations:^{
//        _newviewactivity.frame = CGRectMake(195, 100, 663, 492);
//        //        _hidenview.center = origin;
//        _newviewactivity.alpha = 1.0;
//        
//    }];

}
-(IBAction)closetheView:(id)sender
{ [self getLeadActivity];
    self.openviewindex=NSNotFound;
    _dateBtn.enabled=YES;
    _activityTxtFld.userInteractionEnabled=YES;
    _employerTxtfld.userInteractionEnabled=YES;

    [_dateBtn setTitle:@"Select" forState:UIControlStateNormal];
    
       _employerTxtfld.text=@"";
    
    _statusTxtFld.text=@"";
    _activityTable.userInteractionEnabled=YES;
    
    _descptionTextview.text=@"";
    _activityTxtFld.text=@"";
    [_activityTypeBtn setTitle:@"Select" forState:UIControlStateNormal];

   butnidtfr=0;
    self.newviewactivity.hidden=YES;
//    _newviewactivity.frame = CGRectMake(195, 60, 663, 492);
//    //    CGPoint origin = _hidenview.frame.origin;
//    [UIView animateWithDuration: 1.0f animations:^{
//        _newviewactivity.frame = CGRectMake(510, 346, 0, 0);
//        //        _hidenview.center = origin;
//        _newviewactivity.alpha = 0;
//        
//    }];

}



-(IBAction)selectDate:(id)sender
{
    [self createCalenderPopover];
}



- (IBAction)editcellbtn:(id)sender
{
    [self FollowuptypeSelect];
      [self Employeeselect];
    _updatebtnlbl.enabled=YES;
    butnidtfr=2;
    self.activityNav.title = @"Edit";
    _cancelbtnlbl.enabled=NO;
    [_cancelbtnlbl setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];

    _activityTable.userInteractionEnabled=NO;
    _newviewactivity.hidden=NO;

//    _newviewactivity.frame = CGRectMake(510, 346, 0, 0);
//    //    CGPoint origin = _hidenview.frame.origin;
//    [UIView animateWithDuration: 1.0f animations:^{
//        _newviewactivity.frame = CGRectMake(195, 100, 663, 492);
//        //        _hidenview.center = origin;
//        _newviewactivity.alpha = 1.0;
//        
//    }];
    button = (UIButton *)sender;
    CGPoint center= button.center;
    CGPoint rootViewPoint = [button.superview convertPoint:center toView:self.activityTable];
    NSIndexPath *textFieldIndexPath = [self.activityTable indexPathForRowAtPoint:rootViewPoint];
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
    btnindex=textFieldIndexPath.row;
    NSLog(@"indexpath%d",btnindex);
    activityInfo*info1=(activityInfo*)[_activityArray objectAtIndex:btnindex];
    
    NSArray *dateArray=[[NSArray alloc]init];
    dateArray=[info1.datest componentsSeparatedByString:@"T"];
    NSString *date1 =[dateArray objectAtIndex:0];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *dates = [dateFormat dateFromString:date1];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSString *myFormattedDate = [dateFormat stringFromDate:dates];
    
    
    

   [_dateBtn setTitle:myFormattedDate forState:UIControlStateNormal];
    _employerTxtfld.text=info1.employer;
    _statusTxtFld.text=info1.status;
    _activityTxtFld.text=info1.activity;
    _descptionTextview.text=info1.actdesion;
    _dateBtn.enabled=NO;
    _dateBtn.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    _activityTxtFld.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
   _employerTxtfld.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];

    _activityTxtFld.userInteractionEnabled=NO;
    _employerTxtfld.userInteractionEnabled=NO;
    [_activityTypeBtn setTitle:info1.communicationtype forState:UIControlStateNormal];
    NSLog(@"%@",info1.employer);
     [_empbtnlbl setTitle:[NSString stringWithFormat:@"%@-%@",info1.employer,info1.ename] forState:UIControlStateNormal];

}
-(IBAction)cancelaction:(id)sender
{
    [_dateBtn setTitle:@"Select" forState:UIControlStateNormal];
     [_activityTypeBtn setTitle:@"Select" forState:UIControlStateNormal];
    
    
    _employerTxtfld.text=@"";
    
    _statusTxtFld.text=@"";
    
    _descptionTextview.text=@"";
    _activityTxtFld.text=@"";
 
}
-(IBAction)deleteActivity:(id)sender
{
    if ([self.activityTable isEditing]) {
        // If the tableView is already in edit mode, turn it off. Also change the title of the button to reflect the intended verb (‘Edit’, in this case).
        
        [self.activityTable setEditing:NO animated:YES];
        //[_Editbtn setTitle:@"Edit"forState:UIControlStateNormal];
    }
    else {
        // [_Editbtn setTitle:@"Done"forState:UIControlStateNormal];
        
        // Turn on edit mode
        
        [self.activityTable setEditing:YES animated:YES];
    }

}
- (IBAction)closeactivity:(id)sender
{
    self.openviewindex=NSNotFound;
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark-webservices

-(void)getLeadActivity
{
    recordResults = FALSE;
    NSString *soapMessage;
    NSLog(@"%d",_leadid);
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   "<soap:Body>\n"
                    "<GetLeadActivity xmlns=\"https://vip.kontract360.com/\">\n"
                   "<Id>%d</Id>\n"
                   "</GetLeadActivity>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_leadid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/GetLeadActivity" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
 
}
-(void)FollowuptypeSelect{
    recordResults = FALSE;
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<FollowuptypeSelect xmlns=\"https://vip.kontract360.com/\">\n"
                   "</FollowuptypeSelect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    //   NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/FollowuptypeSelect" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}

-(void)getcomments
{
    recordResults = FALSE;
    NSString *soapMessage;
    activityInfo*info=(activityInfo*)[_activityArray objectAtIndex:btnindex];
    NSLog(@"%d",info.activityId);
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<ActivityCommentsList xmlns=\"https://vip.kontract360.com/\">\n"
                   "<activityid>%d</activityid>\n"
                   
                   "</ActivityCommentsList>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",info.activityId];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
       NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/ActivityCommentsList" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
    

}
-(void)saveActivity
{
    webtype=1;
    recordResults = FALSE;
    NSString *soapMessage;
    NSLog(@"%d",_leadid);
    NSInteger activityId=0;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"MM/dd/yyyy"];
    
    NSDate *dateString = [dateFormat dateFromString:_dateBtn.titleLabel.text];
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString* sqldate=[dateFormat1 stringFromDate:dateString];

    NSArray*newarray=[_empbtnlbl.titleLabel.text componentsSeparatedByString:@"-"];
    NSString *idvalue=[_empdict objectForKey:[newarray objectAtIndex:1]];
    NSLog(@"%@",idvalue);
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   "<soap:Body>\n"
                   "<SaveActivity xmlns=\"https://vip.kontract360.com/\">\n"
                   "<LeadId>%d</LeadId>\n"
                   "<Date>%@</Date>\n"
                   "<Activity>%@</Activity>\n"
                   "<Employer>%d</Employer>\n"
                   "<Description>%@</Description>\n"
                   "<Status>%@</Status>\n"
                   "<activityid>%d</activityid>\n"
                   "<CommunicationType>%@</CommunicationType>"
                   "</SaveActivity>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_leadid,sqldate,_activityTxtFld.text,[idvalue integerValue],_descptionTextview.text,_statusTxtFld.text,activityId,[_followdict objectForKey:_activityTypeBtn.titleLabel.text]];
    NSLog(@"soapmsg%@",soapMessage);

    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
       NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"https://vip.kontract360.com/SaveActivity" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    

}
-(void)updateActivity
{ webtype=1;
    recordResults = FALSE;
    NSString *soapMessage;
    NSLog(@"%d",_leadid);
    activityInfo*info2=(activityInfo*)[_activityArray objectAtIndex:btnindex];
    NSLog(@"%@",info2.LeadId);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"MM-dd-yyyy"];
      NSLog(@"%@",_dateBtn.titleLabel.text);
    
    NSDate *dateString = [dateFormat dateFromString:_dateBtn.titleLabel.text];
      NSLog(@"%@",dateString);
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString* sqldate=[dateFormat1 stringFromDate:dateString];
      NSArray*newarray=[_empbtnlbl.titleLabel.text componentsSeparatedByString:@"-"];
 NSString *idvalue=[_empdict objectForKey:[newarray objectAtIndex:1]];
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   "<soap:Body>\n"
                   "<UpdateLeadActivity xmlns=\"https://vip.kontract360.com/\">\n"
                   "<ActivityId>%d</ActivityId>\n"
                   "<LeadId>%d</LeadId>\n"
                   "<Date>%@</Date>\n"
                   "<Activity>%@</Activity>\n"
                   "<Employer>%d</Employer>\n"
                   "<Description>%@</Description>\n"
                   "<Status>%@</Status>\n"
                   "<CommunicationType>%@</CommunicationType>\n"
                   "</UpdateLeadActivity>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",info2.activityId,_leadid,sqldate,_activityTxtFld.text,[idvalue integerValue],_descptionTextview.text,_statusTxtFld.text,[_followdict objectForKey:_activityTypeBtn.titleLabel.text]];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
       NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UpdateLeadActivity" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
    
 
}
-(void)deleteActivity
{
    webtype=2;
    recordResults = FALSE;
    NSString *soapMessage;
     activityInfo*info2=(activityInfo*)[_activityArray objectAtIndex:path];
    NSLog(@"%d",info2.activityId);
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   "<soap:Body>\n"
                    "<DeleteActivity xmlns=\"https://vip.kontract360.com/\">\n"
                   "<activityid>%d</activityid>\n"
                   "</DeleteActivity>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",info2.activityId];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
       NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/DeleteActivity" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
    

}
-(void)saveComment
{
    
    recordResults = FALSE;
    NSString *soapMessage;
    NSDate*curntdate=[NSDate date];
    NSLog(@"%@",curntdate);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"HH:mm:ss a"];
    NSLog(@"curntdate%@",[dateFormat stringFromDate:curntdate]);
    NSString*time=[dateFormat stringFromDate:curntdate];
    [dateFormat setDateFormat:@"MM/dd/ yyyy"];
    NSString*date1=[dateFormat stringFromDate:curntdate];
    NSString*today=[NSString stringWithFormat:@"%@ %@",date1,time];
    
    NSString*newstrg=  [_cmttxtbox.text stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    newstrg=  [newstrg stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    newstrg=  [newstrg stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    newstrg=  [newstrg stringByReplacingOccurrencesOfString:@"'" withString:@"&#39;"];
      
    NSInteger userid=100;
    activityInfo*info=(activityInfo*)[_activityArray objectAtIndex:btnindex];

    
       soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   "<soap:Body>\n"
                   "<SaveActivityComment xmlns=\"https://vip.kontract360.com/\">\n"
                      "<ActivityId>%d</ActivityId>\n"
                      "<Comments>%@</Comments>\n"
                      "<UserId>%d</UserId>\n"
                      "<CommentDate>%@</CommentDate>\n"
                   "</SaveActivityComment>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",info.activityId,newstrg,userid,today];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
       NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/SaveActivityComment" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
 
}
-(void)SearchLeadActivity{
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SearchLeadActivity xmlns=\"https://vip.kontract360.com/\">\n"
                   "<searchtext>%@</searchtext>\n"
                   "<LeadId>%d</LeadId>\n"
                   "</SearchLeadActivity>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_searchstring,_leadid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue:@"https://vip.kontract360.com/SearchLeadActivity" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
    
    
}
-(void)Employeeselect
{
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<Employeeselect xmlns=\"https://vip.kontract360.com/\">\n"
                   "</Employeeselect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    //   NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/Employeeselect" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}
-(void)UserLogActivityinsert{
    
    recordResults = FALSE;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSLog(@"Date %@",[formatter stringFromDate:date]);
    NSString*curntdate=[formatter stringFromDate:date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString*useridname = [defaults objectForKey:@"Userid"];
    NSString*extnalip=[defaults objectForKey:@"Externalip"];
    NSString*intrnalip=[defaults objectForKey:@"Internalip"];
    NSString*Udid=[defaults objectForKey:@"UDID"];
    
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UserLogmaininsert xmlns=\"https://vip.kontract360.com/\">\n"
                   "<dateandtime>%@</dateandtime>\n"
                   "<userid>%d</userid>\n"
                   "<moduleid>%d</moduleid>\n"
                   "<Action>%@</Action>\n"
                   "<platform>%@</platform>\n"
                   "<externalip>%@</externalip>\n"
                   "<internalip>%@</internalip>\n"
                   "<devicenumber>%@</devicenumber>\n"
                   "<documentId>%d</documentId>\n"
                   "</UserLogmaininsert>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],_moduleid,@"Create",@"iOS",extnalip,intrnalip,Udid,0];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    //   NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UserLogmaininsert" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}
-(void)Userlogactivityupdate{
    
    recordResults = FALSE;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSLog(@"Date %@",[formatter stringFromDate:date]);
    NSString*curntdate=[formatter stringFromDate:date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString*useridname = [defaults objectForKey:@"Userid"];
    NSString*extnalip=[defaults objectForKey:@"Externalip"];
    NSString*intrnalip=[defaults objectForKey:@"Internalip"];
    NSString*Udid=[defaults objectForKey:@"UDID"];
    
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UserLogmaininsert xmlns=\"https://vip.kontract360.com/\">\n"
                   "<dateandtime>%@</dateandtime>\n"
                   "<userid>%d</userid>\n"
                   "<moduleid>%d</moduleid>\n"
                   "<Action>%@</Action>\n"
                   "<platform>%@</platform>\n"
                   "<externalip>%@</externalip>\n"
                   "<internalip>%@</internalip>\n"
                   "<devicenumber>%@</devicenumber>\n"
                   "<documentId>%d</documentId>\n"
                   "</UserLogmaininsert>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],_moduleid,@"Edit",@"iOS",extnalip,intrnalip,Udid,0];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    //   NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UserLogmaininsert" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}
-(void)UserLogActivitydelete{
    
    recordResults = FALSE;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSLog(@"Date %@",[formatter stringFromDate:date]);
    NSString*curntdate=[formatter stringFromDate:date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString*useridname = [defaults objectForKey:@"Userid"];
    NSString*extnalip=[defaults objectForKey:@"Externalip"];
    NSString*intrnalip=[defaults objectForKey:@"Internalip"];
    NSString*Udid=[defaults objectForKey:@"UDID"];
    
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UserLogmaininsert xmlns=\"https://vip.kontract360.com/\">\n"
                   "<dateandtime>%@</dateandtime>\n"
                   "<userid>%d</userid>\n"
                   "<moduleid>%d</moduleid>\n"
                   "<Action>%@</Action>\n"
                   "<platform>%@</platform>\n"
                   "<externalip>%@</externalip>\n"
                   "<internalip>%@</internalip>\n"
                   "<devicenumber>%@</devicenumber>\n"
                   "<documentId>%d</documentId>\n"
                   "</UserLogmaininsert>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],_moduleid,@"Delete",@"iOS",extnalip,intrnalip,Udid,0];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    //   NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UserLogmaininsert" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}


-(void)UserLogCommentview{
    
    recordResults = FALSE;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSLog(@"Date %@",[formatter stringFromDate:date]);
    NSString*curntdate=[formatter stringFromDate:date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString*useridname = [defaults objectForKey:@"Userid"];
    NSString*extnalip=[defaults objectForKey:@"Externalip"];
    NSString*intrnalip=[defaults objectForKey:@"Internalip"];
    NSString*Udid=[defaults objectForKey:@"UDID"];
    
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UserLogmaininsert xmlns=\"https://vip.kontract360.com/\">\n"
                   "<dateandtime>%@</dateandtime>\n"
                   "<userid>%d</userid>\n"
                   "<moduleid>%d</moduleid>\n"
                   "<Action>%@</Action>\n"
                   "<platform>%@</platform>\n"
                   "<externalip>%@</externalip>\n"
                   "<internalip>%@</internalip>\n"
                   "<devicenumber>%@</devicenumber>\n"
                   "<documentId>%d</documentId>\n"
                   "</UserLogmaininsert>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],_moduleid,@"ViewComnt",@"iOS",extnalip,intrnalip,Udid,0];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    //   NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UserLogmaininsert" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}
-(void)UserLogsavecomments{
    
    recordResults = FALSE;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // NSLog(@"Date %@",[formatter stringFromDate:date]);
    NSString*curntdate=[formatter stringFromDate:date];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString*useridname = [defaults objectForKey:@"Userid"];
    NSString*extnalip=[defaults objectForKey:@"Externalip"];
    NSString*intrnalip=[defaults objectForKey:@"Internalip"];
    NSString*Udid=[defaults objectForKey:@"UDID"];
    
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UserLogmaininsert xmlns=\"https://vip.kontract360.com/\">\n"
                   "<dateandtime>%@</dateandtime>\n"
                   "<userid>%d</userid>\n"
                   "<moduleid>%d</moduleid>\n"
                   "<Action>%@</Action>\n"
                   "<platform>%@</platform>\n"
                   "<externalip>%@</externalip>\n"
                   "<internalip>%@</internalip>\n"
                   "<devicenumber>%@</devicenumber>\n"
                   "<documentId>%d</documentId>\n"
                   "</UserLogmaininsert>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],_moduleid,@"SaveComnt",@"iOS",extnalip,intrnalip,Udid,0];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    //   NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UserLogmaininsert" forHTTPHeaderField:@"Soapaction"];
    
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    if( theConnection )
    {
        _webData = [NSMutableData data];
    }
    else
    {
        ////NSLog(@"theConnection is NULL");
    }
    
}


#pragma mark-Connection
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[_webData setLength: 0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
   	[_webData appendData:data];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *  Alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please Check Your Connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [Alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"DONE. Received Bytes: %d", [_webData length]);
	NSString *theXML = [[NSString alloc] initWithBytes: [_webData mutableBytes] length:[_webData length] encoding:NSUTF8StringEncoding];
	NSLog(@"xml===== %@",theXML);
	
	
	if( _xmlParser )
	{
		
	}
	
	_xmlParser = [[NSXMLParser alloc] initWithData: _webData];
	[_xmlParser setDelegate:(id)self];
	[_xmlParser setShouldResolveExternalEntities: YES];
	[_xmlParser parse];
    [_activityTable reloadData];
    [_popOverTableView reloadData];
    [_cmttable reloadData];
        if(webtype==1||webtype==2)
    {
    [self getLeadActivity];
        _SearchingBar.text=@"";
        webtype=0;
    }
    if (butnidtfr==3) {
        [self getcomments];
        butnidtfr=6;
    }


    
}
#pragma mark-xmldelegates
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"FollowuptypeSelectResponse"])
    {
        _folloarray=[[NSMutableArray alloc]init];
        _followdict=[[NSMutableDictionary alloc]init];
        _reversefollwdict=[[NSMutableDictionary alloc]init];
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"FUTEntryId"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"FUTItemCode"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"FUTName"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"GetLeadActivityResponse"])
    {
        _activityArray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"Id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"LeadId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Date"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Activity"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Employer"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"name"])
    {
        
       
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;

            }
    if([elementName isEqualToString:@"Description"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Status"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"CommunicationType"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"followname"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }


    if ([elementName isEqualToString:@"SaveActivityResult"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
        
    }
    if([elementName isEqualToString:@"DeleteActivityResult"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;

    }
    if([elementName isEqualToString:@"UpdateLeadActivityResult"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }


    
    if([elementName isEqualToString:@"result"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"ActivityCommentsListResponse"])
    {
        _cmntarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;

    }
    if([elementName isEqualToString:@"commentId"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }

    if([elementName isEqualToString:@"ActivityId"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }

    if([elementName isEqualToString:@"Comments"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    
    if([elementName isEqualToString:@"UserId"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"CommentDate"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
   
    if([elementName isEqualToString:@"SearchLeadActivityResponse"])
    {
        _activityArray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"UpdateLeadActivityResult"])
    {
       
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }

  
    if ([elementName isEqualToString:@"SaveActivityCommentResult"])
    {
        
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }


    
    if([elementName isEqualToString:@"EmployeeselectResult"])
    {
        _empdict=[[NSMutableDictionary alloc]init];
        _revempdict=[[NSMutableDictionary alloc]init];

        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"cemp_id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"vf_name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"vl_name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"UserLogmaininsertResponse"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"info"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    


    
    
 
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    
	if( recordResults )
        
	{
        
        
		[_soapResults appendString: string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"FUTEntryId"])
    {
        
        recordResults=FALSE;
        
        _followmdl=[[Craftreqmtmdl alloc]init];
        _followmdl.Brentryid=_soapResults;
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"FUTItemCode"])
    {
        
        recordResults=FALSE;
        
        
        _followmdl.BRreqid=_soapResults;
        _followstring=_soapResults;
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"FUTName"])
    {
        
        recordResults=FALSE;
        
        _followmdl.Brdescriptn=_soapResults;
        [_followdict setObject:_followstring forKey:_soapResults];
         [_reversefollwdict setObject:_soapResults forKey:_followstring];
        
        [_folloarray addObject:_followmdl];
        
        _soapResults = nil;
        
    }

  
    if([elementName isEqualToString:@"GetLeadActivityResponse"])
    {
        
        recordResults = FALSE;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"info"])
    {
        
        recordResults = FALSE;
        _soapResults = nil;
    }
    
    if([elementName isEqualToString:@"Id"])
    {
        _act=[[activityInfo alloc]init];
        recordResults = FALSE;
        _act.activityId=[_soapResults integerValue];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"LeadId"])
    {
        
        recordResults = FALSE;
        _act.LeadId=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Date"])
    {
        
        recordResults = FALSE;
        _act.datest=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Activity"])
    {
        
        recordResults = FALSE;
        _act.activity=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Employer"])
    {
        
        recordResults = FALSE;
        _act.employer=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"name"])
    {
        
        recordResults = FALSE;
        _act.ename=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Description"])
    {
        
        recordResults = FALSE;
        _act.actdesion=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Status"])
    {
        
        recordResults = FALSE;
        _act.status=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"CommunicationType"])
    {     recordResults = FALSE;
         _soapResults = nil;
        
    }

    if([elementName isEqualToString:@"followname"])
    {
        
        recordResults = FALSE;
        _act.communicationtype=_soapResults;
        [_activityArray addObject:_act];
        _soapResults = nil;
    }

    if ([elementName isEqualToString:@"SaveActivityCommentResult"])
    {
        
       
        recordResults = FALSE;
        _soapResults = nil;
        

    }
    if ([elementName isEqualToString:@"SaveActivityResult"])
    {
        
        
        recordResults = FALSE;
        _soapResults = nil;
        
        
    }

    if([elementName isEqualToString:@"result"])
    {
        recordResults = FALSE;
        NSLog(@"%d",webtype);
         NSLog(@"%d",butnidtfr);
        if ([_soapResults isEqualToString:@"deletedleadactivity"]) {
            
        }
        else
        {
        if (butnidtfr==1) {
            _resultmsg=_soapResults;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:_soapResults delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            _updatebtnlbl.enabled=YES;
        }
        else if(butnidtfr==2)
        {
            _resultmsg=_soapResults;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:_soapResults delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            _updatebtnlbl.enabled=YES;
        }
        else if(butnidtfr==3||butnidtfr==6)
        {
            _resultmsg=_soapResults;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:_soapResults delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            _savebtnlbl.enabled=YES;
        }

        }
        
//        if (webtype==0&&butnidtfr==1) {
//             _resultmsg=_soapResults;
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:_resultmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        else if(webtype==0&&butnidtfr==2)
//        {
//             _resultmsg=_soapResults;
//            if ([_resultmsg isEqualToString:@"deletedleadactivity"]) {
//                
//            }
//            else
//            {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:_resultmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            }
//        }
//        else if(webtype==0&&butnidtfr==0)
//        {
//         //_resultmsg=_soapResults;
//        }
//        else if(webtype==0&&butnidtfr==6)
//        {
//            
//             _resultmsg=_soapResults;
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:_resultmsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//            _savebtnlbl.enabled=YES;
//        }
//        else
//        {
//            
//        }
        _soapResults = nil;
    }
   
    if([elementName isEqualToString:@"ActivityCommentsListResult"])
    {
     recordResults = FALSE;
    _soapResults = nil;

    }
    if([elementName isEqualToString:@"commentId"])
    {
        _cmtmdl=[[commentmdl alloc]init];
        recordResults=FALSE;
        _cmtmdl.commentId=[_soapResults integerValue];
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"ActivityId"])
    {
      recordResults=FALSE;
       _cmtmdl.activityid=[_soapResults integerValue];
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"Comments"])
    {
        recordResults=FALSE;
        _cmtmdl.comments=_soapResults;
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"UserId"])
    {
        recordResults=FALSE;
        _cmtmdl.userid=[_soapResults integerValue];
        _soapResults = nil;
        
    }

    
    if([elementName isEqualToString:@"CommentDate"])
    {
        recordResults=FALSE;
        _cmtmdl.commentdate=_soapResults;
        [_cmntarray addObject:_cmtmdl];
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"cemp_id"])
    {
        recordResults = FALSE;
        empid=_soapResults;
        _soapResults = nil;
        
        
    }
    if([elementName isEqualToString:@"vf_name"])
    {
        recordResults = FALSE;
        empname=_soapResults;
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"vl_name"])
    {
        recordResults = FALSE;
        [_empdict setObject:empid forKey:[NSString stringWithFormat:@"%@ %@",empname,_soapResults]];
        [_revempdict setObject:[NSString stringWithFormat:@"%@ %@",empname,_soapResults] forKey:empid];
        _soapResults = nil;
    }


}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.message isEqualToString:_resultmsg]) {
         _updatebtnlbl.enabled=YES;
        if (butnidtfr==2) {
            _newviewactivity.hidden=YES;
            _activityTable.userInteractionEnabled=YES;
        }
        else if(butnidtfr==3)
        {
            _savebtnlbl.enabled=YES;
            self.openviewindex=NSNotFound;
            _cmttxtbox.text=@"";
            _composecmtview.hidden=YES;
        }
        _activityTxtFld.text=@"";
        [_dateBtn setTitle:@"Select" forState:UIControlStateNormal];
        [_activityTypeBtn setTitle:@"Select" forState:UIControlStateNormal];
        [_empbtnlbl setTitle:@"Select" forState:UIControlStateNormal];
        _descptionTextview.text=@"";
        _statusTxtFld.text=@"";
        _cmttxtbox.text=@"";
        _composecmtview.hidden=YES;
        _SearchingBar.text=@"";

        
    }
    if([alertView.message isEqualToString:@"Invalid Activity"])
    {
        _activityTxtFld.text=@"";
    }
    if([alertView.message isEqualToString:@"Invalid Employee"])
    {
        _employerTxtfld.text=@"";
    }
}
#pragma mark;Actions
-(IBAction)saveActivity:(id)sender
{
    if(butnidtfr==1)
    {
        [self UserLogActivityinsert];
        if ([_dateBtn.titleLabel.text isEqualToString:@"Select"]||[_dateBtn.titleLabel.text isEqualToString:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Date is required" delegate:self
        cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
       else if ([_activityTxtFld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Activity is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
       else if ([_activityTypeBtn.titleLabel.text isEqualToString:@"Select"]||[_activityTypeBtn.titleLabel.text isEqualToString:@""])
       {
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Follow Up Type is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alert show];
       }
       else if ([_empbtnlbl.titleLabel.text isEqualToString:@"Select"]||[_empbtnlbl.titleLabel.text isEqualToString:@""])
       {
           UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Employee is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
           [alert show];
       }
       

        else
        {
           
             _updatebtnlbl.enabled=NO;
      [self saveActivity];
          
        }
}
else
    {
         [self Userlogactivityupdate];
        if ([_dateBtn.titleLabel.text isEqualToString:@"Select"]||[_dateBtn.titleLabel.text isEqualToString:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Date is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([_activityTxtFld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Activity is required" delegate:self
                                               cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([_activityTypeBtn.titleLabel.text isEqualToString:@"Select"]||[_activityTypeBtn.titleLabel.text isEqualToString:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Follow Up Type is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if ([_empbtnlbl.titleLabel.text isEqualToString:@"Select"]||[_empbtnlbl.titleLabel.text isEqualToString:@""])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Employee is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
       

        else{
             _updatebtnlbl.enabled=NO;
             [self updateActivity];
           

        }
    }
    //[self getLeadActivity];
}
#pragma mark;popover
-(void)commentpopover{
    poptype=3;
    _composecmtview.hidden=YES;
     [self getcomments];
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 520, 530)];
    
    popoverView.backgroundColor = [UIColor whiteColor];
    
    
    [popoverView addSubview:self.commentview];
    self.commentview.hidden=NO;
    // CGRect rect = frame;
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(520, 530);
    
    //create a popover controller
    
    self.popOverController = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    self.popOverController.popoverContentSize=CGSizeMake(520.0f, 530.0f);
    self.popOverController=_popOverController;

    //
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    CGRect rect=CGRectMake(cell.bounds.origin.x+90, cell.bounds.origin.y+10, 50, 30);
    //    [self.popOverController presentPopoverFromRect:_disclsurelbl.bounds inView:self.view permittedArrowDirections:nil animated:YES];
    
    
    //    UIButton *button=(UIButton *)nil;
    //
    //    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    //    UITableView *table = (UITableView *)[cell superview];
    //    NSIndexPath *IndexPath = [table indexPathForCell:cell];
    //
    
    
    
    [self.popOverController presentPopoverFromRect: CGRectMake(350, 120, 300, 500)                                        inView:self.view
                          permittedArrowDirections:nil
                                          animated:YES];
    
    
    
}
-(IBAction)savecomment:(id)sender
{
    butnidtfr=3;
    
     [self UserLogsavecomments];
    if ([_cmttxtbox.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Comment is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        _savebtnlbl.enabled=YES;
    }
    else
    {
       
 _savebtnlbl.enabled=NO;
    [self saveComment];
    }
}
-(IBAction)cancelcomment:(id)sender
{
    _savebtnlbl.enabled=YES;
    self.openviewindex=NSNotFound;
    _cmttxtbox.text=@"";
    _composecmtview.hidden=YES;

}
-(IBAction)disclosure:(id)sender
{
    poptype=2;
    UIViewController* popoverContent = [[UIViewController alloc]init];
    UIView* popoverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    // popoverView.backgroundColor = [UIColor whiteColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 40;
    _popOverTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //_popovertableview.separatorColor=[UIColor blackColor];
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    popoverContent.contentSizeForViewInPopover = CGSizeMake(130, 44);
    
    button = (UIButton *)sender;
    UITableViewCell *cell = (UITableViewCell *)[[button superview] superview];
    CGPoint center= button.center;
    CGPoint rootViewPoint = [button.superview convertPoint:center toView:self.activityTable];
    NSIndexPath *textFieldIndexPath = [self.activityTable indexPathForRowAtPoint:rootViewPoint];
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
    btnindex=textFieldIndexPath.row;
    
    //UITableView *table = (UITableView *)[cell superview];
    self.popOverController = [[UIPopoverController alloc]initWithContentViewController:popoverContent];
    self.popOverController.popoverContentSize=CGSizeMake(130.0f, 44.0f);
    self.popOverController=_popOverController;
    [self.popOverController presentPopoverFromRect:_disclosurebtn.frame inView:cell permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    _searchstring=_SearchingBar.text;
    //NSLog(@"search%@",searchstring);
    [self SearchLeadActivity];
    [searchBar resignFirstResponder];
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self getLeadActivity];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if ([_SearchingBar.text length]==0) {
        
        [self getLeadActivity];
        // [searchBar resignFirstResponder];
        
        
    }
    //[searchBar resignFirstResponder];
    
}
- (IBAction)closecomments:(id)sender
{
    [self.popOverController dismissPopoverAnimated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==_employerTxtfld){
        Validation *val=[[Validation alloc]init];
        int value1=[val validatespecialcharacters:_employerTxtfld.text];
        
        if(value1==0)
        {
            
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Employee" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
            
            
        }
        
    }
    if(textField==_activityTxtFld){
        Validation *val=[[Validation alloc]init];
        int value1=[val validatespecialcharacters:_activityTxtFld.text];
        
        if(value1==0)
        {
            
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Activity" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
            
            
        }
        
    }
//    if(textField==_statusTxtFld){
//        Validation *val=[[Validation alloc]init];
//        int value1=[val validatespecialcharacters:[_statusTxtFld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
//        
//        if(value1==0)
//        {
//            
//            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Status" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//            [alert1 show];
//            
//            
//        }
//        
//    }


}
-(IBAction)tofollowup:(id)sender
{
    _flpctrl=[[FLPViewController alloc]initWithNibName:@"FLPViewController" bundle:nil];
    _flpctrl.modalPresentationStyle=UIModalPresentationFormSheet;
    //_subtypctrlr.moduleid=moduleid;
    [self presentViewController:self.flpctrl
                       animated:YES completion:NULL];
    [_activityTypeBtn setTitle:@"Select" forState:UIControlStateNormal];
    
}

- (IBAction)empbtn:(id)sender {
    poptype=13;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 239, 200)];
    
    popoverView.backgroundColor = [UIColor lightTextColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 239, 200)];
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
    
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(239, 200);
    
    //create a popover controller
    self.popOverController = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    self.popOverController.popoverContentSize=CGSizeMake(239.0f, 200.0f);
    self.popOverController=_popOverController;

    [self.popOverController presentPopoverFromRect:_empbtnlbl.frame
                                            inView:_newviewactivity
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    [self Employeeselect];

}
#pragma mark-textfld delegates
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if(textField==_activityTxtFld)
    {
        NSUInteger newLength = [_activityTxtFld.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    if(textField==_statusTxtFld)
    {
        NSUInteger newLength = [_statusTxtFld.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
       return YES;
}
#pragma mark-textview Delegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return _descptionTextview.text.length + (text.length - range.length) <= 50;
}
@end
