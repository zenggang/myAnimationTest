//
//  rootViewController.m
//  myAnimationTest
//
//  Created by gang zeng on 13-11-18.
//  Copyright (c) 2013年 gang zeng. All rights reserved.
//

#import "rootViewController.h"
#import "baseAnimationViewController.h"
#import "radarViewController.h"
@interface rootViewController ()
{
    
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *items;

@end

@implementation rootViewController

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
    self.title=@"AnimationTest";
    
    _tableView =[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] ];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    self.items = [NSMutableArray array];
	
	NSMutableArray *layersList = [NSMutableArray array];
    
    [layersList addObject:[baseAnimationViewController class]];
    [layersList addObject:[radarViewController class]];
    
	NSDictionary *layers = @{@"Core Animation": layersList};
    
	[self.items addObject:layers];
	
//	NSMutableArray *uiKitList = [NSMutableArray array];
//	NSDictionary *uiKits = @{@"UIKit Animation": uiKitList};
//	[self.items addObject:uiKits];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id) ObjectAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _items[indexPath.section];
    
    NSMutableArray *animationArray= [dic objectForKey:dic.allKeys[0]];
    return [animationArray objectAtIndex:indexPath.row];
}

#pragma mark UITableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _items.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dic = _items[section];
    NSMutableArray *animationArray= [dic objectForKey:dic.allKeys[0]];
    return animationArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [_items[section] allKeys][0];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentifier =@"animationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    Class clazz = [self ObjectAtIndexPath:indexPath];
	cell.textLabel.text = [clazz displayName];
    return cell;
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Class clazz = [self ObjectAtIndexPath:indexPath];
    id controller = [[clazz alloc] init];
	[self.navigationController pushViewController:controller animated:YES];
}


@end
