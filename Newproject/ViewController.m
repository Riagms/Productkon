//
//  ViewController.m
//  Newproject
//
//  Created by GMSIndia1 on 6/14/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPClient.h"
#import "AFJSONRequestOperation.h"
//#import "ELCUIApplication.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize locationmanager,geocoder,placemark;

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   
	// Do any additional setup after loading the view, typically from a nib.
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.ViewController = self;
   
    [self getIPAddress];
    
//    NSString*newstring=@"newname";
//    NSString*astring=@"kontract360.com/service.asmx";
//    NSString*one=[NSString stringWithFormat:@"%@.%@", newstring , astring];
//    NSLog(@"%@",one);
    
    [[UIApplication sharedApplication]setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self prefersStatusBarHidden];
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    _scroll.frame=CGRectMake(0,0,1024, 724);
    [_scroll setContentSize:CGSizeMake(1024,800)];
    
   
    
    /*UDID*/
      NSString*newid=[[[UIDevice currentDevice]identifierForVendor]UUIDString];
       NSLog(@"UDID%@",newid);
    _logindevice=newid;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:newid forKey:@"UDID"];
    [defaults synchronize];
    
  //   UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:newid delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  //   [alert show];
    
    // NSUUID *deviceId;
    #if TARGET_IPHONE_SIMULATOR
    //deviceId = [NSUUID initWithUUIDString:@"UUID-STRING-VALUE"];
    #else
    //deviceId = [[UIDevice currentDevice].identifierForVendor];
     #endif
    NSUUID *myDevice = [NSUUID UUID];
    NSString *deviceUDID = myDevice.UUIDString;
   // UIAlertView*alert1=[[UIAlertView alloc]initWithTitle:@"" message:deviceUDID delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  //[alert1 show];
    [self externalipprocess];
    
    

}
//-(void)tuchsctn{
//    
//    if(_ModuleID==1){
//        [self UserRightsforparticularmoduleselect];
//    }
//    else{
//        if(_ModuleID==2){
//            [self UserRightsforparticularmoduleselect];
//        }
//        else{
//            if(_ModuleID==3){
//                [self UserRightsforparticularmoduleselect];
//            }
//            else{
//                if(_ModuleID==4){
//                    [self UserRightsforparticularmoduleselect];
//                }
//                else{
//                    if(_ModuleID==5){
//                        [self UserRightsforparticularmoduleselect];
//                    }
//                    else{
//                        if(_ModuleID==7){
//                            [self UserRightsforparticularmoduleselect];
//                        }
//                        else{
//                            
//                        }
//                        if(_ModuleID==8){
//                            [self UserRightsforparticularmoduleselect];
//                        }
//                        
//                        
//                    }
//                    
//                }
//                
//                
//                
//                
//            }
//            
//        }
//        
//        
//    }
//}


-(void)newaction{
    [self LogoutFromAll];
    
}

-(void)externalipprocess{
    
    NSURL *URL = [NSURL URLWithString:@"http://ip-api.com/json"];
    
    // Start Connection
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:URL];
    
    // Define the JSON header
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    
    // Set the Request
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"GET" path:@"" parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        NSString *myIP = [JSON valueForKey:@"query"];
        NSLog(@"IP: %@", myIP);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON){
        
        // Failed
        NSLog(@"error: %@", error.description);
        
    }];
    
    // Run the Request
    [operation start];
    
    
    // *******************************
    
    
    // Method 2 - External IP Without Geolocation
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *theURL = [[NSURL alloc] initWithString:@"http://ip-api.com/line/?fields=query"];
        NSString* myIP = [[NSString alloc] initWithData:[NSData dataWithContentsOfURL:theURL] encoding:NSUTF8StringEncoding];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // Manipulate the ip on the main queue
            NSLog(@"IP: %@",myIP);
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            [defaults setObject:myIP forKey:@"Externalip"];
            [defaults synchronize];
            

        });
    });

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _loginbtn.enabled=YES;
    _usernametxt.text=@"";
    _passwrdtxt.text=@"";
    _passwrdtxt.enabled=NO;

     locationmanager=[[CLLocationManager alloc]init];
    geocoder=[[CLGeocoder alloc]init];
    
    locationmanager.delegate=self;
    locationmanager.desiredAccuracy=kCLLocationAccuracyBest;
    [locationmanager startUpdatingLocation];
     [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

    if(!isKeyBoardHide) {
        // Dismiss Keyboard
        [self.view endEditing:YES];
        [[self view]endEditing:YES];
         [self disablesAutomaticKeyboardDismissal];
    } else {
        
        //keyboard is already hidden
    }

}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
      _passwrdtxt.enabled=NO;
    [_passwrdtxt resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}
