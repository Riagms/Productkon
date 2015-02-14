//
//  UsersViewController.m
//  Newproject
//
//  Created by GMSIndia 2 on 16/12/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "UsersViewController.h"

@interface UsersViewController ()

@end

@implementation UsersViewController

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
    _addview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    _Nametypeusrarry=[[NSArray alloc]init];
     _type2btnlbl.enabled=NO;
    _usertable.layer.borderWidth = 2.0;
    _usertable.layer.borderColor = [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor;
    _titleview.backgroundColor = [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    /*searchbar*/
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    _searchbar.delegate = (id)self;
    _searchbar.tintColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    
    self.usertable.tableHeaderView =_searchbar;
    
    UISearchDisplayController* searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchbar contentsController:self];
    searchController.searchResultsDataSource = (id)self;
    searchController.searchResultsDelegate =(id)self;
    searchController.delegate = (id)self;
    _devicelistdict=[[NSMutableDictionary alloc]init];
    [_devicelistdict setObject:@"Web" forKey:@"1"];
    [_devicelistdict setObject:@"IPad" forKey:@"2"];
    [_devicelistdict setObject:@"Android" forKey:@"3"];
    _reversedevicelistdict=[[NSMutableDictionary alloc]init];
    [_reversedevicelistdict setObject:@"1" forKey:@"Web"];
    [_reversedevicelistdict setObject:@"2" forKey:@"IPad"];
    [_reversedevicelistdict setObject:@"3" forKey:@"Android"];

    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self SelectAllUsers];
    actvatestring=@"";
     [self UserTypeselect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_popOverTableView) {
       
        if (poptype==1) {
          return [_Nametypeusrdict count];
            
        }
        else if (poptype==2){
            switch (tyid) {
                case 1:
                return [_empydict count];
                    
                        break;
                case 2:
                    return [_custmrdict count];
                    
                    break;
                    
                default:
                    break;
            }
            
        }
        else if (poptype==3)
        {
            return [_devicelistdict count];
        }
    }
    else {
         return [_userlistarray count];
    }
    return YES;
    }
        

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font=[UIFont fontWithName:@"Helvetica Neue" size:12];
        if (tableView==_usertable) {

        [[NSBundle mainBundle]loadNibNamed:@"usercell" owner:self options:nil];
        cell=_usercell;
        }
    }
    if (tableView==_usertable) {
        
    
    listusermdl*usrmdl=(listusermdl *)[_userlistarray objectAtIndex:indexPath.row];
    _usernamelabel=(UILabel *)[cell viewWithTag:1];
    _usernamelabel.text=usrmdl.username;
    }
    if (tableView==_popOverTableView) {
         if (poptype==1) {
        _Nametypeusrarry=[_Nametypeusrdict allKeys];
        cell.textLabel.text=[_Nametypeusrarry objectAtIndex:indexPath.row];
         }
         if (poptype==2) {
            
             
             switch (tyid) {
                 case 1:
                     _empyarry=[_empydict allKeys];
                     cell.textLabel.text=[_empyarry objectAtIndex:indexPath.row];
                     
                     break;
                 case 2:
                     _custmrrarry=[_custmrdict allKeys];
                     cell.textLabel.text=[_custmrrarry objectAtIndex:indexPath.row];
                     break;
                 default:
                     break;
             }

             
         }
         if (poptype==3)
         {
             _devicelistarry=[_devicelistdict allValues];
             cell.textLabel.text=[_devicelistarry objectAtIndex:indexPath.row];
         }
    }
    return cell;
}

