//
//  JCOnlineViewController.m
//  InstructionExample
//
//  Created by jamesczy on 15/7/27.
//  Copyright (c) 2015年 im360 immersive. All rights reserved.
//  本地视频界面

#import "JCOnlineViewController.h"
#import "UIView+Extension.h"
#import "UIBarButtonItem+Extension.h"
#import "JCCollectionCell.h"
#import "JC360Controller.h"
#import "JCNavigationController.h"
#import "JCLocalVideoController.h"
#import "JCConst.h"

#import "JCSaveArchiverTool.h"
#import "JCPlayPathInfo.h"

@interface JCOnlineViewController ()
@property (nonatomic ,strong)NSMutableArray *titleArray;
@property (nonatomic ,strong)NSMutableArray *titlePathArray;
//沙盒中存放的播放列表
@property (nonatomic ,strong)NSArray *playList;
@end

static NSString * const reuseIdentifier = @"Cell";

@implementation JCOnlineViewController
-(NSMutableArray *)titlePathArray
{
    if (_titlePathArray == nil) {
        _titlePathArray = [[NSMutableArray alloc]init];
    }
    return _titlePathArray;
}
-(NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray =[[NSMutableArray alloc]init];
    }
    return _titleArray;
}
-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(150, 200);
    
    //    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    //设置itme的左右两边间距
    layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);

    
    return [super initWithCollectionViewLayout:layout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self.clearsSelectionOnViewWillAppear = NO;
//    self.collectionView.backgroundColor = [UIColor whiteColor];
    //拉伸背景图片
    UIImage *image = [UIImage imageNamed:@"背景2"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(5,5,5,5) resizingMode:UIImageResizingModeStretch];
    self.collectionView.layer.contents = (id)image.CGImage;
    
    self.collectionView.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    // Register cell classes
    [self.collectionView registerClass:[JCCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //获取沙盒中的播放列表
//    self.playList = [JCSaveArchiverTool playPathInfo];
//    NSLog(@"%@",self.playList);
    UIButton *infoTitleButton = [[UIButton alloc]init];
    infoTitleButton.width = 150;
    infoTitleButton.height =30;
    
    [infoTitleButton setTitle:@"本地视频" forState:UIControlStateNormal];
    [infoTitleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    infoTitleButton.titleLabel.font = [UIFont systemFontOfSize:17];
    
    self.navigationItem.titleView = infoTitleButton;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navgationleftItem"] style:UIBarButtonItemStyleBordered target:self action:@selector(presentLeftMenuViewController:)];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单"
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:self
//                                                                            action:@selector(presentLeftMenuViewController:)];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];

    [self.titlePathArray removeAllObjects];
    [self.titleArray removeAllObjects];
    
    [self getFilenamelistOfType:@"png" fromDirPath:docsDir];
    [self getFilenamelistOfType:@"mp4" fromDirPath:docsDir];
    
//    JCLog(@"%@",self.titlePathArray);
//    JCLog(@"titleArray :%@",self.titleArray);
}
/**
 读取本地文件列表
 */
-(void)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)dirPath
{

    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath error:nil];
    
    for (NSString *filename in tmplist) {
        NSString *fullpath = [dirPath stringByAppendingPathComponent:filename];
        if ([self isFileExistAtPath:fullpath]) {
            if ([[filename pathExtension] isEqualToString:type]) {
                [self.titleArray  addObject:filename];
                [self.titlePathArray  addObject:[dirPath stringByAppendingPathComponent:filename]];
            }
        }
    }
    
}
-(BOOL)isFileExistAtPath:(NSString*)fileFullPath {
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//
//    return 1;
//}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.titleArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JCCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[JCCollectionCell alloc]init];
    }
    [cell setCellTitle:self.titleArray[indexPath.row] Name:self.titleArray[indexPath.row]];
//    NSString *imgName = [NSString stringWithFormat:@"缩略图%02d",indexPath.row + 1];
    NSString *imgTitle = [self.titleArray[indexPath.row] substringToIndex:[self.titleArray[indexPath.row] length] - 4];
    
//    JCLog(@"%@",imgName);
    cell.imageView.image = [UIImage imageNamed:imgTitle];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
//    JCLog(@"didSelectItemAtIndexPath:%@",self.titlePathArray);
    JCLocalVideoController *vc = [[JCLocalVideoController alloc]init];
    vc.videoURL = self.titlePathArray[indexPath.row];
    
    JCPlayPathInfo * info = [[JCPlayPathInfo alloc]init];
//    info.videoURL = vc.videoURL;
//    info.videoName = self.titleArray[indexPath.row];

//    [JCSaveArchiverTool addPlayPath:info];
    //发出视频被选中的通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[selectedPlayListKye] = info;
    [[NSNotificationCenter defaultCenter] postNotificationName:selectedPlayListName object:nil userInfo:userInfo];
    
    JCNavigationController *nav = [[JCNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
//    [nav pushViewController:vc animated:TRUE];
    
}

@end
