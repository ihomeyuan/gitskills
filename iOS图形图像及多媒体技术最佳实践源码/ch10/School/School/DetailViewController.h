//
//  DetailViewController.h
//  School
//
//  Created by mac on 14-1-16.
//  本书网站：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  智捷iOS课堂微信公共账号：智捷iOS课堂
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "DetailCollectionViewCell.h"
#import "NSString+URLEncoding.h"
#import "BusinessLogicStub.h"

//一行中列数
#define COL_COUNT 3

@interface DetailViewController : UIViewController
    <UITableViewDataSource,UITableViewDelegate,
    UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) int  category1ID;
@property (nonatomic, strong) NSString*  category1Name;
@property (nonatomic, strong) NSString*  category1Icon;

@property (nonatomic,strong) UIColor *color;

@property (weak, nonatomic) IBOutlet UIView *colorBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *tableData;
@property (nonatomic, strong) NSArray *collectionData;

@property (nonatomic, strong) MPMoviePlayerViewController * moviePlayerVC;

@end
