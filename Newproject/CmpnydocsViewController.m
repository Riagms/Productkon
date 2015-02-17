//
//  CmpnydocsViewController.m
//  Newproject
//
//  Created by GMSIndia1 on 3/13/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import "CmpnydocsViewController.h"

@interface CmpnydocsViewController ()

@end

@implementation CmpnydocsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    //_cmmntview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    _newcmntview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:250.0/255.0f alpha:1.0f];

    // Do any additional setup after loading the view from its nib.
    _navbar.tintColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    _docutable.layer.borderColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:250.0/255.0f alpha:1.0f].CGColor;
    _cmmnttable.layer.borderColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:250.0/255.0f alpha:1.0f].CGColor;
    _titleview.backgroundColor = [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    _docutable.layer.borderWidth=3.0f;
    _cmmnttable.layer.borderWidth=3.0f;
    _popovrdict=[[NSMutableDictionary alloc]init];
    [_popovrdict setObject:@"1" forKey:@"Company Values"];
    [_popovrdict setObject:@"2" forKey:@"Quality"];
    [_popovrdict setObject:@"3" forKey:@"Safety Manual"];
    [_popovrdict setObject:@"4" forKey:@"Employee Handbook"];
    [_popovrdict setObject:@"5" forKey:@"Fleet Management"];
    [_popovrdict setObject:@"6" forKey:@"MSDS Database"];
    [_popovrdict setObject:@"7" forKey:@"Bid Master"];
    [_popovrdict setObject:@"8" forKey:@"Plan"];
    [_popovrdict setObject:@"9" forKey:@"Estimates"];
    [_popovrdict setObject:@"10" forKey:@"Bid Estimates"];
    [_popovrdict setObject:@"11" forKey:@"Contract"];
    [_popovrdict setObject:@"12" forKey:@"Company Info"];
    [_popovrdict setObject:@"13" forKey:@"Basic Requirement"];
    _popoverArry=[[NSMutableArray alloc]initWithArray:[_popovrdict allKeys]];

    [[self.cmmnttxtview layer] setBorderColor:[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor];
    [[self.cmmnttxtview layer] setBorderWidth:2];
    [[self.cmmnttxtview layer] setCornerRadius:10];
   
    /*searchbar*/
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    _searchbar.delegate = (id)self;
    _searchbar.tintColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    
    self.docutable.tableHeaderView =_searchbar;
    
    UISearchDisplayController* searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchbar contentsController:self];
    searchController.searchResultsDataSource = (id)self;
    searchController.searchResultsDelegate =(id)self;
    searchController.delegate = (id)self;
   _searchbar.text=@"";

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_docutable reloadData];
    _searchbar.text=@"";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-popover
-(void)createpopover{
    poptype=1;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    popoverContent.view.bounds=CGRectMake(10, 20, 20, 10);
//    UIView* popoverView = [[UIView alloc]
//                           initWithFrame:CGRectMake(0, 0, 250, 400)];
//    
    //popoverView.backgroundColor = [UIColor whiteColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
    _popOverTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

    
    // CGRect rect = frame;
  //  [popoverView addSubview:_popOverTableView];
    popoverContent.view = _popOverTableView;
    
    //resize the popover view shown
    //in the current view to the view's size
   // popoverContent.contentSizeForViewInPopover = CGSizeMake(250, 400);
      //create a popover controller
    [popoverContent setContentSizeForViewInPopover:CGSizeMake(20, 0)];
    self.popOverController = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    self.popOverController.popoverContentSize=CGSizeMake(250.0f, 310.0f);
    self.popOverController=_popOverController;
          [self.popOverController presentPopoverFromRect:_docutyebtn.frame
                                                inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    
    
    
}
-(void)commentpopover{
     _newcmntview.hidden=YES;
    
    poptype=2;
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 520, 530)];
    
    popoverView.backgroundColor = [UIColor whiteColor];
    
    
    [popoverView addSubview:self.cmmntview];
    self.cmmntview.hidden=NO;
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
    
    [self.popOverController presentPopoverFromRect: CGRectMake(230, 210, 300, 500)
                                            inView:self.view
                          permittedArrowDirections:nil
                                          animated:YES];
    
    
    
}

