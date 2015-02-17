//
//  SmalltoolsViewController.m
//  Newproject
//
//  Created by GMSIndia1 on 1/1/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import "SmalltoolsViewController.h"

@interface SmalltoolsViewController ()

@end

@implementation SmalltoolsViewController

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
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];
    _addview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:226/255.0f blue:226/255.0f alpha:1.0f];

    _Tooltable.layer.borderWidth = 2.0;
   _Tooltable.layer.borderColor = [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor;
    _view1.backgroundColor = [UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    /*searchbar*/
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
    _searchbar.delegate = (id)self;
  _searchbar.tintColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    
    self.Tooltable.tableHeaderView =_searchbar;
    
    UISearchDisplayController* searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchbar contentsController:self];
    searchController.searchResultsDataSource = (id)self;
    searchController.searchResultsDelegate =(id)self;
    searchController.delegate = (id)self;
    _picimageview.layer.borderColor=[UIColor blackColor].CGColor;
    _picimageview.layer.borderWidth=2;
    _picimageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *pgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(handlePinch:)];
    pgr.delegate = (id)self;
    [_picimageview addGestureRecognizer:pgr];


}
- (void)handlePinch:(UITapGestureRecognizer *)pinchGestureRecognizer
{
    //handle pinch...
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
         imagechecker=2;
        
    _imagePicker
        =
        [[UIImagePickerController alloc] init];
        _imagePicker.delegate =(id) self;
        _imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        _imagePicker.showsCameraControls=YES;
        
        _imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        _imagePicker.allowsEditing = NO;
        
        // imagePicker.cameraCaptureMode=YES;
        
    
        [self presentViewController:_imagePicker animated:YES completion:nil];
        _newMedia = YES;
        }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_frmplan==1) {
        /*searchbar*/
        _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
        _searchbar.delegate = (id)self;
        _searchbar.tintColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
        
        self.Tooltable.tableHeaderView =_searchbar;
        
        UISearchDisplayController* searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchbar contentsController:self];
        searchController.searchResultsDataSource = (id)self;
        searchController.searchResultsDelegate =(id)self;
        searchController.delegate = (id)self;
        
        _searchstring=[_itemfromgp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        _searchbar.text=[_itemfromgp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self SearchSmallTools];
    }
    else
    {
        /*searchbar*/
        _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 220, 44)];
        _searchbar.delegate = (id)self;
        _searchbar.tintColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
        
        self.Tooltable.tableHeaderView =_searchbar;
        
        UISearchDisplayController* searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchbar contentsController:self];
        searchController.searchResultsDataSource = (id)self;
        searchController.searchResultsDelegate =(id)self;
        searchController.delegate = (id)self;
        _searchbar.text=@"";
        [self AllSkills];

       
    }

        _activitybtn.hidden=YES;
      _addview.userInteractionEnabled=YES;

   // [self SelectAllSmallTools];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Popover
-(void)createpopover{
    UIViewController* popoverContent = [[UIViewController alloc]
                                        init];
    
    UIView* popoverView = [[UIView alloc]
                           initWithFrame:CGRectMake(0, 0, 200, 120)];
    
    popoverView.backgroundColor = [UIColor whiteColor];
    _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, 120)];
    
    _popOverTableView.delegate=(id)self;
    _popOverTableView.dataSource=(id)self;
    _popOverTableView.rowHeight= 32;
    _popOverTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    
    
    // CGRect rect = frame;
    [popoverView addSubview:_popOverTableView];
    popoverContent.view = popoverView;
    
    //resize the popover view shown
    //in the current view to the view's size
    popoverContent.contentSizeForViewInPopover = CGSizeMake(200, 120);
    
    //create a popover controller
    
    self.popOverController = [[UIPopoverController alloc]
                              initWithContentViewController:popoverContent];
    
    //
    //    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    CGRect rect=CGRectMake(cell.bounds.origin.x+90, cell.bounds.origin.y+10, 50, 30);
    //    [self.popOverController presentPopoverFromRect:_disclsurelbl.bounds inView:self.view permittedArrowDirections:nil animated:YES];
    
    
    
    
    
    
    [self.popOverController presentPopoverFromRect:_subsearchbtnlbl.frame
                                            inView:self.addview
                          permittedArrowDirections:UIPopoverArrowDirectionUp
                                          animated:YES];
    
    
}

