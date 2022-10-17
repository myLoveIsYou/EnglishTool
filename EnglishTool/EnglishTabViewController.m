//
//  EnglishTabViewController.m
//  EnglishTool
//
//  Created by MarkLiu on 2022/10/17.
//

#import "EnglishTabViewController.h"
#import "EnglishHomeViewController.h"
#import "EnglishRecoderViewController.h"
#import "EnglishSettingViewController.h"
@interface EnglishTabViewController ()

@end
#define UISCREEN_WINDTH [UIScreen mainScreen].bounds.size.width
#define UISCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]

@implementation EnglishTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    EnglishHomeViewController *homeVc = [[EnglishHomeViewController alloc]init];
    EnglishRecoderViewController *recoderVc= [[EnglishRecoderViewController alloc]init];
    EnglishSettingViewController *SettingVc = [[EnglishSettingViewController alloc]init];
//    [self addChildViewController:hom
    [self addChildViewController:homeVc selectImage:@"" normalImage:@"" title:@"翻译" tag:0];
    [self addChildViewController:recoderVc selectImage:@"RecordSelectImage" normalImage:@"RecordNormalImage" title:@"记录" tag:1];
    [self addChildViewController:SettingVc selectImage:@"MeSelectImage" normalImage:@"MeNormalImage" title:@"设置" tag:2];
    
    
    
}
-(void)addChildViewController:(UIViewController *)childController selectImage:(NSString *)selectImageName normalImage:(NSString *)normalImageName title:(NSString * )title  tag:(NSInteger)tag{
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:childController];
//    nav.navigationBar.translucent = NO;
    nav.navigationBar.hidden = YES;
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    nav.tabBarItem.image = [[UIImage imageNamed:normalImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.title =title;
    
//    nav.tabBarController.view.backgroundColor = [UIColor whiteColor];
    
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB(191, 191, 191,1)} forState:UIControlStateNormal];
    nav.tabBarItem.tag = tag;
    [self addChildViewController:nav];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
