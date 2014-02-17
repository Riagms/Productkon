//
//  DetailplanViewController.m
//  Newproject
//
//  Created by GMSIndia 2 on 13/02/14.
//  Copyright (c) 2014 GMSIndia1. All rights reserved.
//

#import "DetailplanViewController.h"

@interface DetailplanViewController ()

@end

@implementation DetailplanViewController

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
    _scaffoldtable.layer.borderWidth=4.0f;
    _scaffoldtable.layer.borderColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f].CGColor;
    _scaffoldtabletitleview.backgroundColor=[UIColor colorWithRed:234.0/255.0f green:244.0/255.0f blue:249.0/255.0f alpha:1.0f];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)closeplan:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)Scaffoldslection:(id)sender
{
    _scaffoldbtn.tintColor=[UIColor whiteColor];
     _fireproofingbtn.tintColor=[UIColor blackColor];
       _insulationbtn.tintColor=[UIColor blackColor];
    _scaffoldview.hidden=NO;
//    _fireproofingview.hidden=YES;
//    _insulationview.hidden=YES;
}
- (IBAction)InsulationSelection:(id)sender
{
    _insulationbtn.tintColor=[UIColor whiteColor];
     _scaffoldbtn.tintColor=[UIColor blackColor];
     _fireproofingbtn.tintColor=[UIColor blackColor];
   
//    _scaffoldview.hidden=YES;
//    _fireproofingview.hidden=YES;
//     _insulationview.hidden=NO;
}
- (IBAction)fireproofingselection:(id)sender
{
    _fireproofingbtn.tintColor=[UIColor whiteColor];
    _insulationbtn.tintColor=[UIColor blackColor];
     _scaffoldbtn.tintColor=[UIColor blackColor];
//    _fireproofingview.hidden=NO;
//    _scaffoldview.hidden=YES;
//    _insulationview.hidden=YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

#pragma mark-Tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_scaffoldtable)
    {
        return 5;
    }
       return YES;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier=@"mycell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        
        if(tableView==_scaffoldtable)
        {
            [[NSBundle mainBundle]loadNibNamed:@"scaffoldcell" owner:self options:nil];
            cell=_scaffoldcell;
        }
    }
    
    return cell;
    
}



@end