#pragma mark - Table View delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    insrtpath=indexPath.row;
    if (tableView==_popOverTableView) {
        
        if (poptype==1) {
            //_type1btnlbl.titleLabel.text=[_Nametypeusrarry objectAtIndex:indexPath.row];
            [_type1btnlbl setTitle:[_Nametypeusrarry objectAtIndex:indexPath.row] forState:UIControlStateNormal ];
            [_type2btnlbl setTitle:@"Select" forState:UIControlStateNormal ];
            _titlenamelabel.hidden=NO;
            _titlenamelabel.text=[_Nametypeusrarry objectAtIndex:indexPath.row];
            _type2btnlbl.enabled=YES;
            
            
        }
        
        
        if (poptype==2) {
            
            switch (tyid) {
                case 1:
                      [_type2btnlbl setTitle:[_empyarry objectAtIndex:indexPath.row] forState:UIControlStateNormal ];
                    
                    break;
                case 2:
                   [_type2btnlbl setTitle:[_custmrrarry objectAtIndex:indexPath.row] forState:UIControlStateNormal ];
                    break;
                default:
                    break;
            }

        }
          if (poptype==3)
          {
              [_devicebtn setTitle:[_devicelistarry objectAtIndex:indexPath.row] forState:UIControlStateNormal ];
          }
        
        
    }
 [self.popOverController dismissPopoverAnimated:YES];
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //alternating cell back ground color
    if(tableView==_usertable)
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


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_usertable) {
        
    
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [self UserLogmaindelete];
        path=indexPath.row;
        Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
        
        
        if (rightsmodel.DeleteModule==0) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You dont have rights to delete a record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            
        }
        else
        {

        [self DeleteUsers];
        [_userlistarray removeObject:indexPath];
        
        
        
        }
        
    }
    }
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==_popOverTableView)
        
    {
        return self.editing ;
    }
    return YES;
    
}
#pragma mark- WebService
-(void)SelectAllUsers{
    recordresults = FALSE;
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectAllUsers xmlns=\"https://vip.kontract360.com/\">\n"
                   
                   "</SelectAllUsers>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
     NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];

    //   NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/SelectAllUsers" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)SearchUsers
{
    
    recordresults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SearchUsers xmlns=\"https://vip.kontract360.com/\">\n"
                   "<searchtext>%@</searchtext>\n"
                   "</SearchUsers>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_searchstring];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/SearchUsers" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)SelectAllCustomer{
    recordresults = FALSE;
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectAllCustomer xmlns=\"https://vip.kontract360.com/\">\n"
                   
                   "</SelectAllCustomer>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
     NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];

    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/SelectAllCustomer" forHTTPHeaderField:@"Soapaction"];
    
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
    
    recordresults = FALSE;
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
     NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];

    
    //   NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
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
-(void)PasswordForUser
{
     listusermdl*usrmdl=(listusermdl *)[_userlistarray objectAtIndex:btnindex];
    recordresults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<PasswordForUser xmlns=\"https://vip.kontract360.com/\">\n"
                    "<UserName>%@</UserName>\n"
                   "</PasswordForUser>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",usrmdl.username];
    NSLog(@"soapmsg%@",soapMessage);
     NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    
    //   NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/PasswordForUser" forHTTPHeaderField:@"Soapaction"];
    
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


-(void)UserTypeselect
{
    
    recordresults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UserTypeselect xmlns=\"https://vip.kontract360.com/\">\n"
                    "</UserTypeselect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
     NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];

    //   NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
   //  NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UserTypeselect" forHTTPHeaderField:@"Soapaction"];
    
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