#pragma mark-Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    if (tableView==_popOverTableView) {
       
            return [_popovrdict count];
     }
       if (tableView==_cmmnttable){
             return [_commentarray count];
        }
    
     if ( tableView==_docutable){
    return [_documntarray count];
    }
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        if (tableView==_docutable) {
            [[NSBundle mainBundle]loadNibNamed:@"cmpnydocucell" owner:self options:nil];
        cell=_cmpnydoccell;
        }
        
        if(tableView==_cmmnttable){
           
                [[NSBundle mainBundle]loadNibNamed:@"CompanyCmntscell" owner:self options:nil];
                cell=_cmntcell;


            
            
        }
        
    }
        if(tableView==_popOverTableView)
        {  cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
            cell.textLabel.font = [UIFont systemFontOfSize:12.0];
            
            
            
           
              cell.textLabel.text=[_popoverArry objectAtIndex:indexPath.row];
            
        }
    if (tableView==_cmmnttable){
                commentmdl *cmnt1=(commentmdl *)[_commentarray objectAtIndex:indexPath.row];
                
        
//                [[self.newcmmnttxtview layer] setBorderColor:[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor];
//                [[self.newcmmnttxtview layer] setBorderWidth:2];
//                [[self.newcmmnttxtview layer] setCornerRadius:10];
                    _Cmmntgtextview=(UITextView *)[cell viewWithTag:5];
                _Cmmntgtextview.text=cmnt1.comments;
                _cmttype=(UILabel *)[cell viewWithTag:2];
                _cmttype.text=cmnt1.commentdate;

            
            
            
            }

        
      if (tableView==_docutable) {
          _docunamelbl=(UILabel *)[cell viewWithTag:1];
          _docunamelbl.text=[_documntarray objectAtIndex:indexPath.row];
      }
    
    
    
    
return cell;
    
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_cmmnttable)
        
    {
        return self.editing ;
    }
    return YES;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==_popOverTableView) {
        
        
        
                       [_docutyebtn setTitle:[_popoverArry objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        type=[_popoverArry objectAtIndex:indexPath.row];
      //type=  [_popovrdict objectForKey:[_popoverArry objectAtIndex:indexPath.row] ];
                
    }
    _searchbar.text=@"";
    [self.popOverController dismissPopoverAnimated:YES];
    [self AllDocumentsselect];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //alternating cell back ground color
    if(tableView==_docutable)
    {
        if (indexPath.row%2 == 0) {
            [cell setBackgroundColor:[UIColor whiteColor]];
            
        }else
        {
            
            //[cell setBackgroundColor:[UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0f]];
            [cell setBackgroundColor:[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f]];
            
            
        }
    }
}


#pragma mark-webservice
-(void)AllDocumentsselect
{
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<AllDocumentsselect xmlns=\"https://vip.kontract360.com/\">\n"
                  "<Type>%@</Type>\n"
                   "</AllDocumentsselect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",type];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
  
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/AllDocumentsselect" forHTTPHeaderField:@"Soapaction"];
    
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

-(void)FileCommentsselect
{
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<FileCommentsselect xmlns=\"https://vip.kontract360.com/\">\n"
                   "<FileId>%d</FileId>\n"
                   "</FileCommentsselect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",[newfieldid integerValue]];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/FileCommentsselect" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)FileCommentsInsert
{
    
    
    NSDate*curntdate=[NSDate date];
   
    NSLog(@"%@",curntdate);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"HH:mm:ss a"];
    NSLog(@"curntdate%@",[dateFormat stringFromDate:curntdate]);
    NSString*time=[dateFormat stringFromDate:curntdate];
    [dateFormat setDateFormat:@"MM/dd/ yyyy"];
    NSString*date1=[dateFormat stringFromDate:curntdate];
    NSString*today=[NSString stringWithFormat:@"%@ %@",date1,time];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString*usernameid = [defaults objectForKey:@"UserNameId"];

  NSString*newstrg=  [_cmmnttxtview.text stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    newstrg=  [newstrg stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    newstrg=  [newstrg stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    newstrg=  [newstrg stringByReplacingOccurrencesOfString:@"'" withString:@"&#39;"];
    
    
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<FileCommentsInsert xmlns=\"https://vip.kontract360.com/\">\n"
                   "<FileId>%d</FileId>\n"
                   "<Comments>%@</Comments>\n"
                   "<UserId>%d</UserId>\n"
                   "<CommentDate>%@</CommentDate>\n"
                   "</FileCommentsInsert>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",[newfieldid integerValue],newstrg,[usernameid integerValue],today];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/FileCommentsInsert" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)UserLogmainview{
    
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
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],_moduleid,@"ViewDocs",@"iOS",extnalip,intrnalip,Udid,USerdocid];
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
-(void)UserLogmaininsert{
    
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
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],_moduleid,@"CreateDocs",@"iOS",extnalip,intrnalip,Udid,USerdocid];
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
-(void)DocumentSearch
{
    
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<DocumentSearch xmlns=\"https://vip.kontract360.com/\">\n"
                   "<searchtext>%@</searchtext>\n"
                   "<Type>%@</Type>\n"
                   "</DocumentSearch>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_searchstring,type];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/DocumentSearch" forHTTPHeaderField:@"Soapaction"];
    
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



