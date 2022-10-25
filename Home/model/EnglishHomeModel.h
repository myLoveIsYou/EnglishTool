//
//  EnglishHomeModel.h
//  EnglishTool
//
//  Created by MarkLiu on 2022/10/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "NSData+YYAdd.h"
#import "NSString+YYAdd.h"
NS_ASSUME_NONNULL_BEGIN

@interface EnglishHomeModel : NSObject
+(NSString *)ImageWithText:(NSData*)EnglishimageData;
@end

NS_ASSUME_NONNULL_END
