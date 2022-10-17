//
//  AppDelegate.m
//  EnglishTool
//
//  Created by MarkLiu on 2022/10/11.
//

#import "AppDelegate.h"
#import "EnglishTabViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    EnglishTabViewController *Vc = [[EnglishTabViewController alloc]init];
    self.window.rootViewController = Vc;
    
    return YES;
}




@end