#pragma mark- WebService
-(void)SelectAllSmallTools{
    recordResults = FALSE;
    NSString *soapMessage;
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectAllSmallTools xmlns=\"https://vip.kontract360.com/\">\n"
                   
                   "</SelectAllSmallTools>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/SelectAllSmallTools" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)InsertSmallTools{
    webtype=1;
     NSString*unitcost=   [_costtxtfld.text stringByReplacingOccurrencesOfString:@"$" withString:@""];
    recordResults = FALSE;
    NSString *soapMessage;
    
    if (imagechecker==1) {
        _picturelocation=@"NoImage.png";
    }
    else
    {
        _picturelocation=@"";
    }

    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<InsertSmallTools xmlns=\"https://vip.kontract360.com/\">\n"
                   "<itemcode>%@</itemcode>\n"
                   "<description>%@</description>\n"
                   "<unitcost>%f</unitcost>\n"
                    "<qtyinstock>%f</qtyinstock>\n"
                   "<PictureLocation>%@</PictureLocation>\n"
                    "<STAllSubTypes>%d</STAllSubTypes>\n"
                   "</InsertSmallTools>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",@"abc",_destxtfld.text,[unitcost floatValue],[_stockinhandtxtfld.text floatValue],_picturelocation,checksub];
    NSLog(@"soapmsg%@",soapMessage);
      //  NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
    NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/InsertSmallTools" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)UpdateSmallTools{
    webtype=2;
    recordResults = FALSE;
    if (imagechecker==1) {
        _picturelocation=@"NoImage.png";
    }
    else
    {
        _picturelocation=@"";
    }

     NSString*unitcost=   [_costtxtfld.text stringByReplacingOccurrencesOfString:@"$" withString:@""];
    NSString *soapMessage;
    
Manpwr*pwrmdl=(Manpwr *)[_toolarray objectAtIndex:butnpath];
    if (createsub!=1) {
        if ([pwrmdl.allsubtype isEqualToString:@"true"]) {
            checksub=1;
        }
        else{
             checksub=0;
        }
    }
    else{
        createsub=0;
    }
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UpdateSmallTools xmlns=\"https://vip.kontract360.com/\">\n"
                   "<entryid>%d</entryid>\n"
                   "<itemcode>%@</itemcode>\n"
                   "<description>%@</description>\n"
                   "<unitcost>%f</unitcost>\n"
                   "<qtyinstock>%f</qtyinstock>\n"
                    "<PictureLocation>%@</PictureLocation>\n"
                    "<STAllSubTypes>%d</STAllSubTypes>\n"
                   "</UpdateSmallTools>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",pwrmdl.entryid,_codetxtfld.text,_destxtfld.text,[unitcost floatValue],[_stockinhandtxtfld.text floatValue],_picturelocation,checksub];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
       // NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UpdateSmallTools" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)DeleteSmallTools{
    webtype=3;
    
    recordResults = FALSE;
    NSString *soapMessage;
    