- (void)keyboardWillShow: (NSNotification *) notif{
    isKeyBoardHide = NO;
}
- (void)keyboardWillHide: (NSNotification *) notif{
    isKeyBoardHide = YES;
}


- (void)keyboardDidHide: (NSNotification *) notif{
    isKeyBoardHide = YES;
}

//-(CLLocationManager *)locntnmangr{
//    if (_locntnmangr!=nil) {
//        return _locntnmangr;
//    }
//        return _locntnmangr;
//}
//- (void)startUpdatingLocation
//{
//    
//}
//startUpdatingLocation
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
#pragma mark- WebService
-(void)Loginselect{
       recordResults = FALSE;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:zone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
   // NSLog(@"Date %@",[formatter stringFromDate:date]);
    NSString*curntdate=[formatter stringFromDate:date];

    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<Loginselect xmlns=\"https://vip.kontract360.com/\">\n"
                   "<UserName>%@</UserName>\n"
                   "<Password>%@</Password>\n"
                   "<LTime>%@</LTime>\n"
                   "<DeviceNumber>%@</DeviceNumber>\n"
                   "<Location>%@</Location>\n"
                     "<Device>%@</Device>\n"
                   "</Loginselect>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_usernametxt.text,_passwrdtxt.text,curntdate,_logindevice,Naddress,@"Ipad"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
   // NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
  NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
       
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/Loginselect" forHTTPHeaderField:@"Soapaction"];
    
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

-(void)LogoutFromAll{
    recordResults = FALSE;
    
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<LogoutFromAll xmlns=\"https://vip.kontract360.com/\">\n"
                   "<UserName>%@</UserName>\n"
                   "<Password>%@</Password>\n"
                   "</LogoutFromAll>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_usernametxt.text,_passwrdtxt.text];
    NSLog(@"soapmsg%@",soapMessage);
    
    
      NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    //   NSURL *url = [NSURL URLWithString:@"http://192.168.0.1/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/LogoutFromAll" forHTTPHeaderField:@"Soapaction"];
    
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
    _loginbtn.enabled=YES;
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
    //NSDictionary *dictionary=[_xmlParser dictionaryWithValuesForKeys:[[NSArray alloc]initWithObjects:@"JobNumber", nil]];
    
    //  NSLog(@"dictioanry is %@",dictionary);
    
    
	[_xmlParser parse];
     
    
}
#pragma mark-xml parser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"LoginselectResponse"])
    {
       
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"records"])
    {
        
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"logintime"]){
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"device"]){
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"DeviceNumber"]){
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"result"]){
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
    if([elementName isEqualToString:@"records"]){
       
        recordResults = FALSE;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:_soapResults forKey:@"Userid"];
        [defaults synchronize];

        if([_soapResults isEqualToString:@"0"]){
            
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Username or Password" delegate:self
        cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            _loginbtn.enabled=YES;
        }
        else if([_soapResults isEqualToString:@"-1"]){
            
            NSString*msg=[NSString stringWithFormat:@"You are already login from %@(%@) at %@ ",devicename,devicenumber,logintime];
          UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:msg delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            _loginbtn.enabled=YES;
           
        }
       else if([_soapResults isEqualToString:@"-2"]){
           
           
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"User is not activated please contact admin" delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
           _loginbtn.enabled=YES;
            
        }

        else {
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:_soapResults forKey:@"UserNameId"];
            [defaults synchronize];

            //if (!self.hmeVCtrl) {
                self.hmeVCtrl=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
           // }
           self.hmeVCtrl.username=_usernametxt.text;
        
            [self.navigationController pushViewController:_hmeVCtrl animated:YES];

        }
        _soapResults = nil;
        devicename=@"";
        devicenumber=@"";
        logintime=@"";
        
    }
    
     if([elementName isEqualToString:@"logintime"]){
          recordResults = FALSE;
         NSArray*array=[_soapResults componentsSeparatedByString:@"+"];
         NSArray*array1=[[array objectAtIndex:0]componentsSeparatedByString:@"T"];
         NSLog(@"%@",[array1 objectAtIndex:0]);
        
         NSString *date1 =[array1 objectAtIndex:0];
         NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
         [dateFormat setDateFormat:@"yyyy-MM-dd"];
         NSDate *dates = [dateFormat dateFromString:date1];
         [dateFormat setDateFormat:@"MM-dd-yyy"];
         NSString *myFormattedDate = [dateFormat stringFromDate:dates];
        
         logintime=[NSString stringWithFormat:@"%@ %@",[array1 objectAtIndex:1],myFormattedDate];
         
         _soapResults = nil;
         
     }
    if([elementName isEqualToString:@"device"]){
        recordResults = FALSE;
        devicename=[_soapResults stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"DeviceNumber"]){
        recordResults = FALSE;
        devicenumber=[_soapResults stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"result"]){
        recordResults = FALSE;
        
        _usernametxt.text=@"";
        _passwrdtxt.text=@"";
       _soapResults = nil;
        
    }


}
- (IBAction)loginbtn:(id)sender {
    
   
    if(([_usernametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)||([_passwrdtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)){
        
        if([_usernametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0){
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Enter Username" delegate:self
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        }
       else if([_passwrdtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0){
        UIAlertView*alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Enter Password" delegate:self
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        }

        
    }
    else{
       [self resignFirstResponder];
        _loginbtn.enabled=NO;
  [self Loginselect];
        
//        if (!self.hmeVCtrl) {
//            self.hmeVCtrl=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
//        }
//        self.hmeVCtrl.username=_usernametxt.text;
//        [self.navigationController pushViewController:_hmeVCtrl animated:YES];
    }
  }


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(textField==_usernametxt)
    {
        _passwrdtxt.enabled=YES;

    }
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if(textField==_passwrdtxt)
    {
        [_passwrdtxt resignFirstResponder];
    }
    if(textField==_usernametxt)
    {
         [_usernametxt resignFirstResponder];
          _passwrdtxt.enabled=YES;
    }
   

}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView {
    NSArray *wins = [[UIApplication sharedApplication] windows];
    if ([wins count] > 1) {
        UIWindow *keyboardWindow = [wins objectAtIndex:1];
        keyboardWindow.hidden = YES;
    }
    return YES;
}

-(IBAction)toforgetaction:(id)sender
{
    _loginbtn.enabled=YES;
//    NSString *other1 = @"Other Button 1";
//    NSString *other2 = @"Other Button 2";
//    UIFont *changeFont = [UIFont fontWithName:@"Courier" size:12];
    
    
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                               @"Change My Password",
                             @"Logout from all other devices",
                               @"Cancel",
                               nil];
   // @"Logout from all other devices",
   // popup.actionSheetStyle=UIActionSheetStyleBlackOpaque;
    popup.backgroundColor=UIColor.blackColor;
     popup.tintColor=UIColor.blackColor;
   [popup showFromRect:_forgetbtn.frame inView:self.scroll animated:YES];
    
}
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for (UIView *subview in actionSheet.subviews) {
        subview.backgroundColor=[UIColor blackColor];
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            button.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
            [button setBackgroundImage:[UIImage imageNamed:@"action"] forState:UIControlStateNormal];
            button.titleLabel.textColor = [UIColor whiteColor];
            
            //[[button layer] setBorderWidth:1];
            //[[button layer] setCornerRadius:15];
            
        
        }
        if ([subview isKindOfClass:[UILabel class]]) {
            //[((UILabel *)subview) setFont:[UIFont boldSystemFontOfSize:14.f]];
            UILabel *label=(UILabel*)subview;
            label.textColor=[UIColor blackColor];
        }
    
    }
    //actionSheet.layer.backgroundColor=[UIColor yellowColor].CGColor;
}
//- (void)didPresentActionSheet:(UIActionSheet *)actionSheet {
//    UIView *contentView = actionSheet.superview;
//    UIView *popoverView = contentView.superview;
//    
//    UIView *chromeView;
//    for (UIView *v in [popoverView subviews]) {
//        if (v.subviews.count == 3) {
//            chromeView = v;
//            break;
//        }
//    }
//    
//    for (UIView *backgroundComponentView in [chromeView subviews]) {
//        backgroundComponentView.hidden = YES;
//        
//        CGRect componentFrame = backgroundComponentView.frame;  // add your view with this frame
//    }
//}
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            //if (!self.forgetVCtrl) {
                self.forgetVCtrl=[[forgetViewController alloc]initWithNibName:@"forgetViewController" bundle:nil];
            //}
            _forgetVCtrl.modalPresentationStyle = UIModalPresentationFormSheet;
            _forgetVCtrl.btnindex=buttonIndex;
                    [self presentViewController:_forgetVCtrl
                               animated:YES completion:NULL];
            break;
         case 1:
            if ([_usernametxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0) {
                UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your username" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [Alert show];
            }
            else if([_passwrdtxt.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length==0)
            {
                UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Please enter your password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [Alert show];
            }
            else
            {
            [self LogoutFromAll];
            }
//            if (!self.forgetVCtrl) {
//                self.forgetVCtrl=[[forgetViewController alloc]initWithNibName:@"forgetViewController" bundle:nil];
//            }
//            _forgetVCtrl.modalPresentationStyle = UIModalPresentationFormSheet;
//            _forgetVCtrl.btnindex=buttonIndex;
//            [self presentViewController:_forgetVCtrl
//                               animated:YES completion:NULL];

        default:
            break;
    }
    }

