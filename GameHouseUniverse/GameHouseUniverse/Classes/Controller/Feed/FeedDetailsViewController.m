//
//  FeedDetailsViewController.m
//  GameHouseUniverse
//
//  Created by stanislav on 30/10/14.
//  Copyright (c) 2014 stanislav. All rights reserved.
//

#import "FeedDetailsViewController.h"

@interface FeedDetailsViewController ()

@end

@implementation FeedDetailsViewController
@synthesize  contentTable;


- (void) dealloc{
    
    NSLog(@"FeedDetailsViewController dealloc");
    self.contentTable = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.contentTable.delegate = self;
    self.contentTable.dataSource = self;
    
    [self updateElement];
}

- (void) viewDidAppear:(BOOL)animated{
    
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

//===============================================================================================================
#pragma mark -
#pragma mark - Screen Operation
//===============================================================================================================
- (void) setUpElement{
    
    
}
- (void) updateElement{
    
    
}
//===============================================================================================================
#pragma mark -
#pragma mark - IBAction SetUp
//===============================================================================================================
- (IBAction)didPressMenuBtn:(id)sender{
    
}
- (IBAction)didPressMessageBtn:(id)sender{
    
}
- (IBAction)didPressSearchBtn:(id)sender{
    
}
- (IBAction)didPressCancelPostBtn:(id)sender{
    
}
- (IBAction)didPresPostBtn:(id)sender{
    
}
- (IBAction)didPressDeletePostBtn:(id)sender{
    
    
}
//===============================================================================================================
#pragma mark -
#pragma mark - TableView delegate and Data Source
//===============================================================================================================

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return -1;
}
- (NSInteger) tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44.0f;
}
- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return nil;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}
- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    return -1;
}

@end
