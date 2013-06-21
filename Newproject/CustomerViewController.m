//
//  CustomerViewController.m
//  Newproject
//
//  Created by GMSIndia1 on 6/14/13.
//  Copyright (c) 2013 GMSIndia1. All rights reserved.
//

#import "CustomerViewController.h"

@interface CustomerViewController ()

@end

@implementation CustomerViewController

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
   // _customertable.rowHeight=50;
    [_customertable reloadData];
    _scrollview.frame=CGRectMake(0, 0, 1024,708);
    [_scrollview setContentSize:CGSizeMake(1024,760)];
     _popoverArry=[[NSMutableArray alloc]initWithObjects:@"Contact Info",@"Sales Rep Info",nil];
    _view1.backgroundColor=[UIColor colorWithRed:210.0/255.0f green:230.0/255.0f blue:450.0/255.0f alpha:1.0f];
    
    self.navbar.tintColor=[UIColor colorWithRed:227.0/255.0f green:240.0/255.0f blue:247.0/255.0f alpha:1.0f];
    
    _customertable.layer.borderWidth = 2.0;
  _customertable.layer.borderColor = [UIColor colorWithRed:210.0/255.0f green:230.0/255.0f blue:450.0/255.0f alpha:1.0f].CGColor;
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
    _newcustmrview.hidden=YES;


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    UIBarButtonItem*addbtn=[[UIBarButtonItem alloc]initWithTitle:@"ADD" style:UIBarButtonItemStylePlain target:self action:@selector(addaction)];
    UIBarButtonItem*editbtn=[[UIBarButtonItem alloc]initWithTitle:@"DELETE" style:UIBarButtonItemStylePlain target:self action:@selector(editaction)];
    NSArray*barbutns=[[NSArray alloc]initWithObjects:addbtn,editbtn, nil];
    [self.navigationItem setRightBarButtonItems:barbutns animated:YES];
    _newcustmrview.hidden=YES;
    
    
}
-(void)addaction
{
    _newcustmrview.hidden=NO;
}
-(void)editaction
{
    if ([self.customertable isEditing]) {
        // If the tableView is already in edit mode, turn it off. Also change the title of the button to reflect the intended verb (‘Edit’, in this case).
        
        [self.customertable setEditing:NO animated:YES];
        //[_Editbtn setTitle:@"Edit"forState:UIControlStateNormal];
    }
    else {
        // [_Editbtn setTitle:@"Done"forState:UIControlStateNormal];
        
        // Turn on edit mode
        
        [self.customertable setEditing:YES animated:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    // Return the number of rows in the section.
    if(tableView==_popOverTableView)
    {
        return [_popoverArry count];
    }
     if(tableView==_customertable)
    {
    
    return 10;
    }
    
    return YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mycell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if(tableView==_customertable)
        {
        [[NSBundle mainBundle]loadNibNamed:@"Customercell" owner:self options:nil];
        cell=_customercell;

        
    }
    }
        //cell.textLabel.text=@"Customer Name";
    if(tableView==_popOverTableView)
    {  cell.textLabel.font = [UIFont fontWithName:@"Helvetica Neue Light" size:12];
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.text=[_popoverArry objectAtIndex:indexPath.row];
    }
    if(tableView==_customertable)
    {
        
    }

    



    return cell;
    

}
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //alternating cell back ground color
    if (indexPath.row%2 == 0) {
        [cell setBackgroundColor:[UIColor whiteColor]];

    
    }else
    {
        
        //[cell setBackgroundColor:[UIColor colorWithRed:247.0/255.0f green:247.0/255.0f blue:247.0/255.0f alpha:1.0f]];
            [cell setBackgroundColor:[UIColor colorWithRed:227.0/255.0f green:240.0/255.0f blue:247.0/255.0f alpha:1.0f]];        
           }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==_customertable) {
        // CGRect frame = [_popOverTableView cellForRowAtIndexPath:indexPath].frame;
       // poptype=5;
        UIViewController* popoverContent = [[UIViewController alloc]
                                            init];
        
        UIView* popoverView = [[UIView alloc]
                               initWithFrame:CGRectMake(0, 0, 120, 70)];
        
        popoverView.backgroundColor = [UIColor whiteColor];
        _popOverTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 120, 70)];
        
        _popOverTableView.delegate=(id)self;
        _popOverTableView.dataSource=(id)self;
        _popOverTableView.rowHeight= 32;
        _popOverTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLineEtched;
        
        
        // CGRect rect = frame;
        [popoverView addSubview:_popOverTableView];
        popoverContent.view = popoverView;
        
        //resize the popover view shown
        //in the current view to the view's size
        popoverContent.contentSizeForViewInPopover = CGSizeMake(120, 70);
        
        //create a popover controller
        
        self.popOverController = [[UIPopoverController alloc]
                                  initWithContentViewController:popoverContent];
        
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        CGRect rect=CGRectMake(cell.bounds.origin.x+90, cell.bounds.origin.y+10, 50, 30);
        [self.popOverController presentPopoverFromRect:rect inView:cell permittedArrowDirections:nil animated:YES];
        
        //    [self.popOverController presentPopoverFromRect:rect
        //                                            inView:self.leadTable
        //                          permittedArrowDirections:UIPopoverArrowDirectionLeft
        //                                          animated:YES];
        //
        //  [self MenuAction];
    }
    
    if (tableView==_popOverTableView) {
        if (indexPath.row==0) {
            if (!self.cntctVctrl) {
                self.cntctVctrl=[[ContactInfoViewController alloc]initWithNibName:@"ContactInfoViewController" bundle:nil];
            }
            [self.navigationController pushViewController:self.cntctVctrl animated:YES];
            
        }
        
        if (indexPath.row==1) {
            
            if (!self.salesVCtrl) {
                self.salesVCtrl=[[SalesRepInfoViewController alloc]initWithNibName:@"SalesRepInfoViewController" bundle:nil];
            }
            [self.navigationController pushViewController:self.salesVCtrl animated:YES];
            
            
            
        }
    
        [self.popOverController dismissPopoverAnimated:YES];
        
        
        
    }
    
}
- (IBAction)editcellbtn:(id)sender
{
    _newcustmrview.hidden=NO;
}
-(IBAction)closetheView:(id)sender
{
    self.newcustmrview.hidden=YES;
}


@end