Manpwr*pwrmdl=(Manpwr *)[_toolarray objectAtIndex:path];
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<DeleteSmallTools xmlns=\"https://vip.kontract360.com/\">\n"
                   "<Entryid>%d</Entryid>\n"
                   "</DeleteSmallTools>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",pwrmdl.entryid];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/DeleteSmallTools" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)SearchSmallTools{
    recordResults = FALSE;
    NSString *soapMessage;
    
    
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SearchSmallTools xmlns=\"https://vip.kontract360.com/\">\n"
                   "<searchtext>%@</searchtext>\n"
                   "</SearchSmallTools>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_searchstring];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/SearchSmallTools" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)SelectAllSubtypeSmallTools{
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<SelectAllSubtypeSmallTools xmlns=\"https://vip.kontract360.com/\">\n"
                   "</SelectAllSubtypeSmallTools>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/SelectAllSubtypeSmallTools" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)AllSkills{
    webtype=1;
    recordResults = FALSE;
    NSString *soapMessage;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<AllSkills xmlns=\"https://vip.kontract360.com/\">\n"
                   
                   "</AllSkills>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n"];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/AllSkills" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)FetchAnyImage{
    
    recordResults = FALSE;
    NSString *soapMessage;
    _activitybtn.hidden=NO;
    [_activitybtn startAnimating];
     _addview.userInteractionEnabled=NO;
    //NSString *imagename=[NSString stringWithFormat:@"Photo_%@.png",_codetxtfld.text];
    NSString *type=@"SmallTools";
    
    //Equpmntmdl*eqmdl=(Equpmntmdl *)[_Assetarray objectAtIndex:path];
    //NSString*filename=eqmdl.PictureLocation;
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<FetchAnyImage xmlns=\"https://vip.kontract360.com/\">\n"
                   "<filename>%@</filename>\n"
                   "<type1>%@</type1>\n"
                   "</FetchAnyImage>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",picturelocation,type];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/FetchAnyImage" forHTTPHeaderField:@"Soapaction"];
    
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

-(void)Insertanyimage{
    recordResults = FALSE;
    NSString *soapMessage;
    
    NSString *imagename=[NSString stringWithFormat:@"Photo_%@.jpg",smallcode];
    // NSString *imagename=[NSString stringWithFormat:@"Newimage.jpg"];
    NSString *type=@"SmallTools";
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UploadAnyImage xmlns=\"https://vip.kontract360.com/\">\n"
                   "<f>%@</f>\n"
                   "<fileName>%@</fileName>\n"
                   "<type>%@</type>\n"
                   "<itemcode>%@</itemcode>\n"
                   "</UploadAnyImage>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_encodedString,imagename,type,smallcode];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UploadAnyImage" forHTTPHeaderField:@"Soapaction"];
    
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
-(void)UploadAnyImage{
    recordResults = FALSE;
    NSString *soapMessage;
    
    NSString *imagename=[NSString stringWithFormat:@"Photo_%@.jpg",_codetxtfld.text];
    // NSString *imagename=[NSString stringWithFormat:@"Newimage.jpg"];
    NSString *type=@"SmallTools";
    
    soapMessage = [NSString stringWithFormat:
                   
                   @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                   "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                   
                   
                   "<soap:Body>\n"
                   
                   "<UploadAnyImage xmlns=\"https://vip.kontract360.com/\">\n"
                   "<f>%@</f>\n"
                   "<fileName>%@</fileName>\n"
                   "<type>%@</type>\n"
                   "<itemcode>%@</itemcode>\n"
                   "</UploadAnyImage>\n"
                   "</soap:Body>\n"
                   "</soap:Envelope>\n",_encodedString,imagename,type,_codetxtfld.text];
    NSLog(@"soapmsg%@",soapMessage);
    
    
    // NSURL *url = [NSURL URLWithString:@"http://192.168.0.146/link/service.asmx"];
     NSURL *url = [NSURL URLWithString:@"https://vip.kontract360.com/service.asmx"];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [theRequest addValue: @"https://vip.kontract360.com/UploadAnyImage" forHTTPHeaderField:@"Soapaction"];
    
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
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],36,@"Create",@"iOS",extnalip,intrnalip,Udid,0];
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
-(void)UserLogmainupdate{
    
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
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],36,@"Edit",@"iOS",extnalip,intrnalip,Udid,0];
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
-(void)UserLogmaindelete{
    
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
                   "</soap:Envelope>\n",curntdate,[useridname integerValue],36,@"Delete",@"iOS",extnalip,intrnalip,Udid,0];
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
    if (webtype==1||webtype==2||webtype==3) {
        [self SelectAllSmallTools];
        _searchbar.text=@"";

        webtype=0;
    }
    [_Tooltable reloadData];
    [_popOverTableView reloadData];
    
    
    
}

