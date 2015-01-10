//
//  DetailViewController.m
//  School
//
//  Created by mac on 14-1-16.
//  Copyright (c) 2014年 EOrient. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
}


-(void)viewWillAppear:(BOOL)animated
{
    self.colorBar.backgroundColor =  self.color;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.navigationItem.title  = self.category1Name;
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableView:)
                                                 name:Category2ByCategory1Notification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadCollectionView:)
                                                 name:CourseByCategory2Notification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadCollectionView:)
                                                 name:CourseByCategory1Notification object:nil];
    //根据类别1查询类别2
    BusinessLogicStub *stub = [BusinessLogicStub sharedManager];
    [stub findCategory2ByCategory1:self.category1ID];
    //根据类别1查询课程
    [stub findCourseByCategory1:self.category1ID];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Category2ByCategory1Notification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CourseByCategory2Notification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CourseByCategory1Notification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark --重新加载表视图
-(void)reloadTableView:(NSNotification*)not
{
    id res = not.object;
    NSNumber *resultCodeObj = [res objectForKey:@"ResultCode"];
    if ([resultCodeObj integerValue] >=0)
    {
        self.tableData = [res objectForKey:@"Record"];
        [self.tableView reloadData];
    }
}

#pragma mark --重新加载集合视图
-(void)reloadCollectionView:(NSNotification*)not
{
    id res = not.object;
    NSNumber *resultCodeObj = [res objectForKey:@"ResultCode"];
    if ([resultCodeObj integerValue] >=0)
    {
        self.collectionData = [res objectForKey:@"Record"];
        [self.collectionView reloadData];
    }
    
}


#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowDict = [self.tableData objectAtIndex:row];
    cell.textLabel.text =  [rowDict objectForKey:@"name"];
    cell.imageView.image =  [UIImage imageNamed:self.category1Icon];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    NSDictionary *rowDict = [self.tableData objectAtIndex:row];
    id objID = [rowDict objectForKey:@"ID"];
    NSNumber* numberID = (NSNumber*)objID;
    
    //根据类别2查询课程列表
    BusinessLogicStub *stub = [BusinessLogicStub sharedManager];
    [stub findCourseByCategory2:[numberID integerValue]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    long count = [self.collectionData count] / COL_COUNT;
    
    if (([self.collectionData count] % COL_COUNT) != 0) {
        count++;
    }
    
    return count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return COL_COUNT;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    long index = indexPath.section * COL_COUNT + indexPath.row;
    
    if (index < [self.collectionData count]) {
        NSDictionary *dict = [self.collectionData objectAtIndex:(index)];
        
        cell.lblName.lineBreakMode =  NSLineBreakByTruncatingTail;
        
        cell.lblName.text = [dict objectForKey:@"name"];
        cell.lblTeacher.text = [NSString stringWithFormat:@"主讲人：%@",[dict objectForKey:@"Teacher"]];
        cell.lblPeopleNumber.text = [NSString stringWithFormat:@"主讲人：%@",[dict objectForKey:@"Teacher"]];
        cell.lblPeopleNumber.text = [NSString stringWithFormat:@"%@人学习",[dict objectForKey:@"PeopleNumber"]];
        cell.lblClassHour.text = [NSString stringWithFormat:@"共%@课时",[dict objectForKey:@"ClassHour"]];
        
        id objCharges = [dict objectForKey:@"Charges"];
        
        NSNumber* numCharges = (NSNumber*)objCharges;
        if ([numCharges floatValue] == 0.0) {
            cell.lblCharges.text = @"免费";
        } else {
            cell.lblCharges.text = [NSString stringWithFormat:@"%@元",numCharges];
        }
        
        //异步加载图片
        NSString *strImgkURL = [[NSString alloc] initWithFormat:@"%@/%@",Streaming_Media_URL_BASE,[dict objectForKey:@"Picture"]];
        NSURL *imgkURL = [NSURL URLWithString:[strImgkURL URLEncodedString]];
        
        dispatch_queue_t downloadQueue = dispatch_queue_create("Image.downloader",
                                                               NULL);
        dispatch_async(downloadQueue, ^{
            NSData *imgData = [NSData dataWithContentsOfURL:imgkURL];
            UIImage *img = [UIImage imageWithData:imgData];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = img;
            });
        });
        cell.hidden = NO;
    } else {
        cell.hidden = YES;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = [self.collectionData
                          objectAtIndex:(indexPath.section * COL_COUNT + indexPath.row)];
    
    NSString *url = [[NSString alloc] initWithFormat:@"%@%@",Streaming_Media_URL_BASE, [dict objectForKey:@"URL"]];
    
    NSLog(@"select dict URL : %@", url);
    [self play:url];
    
}

- (void)play:(NSString*) movieURL
{
    if (self.moviePlayerVC == nil) {
        
        self.moviePlayerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:movieURL]];
        
        self.moviePlayerVC.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        self.moviePlayerVC.moviePlayer.controlStyle =	MPMovieControlStyleFullscreen;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(playbackFinished4MoviePlayerViewController:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
    }
    
    [self presentMoviePlayerViewControllerAnimated:_moviePlayerVC];
}

- (void) playbackFinished4MoviePlayerViewController: (NSNotification*) notification
{
    NSLog(@"使用MPMoviePlayerViewController播放完成.");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_moviePlayerVC dismissMoviePlayerViewControllerAnimated];
    _moviePlayerVC = nil;
}



@end