-(void)InsertUsers
{
    webtype=1;
    recordresults = FALSE;
    NSInteger userid=[[_Nametypeusrdict objectForKey:_type1btnlbl.titleLabel.text]integerValue];
    NSInteger deviceid=[[_reversedevicelistdict objectForKey:_devicebtn.titleLabel.text]integerValue];
   
    
    switch (tyid) {
        case 1:
               usertyid=[[_empydict objectForKey:_type2btnlbl.titleLabel.text]integerValue];
            break;
        case 2:
             usertyid=[[_custmrdict objectForKey:_type2btnlbl.titleLabel.text]integerValue];

            break;
        default:
            break;
    }

    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<InsertUsers xmlns=\"https://vip.kontract360.com/\">\n"
                   "<username>%@</username>\n"
                   "<password>%@</password>\n"
                   "<UserTypeId>%d</UserTypeId>\n"
                   "<UserTypeName>%d</UserTypeName>\n"
                   "<DeviceType>%d</DeviceType>\n"
                   "<Activate>%d</Activate>\n"
                   "</InsertUsers>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_usrnametextfld.text,_pswdtextfld.text,userid,usertyid,deviceid,activate];
    NSLog(@"soapmsg%@",soapMessage);
    
    
       NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/InsertUsers" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)UpdateUsers
{
    webtype=1;
    
    NSInteger userid=[[_Nametypeusrdict objectForKey:_type1btnlbl.titleLabel.text]integerValue];
    
    if ([_type1btnlbl.titleLabel.text isEqualToString:@"Employee"]) {
        tyid=1;
    }
    else if (([_type1btnlbl.titleLabel.text isEqualToString:@"Customer"])){
        tyid=2;
    }
    else if (([_type1btnlbl.titleLabel.text isEqualToString:@"Vendor"])){
        tyid=3;
    }
    
    
    switch (tyid) {
        case 1:
            usertyid=[[_empydict objectForKey:_type2btnlbl.titleLabel.text]integerValue];
            break;
        case 2:
            usertyid=[[_custmrdict objectForKey:_type2btnlbl.titleLabel.text]integerValue];
            
            break;
        default:
            break;
    }

    listusermdl*usermdl=(listusermdl *)[_userlistarray objectAtIndex:btnindex];
    NSInteger deviceid=[[_reversedevicelistdict objectForKey:_devicebtn.titleLabel.text]integerValue];
    NSInteger act;
    if([actvatestring isEqualToString:@"activate"])
    {
        if (activate==0) {
            act=0;
        }
        else{
            act=1;
            
        }
        actvatestring=@"";
    }
    else
    {
        if ([usermdl.Activate isEqualToString:@"true"]) {
            act=1;
        }
        else
        {
            act=0;
        }
    }

    recordresults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UpdateUsers xmlns=\"https://vip.kontract360.com/\">\n"
                   "<userid>%d</userid>\n"
                   "<username>%@</username>\n" 
                   "<password>%@</password>\n"
                   "<UserTypeId>%d</UserTypeId>\n"
                   "<UserTypeName>%d</UserTypeName>\n"
                   "<DeviceType>%d</DeviceType>\n"
                   "<Activate>%d</Activate>\n"
                   "</UpdateUsers>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",usermdl.userid,_usrnametextfld.text,_pswdtextfld.text,userid,usertyid,deviceid,act];
    NSLog(@"soapmsg%@",soapMessage);
     NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];

    
     //  NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UpdateUsers" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)DeleteUsers
{
    webtype=2;
    recordresults = FALSE;
    NSString *soapMessage;
    listusermdl*usrmdl=(listusermdl *)[_userlistarray objectAtIndex:path];
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<DeleteUsers xmlns=\"https://vip.kontract360.com/\">\n"
                   "<userid>%d</userid>\n"
                   "</DeleteUsers>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",usrmdl.userid];
    NSLog(@"soapmsg%@",soapMessage);
    
     NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];

    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     // NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/DeleteUsers" forHTTPHeaderField:@"Soapaction"];
    
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
    
    recordresults = FALSE;
    
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
    
    
    //   NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
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
-(void)UserLogmainupdate{
    
    recordresults = FALSE;
    
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
    
    
    //   NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
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
-(void)UserLogmaindelete{
    
    recordresults = FALSE;
    
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
    
    
    //   NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
      NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
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
       [_usertable reloadData];
    [_popOverTableView reloadData];
    
    
}
#pragma mark-xml parser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"SelectAllUsersResult"])
    {
        _userlistarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"UserId"])
    {
                if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"UserName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"Password"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"UserTypeId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"UserTypeName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"empname"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }

    if([elementName isEqualToString:@"Column1"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"DeviceType"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"Activate"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }


    
    if([elementName isEqualToString:@"SearchUsersResponse"])
    {
        _userlistarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }

    if([elementName isEqualToString:@"UserTypeselectResult"])
    {
        _Nametypeusrdict=[[NSMutableDictionary alloc]init];
               if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"userTypeId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"userTypeName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }

    if([elementName isEqualToString:@"SelectAllCustomerResult"])
    {
        _custmrdict=[[NSMutableDictionary alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }

    if([elementName isEqualToString:@"Id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"CustomerName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }

    if([elementName isEqualToString:@"EmployeeselectResult"])
    {
        _empydict=[[NSMutableDictionary alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    
    if([elementName isEqualToString:@"cemp_id"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"vf_name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"vl_name"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"InsertUsersResult"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"UpdateUsersResult"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"result"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"PasswordForUserResponse"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }
    if([elementName isEqualToString:@"url"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordresults = TRUE;
    }

    




}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    
    
	if( recordresults )
        
	{
        
        
		[_soapResults appendString: string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"UserId"])
    {
        _usrmdl=[[listusermdl alloc]init];
        recordresults = FALSE;
        _usrmdl.userid=[_soapResults integerValue];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"UserName"])
    {
        
        recordresults = FALSE;
        _usrmdl.username=[_soapResults stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Password"])
    {
        
        recordresults = FALSE;
        _usrmdl.pwd=[_soapResults stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"UserTypeId"])
    {
        
        recordresults = FALSE;
        _usrmdl.UserTypeId=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"UserTypeName"])
    {
        
        recordresults = FALSE;
        _usrmdl.UserTypeName=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"empname"])
    {
        
        recordresults = FALSE;
        _usrmdl.empname=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Column1"])
    {
        
        recordresults = FALSE;
        _usrmdl.customername=_soapResults;
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"DeviceType"])
    {
        
        recordresults = FALSE;
        _usrmdl.DeviceType=_soapResults;
        _soapResults = nil;
    }

    if([elementName isEqualToString:@"Activate"])
    {
        
        recordresults = FALSE;
        _usrmdl.Activate=_soapResults;
        [_userlistarray addObject:_usrmdl];
        _soapResults = nil;
    }


    if([elementName isEqualToString:@"userTypeId"])
    {
        recordresults = FALSE;
        usertypename=_soapResults;
        _soapResults = nil;

            }
    if([elementName isEqualToString:@"userTypeName"])
    {
        recordresults = FALSE;
     
        [_Nametypeusrdict setObject:usertypename forKey:[_soapResults stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        _soapResults = nil;

    }
    if([elementName isEqualToString:@"Id"])
    {
        recordresults = FALSE;
        custmrid=_soapResults;
        _soapResults = nil;

    }
    if([elementName isEqualToString:@"CustomerName"])
    {
        recordresults = FALSE;
        [_custmrdict setObject:custmrid forKey:_soapResults];
        _soapResults = nil;

    }
    if([elementName isEqualToString:@"cemp_id"])
    {
        recordresults = FALSE;
        empid=_soapResults;
        _soapResults = nil;


    }
    if([elementName isEqualToString:@"vf_name"])
    {
        recordresults = FALSE;
        empname=_soapResults;
        _soapResults = nil;
    
    }
    if([elementName isEqualToString:@"vl_name"])
    {
        recordresults = FALSE;
        [_empydict setObject:empid forKey:[NSString stringWithFormat:@"%@%@",empname,_soapResults]];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"InsertUsersResult"])
    {
        recordresults = FALSE;
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"UpdateUsersResult"])
    {
        recordresults = FALSE;
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"url"])
    {
        recordresults = FALSE;
        _pswdtextfld.text=_soapResults;
        _soapResults = nil;
        
    }

  
    if([elementName isEqualToString:@"result"])
    {
        recordresults = FALSE;
        if (webtype==1) {
            
            _resultstring=_soapResults;
        UIAlertView *alert= [[UIAlertView alloc]initWithTitle:@"" message:_soapResults delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
            [self SelectAllUsers];
            _searchbar.text=@"";

                }
        if(webtype==2)
        {
            [self SelectAllUsers];
            _searchbar.text=@"";
           
        }

        _soapResults = nil;
        
    }



}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.message isEqualToString:_resultstring])
    {if(optionIdentifier==1)
    {
        _usrnametextfld.text=@"";
        _pswdtextfld.text=@"";
        [_type1btnlbl setTitle:@"Select" forState:UIControlStateNormal];
        [_type2btnlbl setTitle:@"Select" forState:UIControlStateNormal];
        _searchbar.text=@"";
        _updatebtn.enabled=YES;
         [_activatebtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
         [_devicebtn setTitle:@"Select" forState:UIControlStateNormal];
    }
        else if (optionIdentifier==2)
        {
            _usrnametextfld.text=@"";
            _pswdtextfld.text=@"";
            [_type1btnlbl setTitle:@"Select" forState:UIControlStateNormal];
            [_type2btnlbl setTitle:@"Select" forState:UIControlStateNormal];
            _addview.hidden=YES;
            _usertable.userInteractionEnabled=YES;
            _searchbar.text=@"";
            _updatebtn.enabled=YES;
             [_activatebtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
             [_devicebtn setTitle:@"Select" forState:UIControlStateNormal];
        }

    }
    if([alertView.message isEqualToString:@"User Name is required"])
    {
        _usrnametextfld.text=@"";
        
    }
    if([alertView.message isEqualToString:@"Password is required"])
    {
        _pswdtextfld.text=@"";
        
    }
    if([alertView.message isEqualToString:@"Invalid User Name"])
    {
        _usrnametextfld.text=@"";
        
    }
   
}


#pragma mark-actios
-(IBAction)closeuser:(id)sender
{_updatebtn.enabled=YES;
     _addview.hidden=YES;
    _usertable.userInteractionEnabled=YES;
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(IBAction)adduserview:(id)sender
{
    _updatebtn.enabled=YES;
     _usertable.userInteractionEnabled=NO;
    optionIdentifier=1;
    _resultdisplaylabel.hidden=YES;
    _addview.hidden=NO;
    _navitem.title=@"Create";
    _pswdtextfld.text=@"";
    _usrnametextfld.text=@"";
    _titlenamelabel.hidden=YES;
    _cancelbtn.enabled=YES;
   // _type1btnlbl.titleLabel.text=@"Select";
   // _type2btnlbl.titleLabel.text=@"Select";
    [_type1btnlbl setTitle:@"Select" forState:UIControlStateNormal];
    [_type2btnlbl setTitle:@"Select" forState:UIControlStateDisabled];
     [_type2btnlbl setTitle:@"Select" forState:UIControlStateNormal];
    _type2btnlbl.enabled=NO;
    [_activatebtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
      [_devicebtn setTitle:@"Select" forState:UIControlStateNormal];
}
-(IBAction)edituserview:(id)sender
{   [self PasswordForUser];
    [self Employeeselect];
    [self SelectAllCustomer];
   
   _updatebtn.enabled=YES;
    _usertable.userInteractionEnabled=NO;
    optionIdentifier=2;
    _addview.hidden=NO;
    _navitem.title=@"Edit";
    _cancelbtn.enabled=NO;
   [_cancelbtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
     _resultdisplaylabel.hidden=YES;
    button = (UIButton *)sender;
    CGPoint center= button.center;
    CGPoint rootViewPoint = [button.superview convertPoint:center toView:self.usertable];
    NSIndexPath *textFieldIndexPath = [self.usertable indexPathForRowAtPoint:rootViewPoint];
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
    btnindex=textFieldIndexPath.row;
    listusermdl*usrmdl=(listusermdl *)[_userlistarray objectAtIndex:textFieldIndexPath.row];
   
    if ([usrmdl.DeviceType isEqualToString:@"1"]) {
        [_devicebtn setTitle:[_devicelistdict objectForKey:@"1"] forState:UIControlStateNormal];
    }
    else if ([usrmdl.DeviceType isEqualToString:@"2"]) {
        [_devicebtn setTitle:[_devicelistdict objectForKey:@"2"] forState:UIControlStateNormal];
    }
    else
    {
        [_devicebtn setTitle:[_devicelistdict objectForKey:@"3"] forState:UIControlStateNormal];
    }
    _usrnametextfld.text=usrmdl.username;
    //_pswdtextfld.text=usrmdl.pwd;
    if ([usrmdl.Activate isEqualToString:@"true"]) {
        [_activatebtnlbl setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
    }
    else
    {
        [_activatebtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
    }
    _titlenamelabel.hidden=NO;
    _type2btnlbl.enabled=YES;
   if([usrmdl.UserTypeId isEqualToString:@"2"])
   { _type2btnlbl.userInteractionEnabled=YES;
        NSLog(@"%@",usrmdl.empname);
      // _type2btnlbl.titleLabel.text=usrmdl.empname;
//_type1btnlbl.titleLabel.text=@"Employee            ";
       [_type2btnlbl setTitle:usrmdl.empname forState:UIControlStateNormal];
       [_type1btnlbl setTitle:@"Employee" forState:UIControlStateNormal];
       _titlenamelabel.text=_type1btnlbl.titleLabel.text;
      
   }
   else if ([usrmdl.UserTypeId isEqualToString:@"3"])
   {  _type2btnlbl.userInteractionEnabled=YES;
       // _type2btnlbl.titleLabel.text=usrmdl.customername;
       //_type1btnlbl.titleLabel.text=@"Customer            ";
       [_type2btnlbl setTitle:usrmdl.customername forState:UIControlStateNormal];
        [_type1btnlbl setTitle:@"Customer" forState:UIControlStateNormal];
        _titlenamelabel.text=_type1btnlbl.titleLabel.text;
     
   }
   else if ([usrmdl.UserTypeId isEqualToString:@"4"])
   {
       
       //_type2btnlbl.titleLabel.text=usrmdl.v;
       //_type1btnlbl.titleLabel.text=@"Customer            ";
       [_type1btnlbl setTitle:@"Vendor" forState:UIControlStateNormal];
        [_type2btnlbl setTitle:@"Select" forState:UIControlStateDisabled];
        _titlenamelabel.text=_type1btnlbl.titleLabel.text;
   }
   else if([usrmdl.UserTypeId isEqualToString:@"0"])
    {
        [_type1btnlbl setTitle:@"Select" forState:UIControlStateNormal];
        [_type2btnlbl setTitle:@"Select" forState:UIControlStateNormal];
         _titlenamelabel.text=@"";
    }
//   else if([usrmdl.UserTypeId isEqualToString:@"4"])
//   {
//       [_type1btnlbl setTitle:@"Select" forState:UIControlStateNormal];
//       [_type2btnlbl setTitle:@"Select" forState:UIControlStateNormal];
//       _titlenamelabel.text=@"";
//   }
    


}
-(IBAction)closeuserview:(id)sender
{
    _updatebtn.enabled=YES;
    _addview.hidden=YES;
    _usertable.userInteractionEnabled=YES;
//    [_type2btnlbl setTitle:@"" forState:UIControlStateNormal];
//    [_type1btnlbl setTitle:@"" forState:UIControlStateNormal];
}
-(IBAction)deleteusers:(id)sender
{
    
    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_usertable setEditing:NO animated:NO];
        [_usertable reloadData];
        
        
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_usertable setEditing:YES animated:YES];
        [_usertable reloadData];
        
    }
    
}

- (IBAction)usertype1btn:(id)sender {
    poptype=1;
    [self createpopover];
    [self UserTypeselect];
}

- (IBAction)usertype2btn:(id)sender {
    poptype=2;
      [self createpopover];
    //tyid=[[_Nametypeusrdict objectForKey:_type1btnlbl.titleLabel.text]integerValue];
    NSLog(@"ty%@",_type1btnlbl.titleLabel.text);
    if ([_type1btnlbl.titleLabel.text isEqualToString:@"Employee"]) {
        tyid=1;
    }
    else if (([_type1btnlbl.titleLabel.text isEqualToString:@"Customer"])){
        tyid=2;
    }
    else if (([_type1btnlbl.titleLabel.text isEqualToString:@"Vendor"])){
        tyid=3;
    }

    
    switch (tyid) {
        case 1:
            [self Employeeselect];
            break;
        case 2:
            [self SelectAllCustomer];
            break;
        case 3:
            break;
            
        default:
            break;
    }

}
-(IBAction)insertuser:(id)sender
{
    
    NSString*password= [_pswdtextfld.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
    
    if (rightsmodel.EditModule==0) {
        if (optionIdentifier==1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You dont have rights to add a record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else if(optionIdentifier==2)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You dont have rights to edit this record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else
    {
        

    if(optionIdentifier==1)
    {
        
        
        Validation *val=[[Validation alloc]init];
        int value1=[val isBlank:[_usrnametextfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        int value2=[val isBlank:[password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        
     
      
        
        if (value1==0||value2==0) {
            if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"User Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
            }
            else if(value2==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Password is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
            }
                   }
        
        
        else if([password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<5)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter atleast 5 characters for password field" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
            _pswdtextfld.text=@"";
        }
     else if ([_type1btnlbl.titleLabel.text isEqualToString:@"Select"]||[_type1btnlbl.titleLabel.text isEqualToString:@""])
        
        
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"User Type is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
            }
    else if ([_type2btnlbl.titleLabel.text isEqualToString:@"Select"]||[_type2btnlbl.titleLabel.text isEqualToString:@""])
            {
                
                NSString *name=[_titlenamelabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@ name is required",name] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert1 show];
                }
                
        

        
        else
        {
            [self UserLogmaininsert];
            _updatebtn.enabled=NO;

        [self InsertUsers];
       
            
        }
    }
    else if(optionIdentifier==2)
    {
        Validation *val=[[Validation alloc]init];
        int value1=[val isBlank:_usrnametextfld.text];
        int value2=[val isBlank:password];
        if (value1==0||value2==0) {
            if(value1==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"User Name is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
            }
            else if(value2==0)
            {
                UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Password is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert1 show];
            }
            
        }
        else if([password stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length<5)
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter atleast 5 characters for password field" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
            _pswdtextfld.text=@"";
        }

    else if ([_type1btnlbl.titleLabel.text isEqualToString:@"Select"]||[_type1btnlbl.titleLabel.text isEqualToString:@""])
            
            
        {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"User Type is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
     else  if ([_type2btnlbl.titleLabel.text isEqualToString:@"Select"]||[_type2btnlbl.titleLabel.text isEqualToString:@""])
        {
           
            NSString *name=[_titlenamelabel.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:[NSString stringWithFormat:@"%@ name is Required",name] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];

        }
        
        
        else
        {
            [self UserLogmainupdate];
            _updatebtn.enabled=NO;

        [self UpdateUsers];
        
        }
    }
    }
}
-(IBAction)cancel:(id)sender
{
    _usrnametextfld.text=@"";
    _pswdtextfld.text=@"";
    [_type1btnlbl setTitle:@"Select" forState:UIControlStateNormal];
    [_type2btnlbl setTitle:@"Select" forState:UIControlStateNormal];
    [_type2btnlbl setTitle:@"Select" forState:UIControlStateDisabled];
    [_activatebtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
    [_devicebtn setTitle:@"Select" forState:UIControlStateNormal];
}
- (IBAction)Selectdevice:(id)sender
{poptype=3;
    [self createpopover];
}
#pragma mark-IBActions
- (IBAction)activatebtn:(id)sender {
  
    actvatestring=@"activate";
    if(activate==1){
        [_activatebtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        activate=0;
       
        
        
        
    }
    else{
        [_activatebtnlbl setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        activate=1;
        
        
        
        
    }
    
    
}

#pragma mark-create popover
-(void)createpopover{
    if (poptype==1)
    {
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 230, 150)];
    
    popoverView.backgroundColor = [UIColor lightTextColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 230, 150)];
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
    
    
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(230, 150);
    
    //create a popover controller
    self.popOverController = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
        self.popOverController.popoverContentSize=CGSizeMake(230.0f, 150.0f);
        self.popOverController=_popOverController;

    
        [self.popOverController presentPopoverFromRect:_type1btnlbl.frame
                                                inView:self.addview
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];

    }
    if (poptype==2) {
        UIViewController* popoverContent = [[UIViewController alloc]
                                            init];
        UIView* popoverView = [[UIView alloc]
                               initWithFrame:CGRectMake(0, 0, 200, 250)];
        
        popoverView.backgroundColor = [UIColor lightTextColor];
        _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, 250)];
        _popOverTableView.delegate=(id)self;
        _popOverTableView.dataSource=(id)self;
        _popOverTableView.rowHeight= 32;
       
        
        [popoverView addSubview:_popOverTableView];
        popoverContent.view = popoverView;
        
        //resize the popover view shown
        //in the current view to the view's size
        popoverContent.contentSizeForViewInPopover = CGSizeMake(200, 250);
        
        //create a popover controller
        self.popOverController = [[UIPopoverController alloc]
                                  initWithContentViewController:popoverContent];
        self.popOverController.popoverContentSize=CGSizeMake(200.0f, 250.0f);
        self.popOverController=_popOverController;

        [self.popOverController presentPopoverFromRect:_type2btnlbl.frame
                                                inView:self.addview
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];
        
    }
    if (poptype==3)
    {
        UIViewController* popoverContent = [[UIViewController alloc]
                                            init];
        UIView* popoverView = [[UIView alloc]
                               initWithFrame:CGRectMake(0, 0, 230, 150)];
        
        popoverView.backgroundColor = [UIColor lightTextColor];
        _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 230, 150)];
        _popOverTableView.delegate=(id)self;
        _popOverTableView.dataSource=(id)self;
        _popOverTableView.rowHeight= 32;
        
        
        [popoverView addSubview:_popOverTableView];
        popoverContent.view = popoverView;
        
        //resize the popover view shown
        //in the current view to the view's size
        popoverContent.contentSizeForViewInPopover = CGSizeMake(230, 150);
        
        //create a popover controller
        self.popOverController = [[UIPopoverController alloc]
                                  initWithContentViewController:popoverContent];
        self.popOverController.popoverContentSize=CGSizeMake(230.0f, 150.0f);
        self.popOverController=_popOverController;
        [self.popOverController presentPopoverFromRect:_devicebtn.frame
                                                inView:self.addview
                              permittedArrowDirections:UIPopoverArrowDirectionUp
                                              animated:YES];
        
    }


 
}


#pragma mark-Searchbar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    _searchstring=_searchbar.text;
    //NSLog(@"search%@",searchstring);
    [self SearchUsers];
    [searchBar resignFirstResponder];
    
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self SelectAllUsers];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([_searchbar.text length]==0) {
        
        [self SelectAllUsers];
        // [searchBar resignFirstResponder];
        
        
    }
    //[searchBar resignFirstResponder];
    
    
}
#pragma mark-textfld delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField==_usrnametextfld)
    {
        NSUInteger newLength = [_usrnametextfld.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if(textField==_pswdtextfld)
    {
        NSUInteger newLength = [_pswdtextfld.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }

    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField==_usrnametextfld){
        Validation *val=[[Validation alloc]init];
        int value1=[val validatespecialcharacters:_usrnametextfld.text];
        if(value1==0)
        {
            
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid User Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
            
            
        }
        
        
        
    }

}




@end