#pragma mark-xml parser
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    if([elementName isEqualToString:@"faultcode"])
    {
        [_activitybtn stopAnimating];
        _activitybtn.hidden=YES;
        _addview.userInteractionEnabled=YES;
       
    }
    if([elementName isEqualToString:@"SelectAllSmallToolsResult"])
    {
        _toolarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"EntryId"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"ItemCode"])
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
    if([elementName isEqualToString:@"SubType"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"UnitCost"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"qtyinstock"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"STAllSubTypes"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }


   
    if([elementName isEqualToString:@"SearchSmallToolsResponse"])
    {
        _toolarray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"SelectAllSubtypeSmallToolsResult"])
    {
        _subtypearray=[[NSMutableArray alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    
    if([elementName isEqualToString:@"subtype"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"UpdateSmallToolsResult"])
    {
        
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
    }
    if([elementName isEqualToString:@"InsertSmallToolsResult"])
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
    if([elementName isEqualToString:@"AllSkillsResult"])
    {
        _skilldict=[[NSMutableDictionary alloc]init];
        _subtypearray=[[NSMutableArray alloc]init];
        _revskilldict=[[NSMutableDictionary alloc]init];
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"SkillId"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"SkillName"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    
    if([elementName isEqualToString:@"SmallCode"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    
    if([elementName isEqualToString:@"SmallPictureLocation"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }

    if([elementName isEqualToString:@"FetchAnyImageResponse"])
    {
        if(!_soapResults)
        {
            _soapResults = [[NSMutableString alloc] init];
        }
        recordResults = TRUE;
        
    }
    if([elementName isEqualToString:@"url"])
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
    if([elementName isEqualToString:@"EntryId"])
    {
        _Toolmdl=[[Manpwr alloc]init];
        
        recordResults = FALSE;
        
        _Toolmdl.entryid=[_soapResults integerValue];
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"ItemCode"])
    {
        
        recordResults = FALSE;
      _Toolmdl.itemcode=_soapResults;
        
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"Description"])
    {
        
        recordResults = FALSE;
        
      _Toolmdl.itemdescptn=_soapResults;
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"SubType"])
    {
        
        recordResults = FALSE;
      _Toolmdl.subtype=[_revskilldict objectForKey:_soapResults];;
                  _soapResults = nil;
    }
    if([elementName isEqualToString:@"qtyinstock"])
    {
        
         recordResults = FALSE;
        
        _Toolmdl.stckinhand=_soapResults;
        
        

         _soapResults = nil;
    }
    if([elementName isEqualToString:@"STAllSubTypes"])
    {
        
      recordResults = FALSE;
        _Toolmdl.allsubtype=_soapResults;
        [_toolarray addObject:_Toolmdl];
         _soapResults = nil;
    }

    if([elementName isEqualToString:@"UnitCost"])
    {
        
        recordResults = FALSE;
        
     _Toolmdl.unitcost=_soapResults;
     
        _soapResults = nil;
    }
    if([elementName isEqualToString:@"subtype"])
    {
        recordResults = FALSE;
        
        _soapResults = nil;
        
        
    }
   
    if([elementName isEqualToString:@"SmallPictureLocation"])
    {
        recordResults = FALSE;
        _Toolmdl.picturelocation=_soapResults;
           [_subtypearray addObject:_soapResults];
    _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"result"])
    {
        recordResults = FALSE;
        
        if ([_soapResults isEqualToString:@"Inserted Successfully"]) {
             msgstrg=_soapResults;
            if(imagechecker==1){
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:msgstrg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                _activitybtn.hidden=YES;
                [_activitybtn stopAnimating];
                _addview.userInteractionEnabled=YES;
                [self SelectAllSmallTools];
            }
            else{
                 [self Insertanyimage];
            }
           
            webtype=0;
           
            
        }
      else  if ([_soapResults isEqualToString:@"Updated Successfully"]) {
             msgstrg=_soapResults;
            if(imagechecker==1){
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:msgstrg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                _activitybtn.hidden=YES;
                [_activitybtn stopAnimating];
                _addview.userInteractionEnabled=YES;
                [self SelectAllSmallTools];
            }
            else{
              [self UploadAnyImage];
            }

            
            webtype=0;
           
            
        }
       else  if ([_soapResults isEqualToString:@"Already Exists"]) {
            
            msgstrg=_soapResults;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:msgstrg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            _activitybtn.hidden=YES;
            [_activitybtn stopAnimating];
            _addview.userInteractionEnabled=YES;
            
        }
       else  if ([_soapResults isEqualToString:@"Already In Use"]) {
            msgstrg=_soapResults;
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:msgstrg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }

        else if ([_soapResults isEqualToString:@"SmallTools Picture Updated"]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:msgstrg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            _activitybtn.hidden=YES;
            [_activitybtn stopAnimating];
                  _addview.userInteractionEnabled=YES;
            [self SelectAllSmallTools];
        }
        else {
            [self SelectAllSmallTools];
        }
        
        _soapResults = nil;
        
}
    if([elementName isEqualToString:@"SkillId"])
    {
        recordResults = FALSE;
        skill=_soapResults;
        _soapResults = nil;
        
    }
    if([elementName isEqualToString:@"SkillName"])
    {        recordResults =FALSE;
        
        [_skilldict setObject:skill forKey:_soapResults];
        [_revskilldict setObject:_soapResults forKey:skill];
        [_subtypearray addObject:_soapResults];
        _soapResults = nil;
        
        
    }
    if([elementName isEqualToString:@"SmallCode"])
    {
        recordResults =FALSE;
        smallcode=_soapResults;
   _soapResults = nil;
    }
    if([elementName isEqualToString:@"url"])
    {
        recordResults = FALSE;
        
        _activitybtn.hidden=YES;
        [_activitybtn stopAnimating];
        _addview.userInteractionEnabled=YES;
        NSData *data1=[_soapResults base64DecodedData];
        
        UIImage *image1=  [[UIImage alloc]initWithData:data1];
        
        //[NSData dataWithData:UIImagePNGRepresentation(image.image)];
        
        
        CGSize newsize=CGSizeMake(178, 97);
        UIGraphicsBeginImageContext(newsize);
        [image1 drawInRect:CGRectMake(0,0,newsize.width,newsize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        _picimageview.image=newImage;

        NSLog(@"img%@",image1);
        
        _soapResults = nil;


        
    }

}

#pragma mark - Table View datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==_Tooltable) {
        return [_toolarray count];
        
    }
    if (tableView==_popOverTableView) {
        return [_subtypearray count];
    }
    return YES;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
           cell.textLabel.font=[UIFont systemFontOfSize:12];
        
        if (tableView==_Tooltable) {
            [[NSBundle mainBundle]loadNibNamed:@"Smalltoolcell" owner:self options:nil];
            cell=_toolcell;
        }
    }
    if (tableView==_popOverTableView) {
        cell.textLabel.text=[_subtypearray objectAtIndex:indexPath.row];
    }
    if (tableView==_Tooltable) {
        Manpwr*materaialmdl=(Manpwr *)[_toolarray objectAtIndex:indexPath.row];
        _codelbl=(UILabel *)[cell viewWithTag:1];
        _codelbl.text=materaialmdl.itemcode;
        _deslbl=(UILabel *)[cell viewWithTag:2];
        _deslbl.text=materaialmdl.itemdescptn;
       // _typelbl=(UILabel *)[cell viewWithTag:3];
        //_typelbl.text=materaialmdl.subtype;
        _costlbl=(UILabel *)[cell viewWithTag:4];
        _costlbl.text= [NSString stringWithFormat:@"$%@",materaialmdl.unitcost];
        
        if ([materaialmdl.allsubtype isEqualToString:@"true"]) {
            _subtypebtnlbl.enabled=NO;
            
            [_subtypebtnlbl setTitle:@"All Sub Types" forState:UIControlStateNormal];
        }
        else{
            _subtypebtnlbl.enabled=YES;
            
            [_subtypebtnlbl setTitle:@"Sub Types" forState:UIControlStateNormal];
        }

        
    }
    return cell;
}

#pragma mark - Table View delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   if(tableView==_popOverTableView){
       
       //_subtypetxtfld.text=[_subtypearray objectAtIndex:indexPath.row];
         [_subsearchbtnlbl setTitle:[_subtypearray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    }
    
    
     [self.popOverController dismissPopoverAnimated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

       [self DeleteSmallTools];
       [_toolarray removeObject:indexPath];
        }
        
        
    }
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //alternating cell back ground color
    if(tableView==_Tooltable)
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

#pragma mark-Searchbar
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    _searchstring=_searchbar.text;
    //NSLog(@"search%@",searchstring);
    [self SearchSmallTools];
    [_searchbar resignFirstResponder];
    
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    // [self Allmanpwrarry];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if ([_searchbar.text length]==0) {
        
        [self SelectAllSmallTools];
        // [searchBar resignFirstResponder];
        
        
    }
   // [searchBar resignFirstResponder];
    
    
}