#pragma mark - Connection
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
    [_docutable reloadData];
    [_cmmnttable reloadData];
    
}

#pragma mark - XMLParser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    
    if([elementName isEqualToString:@"AllDocumentsselectResponse"])
    {
        _documntarray=[[NSMutableArray alloc]init];
        _docdict=[[NSMutableDictionary alloc]init];
          _fileiddict=[[NSMutableDictionary alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"DocumentSearchResponse"])
    {
        _documntarray=[[NSMutableArray alloc]init];
        _docdict=[[NSMutableDictionary alloc]init];
        _fileiddict=[[NSMutableDictionary alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"FolderName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"Column1"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"docID"])
    {
      
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
       if([elementName isEqualToString:@"FileCommentsselectResponse"])
    {
        _commentarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"ID"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }

    if([elementName isEqualToString:@"FileId"])
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
    if([elementName isEqualToString:@"result"])
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
    if([elementName isEqualToString:@"docID"])
    {
         recordResults = FALSE;
        fileid=_soapResults;
        
         _soapResults = nil;

    }
    if([elementName isEqualToString:@"FolderName"])
    {
        
        
        recordResults = FALSE;
        filename=_soapResults;
        [_fileiddict setObject:fileid forKey:_soapResults];
        [_documntarray addObject:_soapResults];
        
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Column1"])
    {
        
        recordResults = FALSE;
        NSString *newstrg=@"\\";
        NSString *urlname=[_soapResults stringByReplacingOccurrencesOfString:newstrg withString:@"/"];
        
        [_docdict setObject:urlname forKey:filename];

        
               _soapResults = nil;
    }
    if([elementName isEqualToString:@"fileType"])
    {
        
        recordResults = FALSE;
        
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"ID"])
    {
        _cmntmdl1=[[commentmdl alloc]init];
        recordResults = FALSE;
        
        _cmntmdl1.commentId=[_soapResults integerValue];
        _soapResults = nil;
    }

    if([elementName isEqualToString:@"FileId"])
    {
        recordResults = FALSE;
        
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Comments"])
    {
        recordResults = FALSE;
        _cmntmdl1.comments=_soapResults;
        
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"UserId"])
    {
        recordResults = FALSE;
        _cmntmdl1.userid=[_soapResults integerValue];
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"CommentDate"])
    {
        recordResults = FALSE;
         _cmntmdl1.commentdate=_soapResults;
        
        [_commentarray addObject:_cmntmdl1];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"info"])
    {
        recordResults = FALSE;
        
        _soapResults = nil;
    }

    if([elementName isEqualToString:@"result"])
    {
        recordResults = FALSE;
        _msgstring=_soapResults;
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:_msgstring delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil,nil];
        [alert show];
        
       
        _soapResults = nil;


    }

 }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.message isEqualToString:_msgstring]) {
        
        [self FileCommentsselect];
        _cmmnttxtview.text=@"";
        _newcmntview.hidden=YES;
        
    }
}