- (IBAction)lctnbtn:(id)sender {
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ([alertView.message isEqualToString:@"Invalid Username or Password"]) {
        _usernametxt.text=@"";
        _passwrdtxt.text=@"";

    }
    if ([alertView.message isEqualToString:@"User is not activated please contact admin"]) {
        _usernametxt.text=@"";
        _passwrdtxt.text=@"";
        
    }
}
//#pragma mark - CLLocationManagerDelegate
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"didFailWithError: %@", error);
//    UIAlertView *errorAlert = [[UIAlertView alloc]
//                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [errorAlert show];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
//    NSLog(@"didUpdateToLocation: %@", newLocation);
//    CLLocation *currentLocation = newLocation;
//    
//    if (currentLocation != nil) {
//        
//         NSLog(@"Resolving the Address");
//       // longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
//       // latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
//    }
//    
//    // Reverse Geocoding
//    NSLog(@"Resolving the Address");
//    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
//        if (error == nil && [placemarks count] > 0) {
//            placemark = [placemarks lastObject];
//           NSString*address= [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
//                                 placemark.subThoroughfare, placemark.thoroughfare,
//                                 placemark.postalCode, placemark.locality,
//                                 placemark.administrativeArea,
//                                 placemark.country];
//            NSLog(@"Address %@",address);
////            UIAlertView *alert = [[UIAlertView alloc]
////                                       initWithTitle:@"Location" message:address delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
////        [alert show];
//
//        } else {
//            NSLog(@"%@", error.debugDescription);
//       }
//    } ];
//    
//}
- (NSString *)getIPAddress {
    
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    Naddress= wifiAddress ? wifiAddress : cellAddress;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:Naddress forKey:@"Internalip"];
    [defaults synchronize];
    

    return addr ? addr : @"0.0.0.0";
    
}
-(BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

@end