- (IBAction)addtoolbtn:(id)sender {
    imagechecker=1;
    _updatebtn.enabled=YES;
     butntype=1;
    _codetxtfld.text=@"";
    _resultdisplaylabel.hidden=YES;
    _destxtfld.text=@"";
    _subtypetxtfld.text=@"";
    _costtxtfld.text=@"";
    _stockinhandtxtfld.text=@"";
    [_subsearchbtnlbl setTitle:@"Select" forState:UIControlStateNormal];
  [_picimageview setImage:[UIImage imageNamed:@"mNoImage"]];
     _Tooltable.userInteractionEnabled=NO;
    _addview.hidden=NO;
    _cancelbtnlbl.enabled=YES;
    _navtitle.title=@"Create";
 [_checksubbtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];

}

- (IBAction)deletetoolbtn:(id)sender {
    
    butntype=3;
    

    if (self.editing) {
        [super setEditing:NO animated:NO];
        [_Tooltable setEditing:NO animated:NO];
        [_Tooltable  reloadData];
        
        
        
    }
    
    else{
        [super setEditing:YES animated:YES];
        [_Tooltable  setEditing:YES animated:YES];
        [_Tooltable  reloadData];
        
        
        
    }
    
    

}

- (IBAction)closebtn:(id)sender {
    _updatebtn.enabled=YES;
    _addview.hidden=YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)updatebtn:(id)sender {
    if (butntype==1) {
      
        [self UserLogmaininsert];
    }else if(butntype==2){
        [self UserLogmainupdate];
        
    }
    Rightscheck*rightsmodel=(Rightscheck *)[_userrightsarray objectAtIndex:0];
    
    if (rightsmodel.EditModule==0) {
        if (butntype==1) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You dont have rights to add a record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }else if(butntype==2)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"You dont have rights to edit this record" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }
    else
    {
 
    
    UIImage *imagename =_picimageview.image;
    // NSData *data = UIImagePNGRepresentation(imagename);
    
    NSData *data = UIImageJPEGRepresentation(imagename, 1.0);
    
    
    _encodedString = [data base64EncodedString];

    
    if (butntype==1) {
        if([_destxtfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length==0)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Description Field Is Required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
             _destxtfld.text=@"";
        }
//        else if ([_subsearchbtnlbl.titleLabel.text isEqualToString:@""]||[_subsearchbtnlbl.titleLabel.text isEqualToString:@"Select"]){
//            
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Subtype field is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            
//            [alert show];
//            
//        }

   else
  {
      _activitybtn.hidden=NO;
      [_activitybtn startAnimating];
      _addview.userInteractionEnabled=NO;
      _updatebtn.enabled=NO;
        [self InsertSmallTools];
     }
        
    }
    else if (butntype==2){
        if([_destxtfld.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length==0)
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Description Field Is Required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
             _destxtfld.text=@"";
        }
        else if ([_subsearchbtnlbl.titleLabel.text isEqualToString:@""]||[_subsearchbtnlbl.titleLabel.text isEqualToString:@"Select"]){
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Subtype field is required" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
            
        }

else
{
    _activitybtn.hidden=NO;
    [_activitybtn startAnimating];
    _updatebtn.enabled=NO;
        [self UpdateSmallTools];
}
        
    }
    }
}