- (IBAction)clsebtn:(id)sender {
    _documntarray=[[NSMutableArray alloc]init];
    [_docutyebtn setTitle:@"Select" forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)docutypebtn:(id)sender {
    [self createpopover];
    [_popOverTableView reloadData];
}
- (IBAction)viewweb:(id)sender {
    _searchbar.text=@"";
    [self AllDocumentsselect];
    button = (UIButton *)sender;
    CGPoint center= button.center;
    CGPoint rootViewPoint = [button.superview convertPoint:center toView:self.docutable];
    NSIndexPath *textFieldIndexPath = [self.docutable indexPathForRowAtPoint:rootViewPoint];
    
    
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
    USerdocid=[[_fileiddict objectForKey:[_documntarray objectAtIndex:textFieldIndexPath.row]]integerValue];
    
    [self UserLogmainview];
     NSString *fullURL =[NSString stringWithFormat:@"https://vip.kontract360.com%@",[_docdict objectForKey:[_documntarray objectAtIndex:textFieldIndexPath.row]]];
//    NSString *fullURL =[NSString stringWithFormat:@"http://192.168.0.175:7342/Folder/Root/Company Values/132074984.jpg"];
    NSLog(@"fullurl%@",fullURL);
    //_urlstring=[_docdict objectForKey:[_documntarray objectAtIndex:textFieldIndexPath.row]];
   // _urlstring=[NSString stringWithFormat:@"http://192.168.0.1:443/Folder/Root/EmployeeHandbook/accounts.xlsx"];
    
    //if (!self.webVCtrl) {
    self.webVCtrl=[[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
   // }
    _webVCtrl.modalPresentationStyle = UIModalPresentationPageSheet;
    _webVCtrl.urlstring=fullURL;
    
    [self presentViewController:_webVCtrl
                       animated:YES completion:NULL];
    
}
- (IBAction)cmntsavebtn:(id)sender {
    if ([_cmmnttxtview.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Comment is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [self UserLogmaininsert];
        _savecmntbtn.enabled=NO;
    [self FileCommentsInsert];
    }
}

- (IBAction)cancelbtn:(id)sender {
    _cmmnttxtview.text=@"";
     _newcmntview.hidden=YES;
     _savecmntbtn.enabled=YES;
    _searchbar.text=@"";
}
- (IBAction)cmntbtn:(id)sender {
    
    button = (UIButton *)sender;
    CGPoint center= button.center;
    CGPoint rootViewPoint = [button.superview convertPoint:center toView:self.docutable];
    NSIndexPath *textFieldIndexPath = [self.docutable indexPathForRowAtPoint:rootViewPoint];
    
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
    newfieldid=[_fileiddict objectForKey:[_documntarray objectAtIndex:textFieldIndexPath.row]];
     NSLog(@"bvb%@",[_documntarray objectAtIndex:textFieldIndexPath.row]);
    
    [self FileCommentsselect];

    [self UserLogmainview];
    [self commentpopover];
}

- (IBAction)addcmt:(id)sender {
    
     _savecmntbtn.enabled=YES;
    _newcmntview.hidden=NO;
    
}
- (IBAction)closebtn:(id)sender
{
    [self.popOverController dismissPopoverAnimated:YES];
    _searchbar.text=@"";
}
#pragma mark-Searchbar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    _searchstring=_searchbar.text;
  [self DocumentSearch];
    [searchBar resignFirstResponder];
    
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self AllDocumentsselect];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([_searchbar.text length]==0) {
        
       [self AllDocumentsselect];
        
        
    }
    
    
    
}

@end