- (IBAction)cancelbtn:(id)sender {
     [_checksubbtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
    _codetxtfld.text=@"";
    _resultdisplaylabel.hidden=YES;
    _destxtfld.text=@"";
    _subtypetxtfld.text=@"";
    _costtxtfld.text=@"";
    _stockinhandtxtfld.text=@"";
    [_subsearchbtnlbl setTitle:@"Select" forState:UIControlStateNormal];
    _picimageview.image=[UIImage imageNamed:@"mNoImage"];


}

- (IBAction)subsearchbtn:(id)sender {
   // butntype=1;
    [self createpopover];
    [self AllSkills];
}

- (IBAction)closeaddbtn:(id)sender {
    _addview.hidden=YES;
     _Tooltable.userInteractionEnabled=YES;
    _updatebtn.enabled=YES;
    
}
-(IBAction)closeimage:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Are you sure you want to delete this picture?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [alert show];
//     imagechecker=1;
//      _picimageview.image=[UIImage imageNamed:@"mNoImage"];
}

- (IBAction)editbtn:(id)sender {
    _picimageview.image=[UIImage imageNamed:@"mNoImage"];
    imagechecker=1;
    _updatebtn.enabled=YES;
    butntype=2;
     _Tooltable.userInteractionEnabled=NO;
    _cancelbtnlbl.enabled=NO;
    [_cancelbtnlbl setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    _resultdisplaylabel.hidden=YES;
    button = (UIButton *)sender;
    CGPoint center= button.center;
    CGPoint rootViewPoint = [button.superview convertPoint:center toView:self.Tooltable];
    NSIndexPath *textFieldIndexPath = [self.Tooltable indexPathForRowAtPoint:rootViewPoint];
    NSLog(@"textFieldIndexPath%d",textFieldIndexPath.row);
    butnpath=textFieldIndexPath.row;
    Manpwr*toolmdl=(Manpwr *)[_toolarray objectAtIndex:butnpath];
    _codetxtfld.text=toolmdl.itemcode;
    
    _destxtfld.text=toolmdl.itemdescptn;
    _subtypetxtfld.text=toolmdl.subtype;
    [_subsearchbtnlbl setTitle:toolmdl.subtype forState:UIControlStateNormal];
     _costtxtfld.text=[NSString stringWithFormat:@"$%@",toolmdl.unitcost];
     [_picimageview setImage:[UIImage imageNamed:@"mNoImage"]];
    _stockinhandtxtfld.text=toolmdl.stckinhand;
   picturelocation=toolmdl.picturelocation;
  
    _addview.hidden=NO;
    _navtitle.title=@"Edit";
    
    if ([toolmdl.allsubtype isEqualToString:@"true"]) {
        
        [_checksubbtnlbl setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        checksub=1;
    }
    else{
        [_checksubbtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        checksub=0;
    }
    if(toolmdl.picturelocation.length==0||[toolmdl.picturelocation isEqualToString:@"NoImage.png"]){
        imagechecker=1;
    }
    else{
        imagechecker=2;
          [self FetchAnyImage];
        
    }
}
- (IBAction)subtypebtn:(id)sender {
    moduleid=36;
    button = (UIButton *)sender;
    CGPoint center= button.center;
    CGPoint rootViewPoint = [button.superview convertPoint:center toView:self.Tooltable];
    NSIndexPath *textFieldIndexPath = [self.Tooltable indexPathForRowAtPoint:rootViewPoint];
    
    Manpwr*materaialmdl=(Manpwr *)[_toolarray objectAtIndex:textFieldIndexPath.row];
    
    self.subtypctrlr=[[RSTViewController alloc]initWithNibName:@"RSTViewController" bundle:nil];
    
    
    self.subtypctrlr.modalPresentationStyle = UIModalPresentationFormSheet;
    _subtypctrlr.equipmainid=materaialmdl.entryid;
    _subtypctrlr.moduleid=moduleid;
    [self presentViewController:self.subtypctrlr
                       animated:YES completion:NULL];
    
}
- (IBAction)checksubtypebtn:(id)sender {
    createsub=1;
    if (checksub==0) {
        [_checksubbtnlbl setImage:[UIImage imageNamed:@"cb_mono_on"] forState:UIControlStateNormal];
        checksub=1;
        
    }
    
    else{
        [_checksubbtnlbl setImage:[UIImage imageNamed:@"cb_mono_off"] forState:UIControlStateNormal];
        checksub=0;
        
    }

}

#pragma mark-Textfield Delegate


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    Validation*val=[[Validation alloc]init];
    if (textField==_costtxtfld) {
        int value2=[val isNumeric:_costtxtfld.text];
        if (value2==0) {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid unit cost" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
            
        }
        
    }
    
    if (textField==_stockinhandtxtfld) {
        int value12=[val isNumeric:_stockinhandtxtfld.text];
        if (value12==0) {
            UIAlertView *alert1=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid stock in hand" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
            
        }}
    
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.message isEqualToString:msgstrg]) {
         if (butntype==2){
             _addview.hidden=YES;
             _Tooltable.userInteractionEnabled=YES;
             _updatebtn.enabled=YES;
         }
        _codetxtfld.text=@"";
        
        _destxtfld.text=@"";
        _subtypetxtfld.text=@"";
        _costtxtfld.text=@"";
        _stockinhandtxtfld.text=@"";
        _updatebtn.enabled=YES;
        _soapResults = nil;
        [_subsearchbtnlbl setTitle:@"Select" forState:UIControlStateNormal];
        _picimageview.image=[UIImage imageNamed:@"mNoImage"];
        _searchbar.text=@"";

        
    }
    

    if ([alertView.message isEqualToString:@"Invalid unit cost"]) {
        
                _costtxtfld.text=@"";
        
    }
    
    
    if ([alertView.message isEqualToString:@"Invalid stock in hand"]) {
        
        
        _stockinhandtxtfld.text=@"";
        
    }
    if ([alertView.message isEqualToString:@"Are you sure you want to delete this picture?"])
    {
        
        if (buttonIndex==[alertView cancelButtonIndex]) {
            imagechecker=1;
            _picimageview.image=[UIImage imageNamed:@"mNoImage"];
        }
        else
        {
            
        }
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(textField==_codetxtfld)
    {
        NSUInteger newLength = [_codetxtfld.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
    }
    if(textField==_destxtfld)
    {
        NSUInteger newLength = [_destxtfld.text length] + [string length] - range.length;
        return (newLength > 100) ? NO : YES;
    }
    if(textField==_costtxtfld)
    {
        NSUInteger newLength = [_costtxtfld.text length] + [string length] - range.length;
        return (newLength > 9) ? NO : YES;
    }
    
    if(textField==_stockinhandtxtfld)
    {
        NSUInteger newLength = [_stockinhandtxtfld.text length] + [string length] - range.length;
        return (newLength > 9) ? NO : YES;
    }
    
    
    return YES;
}

#pragma mark-ImagePicker
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
   
    
    // [self.popoverController dismissPopoverAnimated:true];
    
    
    NSString *mediaType = [info
                           objectForKey:UIImagePickerControllerMediaType];
    
    
   // [[UIDevice currentDevice]beginGeneratingDeviceOrientationNotifications];
    
    
    
    
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        NSLog(@"dict%@",info);
        switch (image.imageOrientation) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                image = [UIImage imageWithCGImage:image.CGImage
                                            scale:image.scale
                                      orientation:UIImageOrientationUp]; // change this if you need another orientation
                break;
            case UIImageOrientationUp:
            case UIImageOrientationUpMirrored:
                // The image is already in correct orientation
                break;
        }
        

        _picimageview.image=nil;
        
         imagechecker=2;
        
       _picimageview.image =image;
       // [self dismissViewControllerAnimated:YES completion:nil];
           [self.navigationController dismissViewControllerAnimated: YES completion: nil];
        if (_newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    
    
    
}


-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
