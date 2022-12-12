//
//  EnglishHomeModel.m
//  EnglishTool
//
//  Created by MarkLiu on 2022/10/25.
//

#import "EnglishHomeModel.h"
#import <CommonCrypto/CommonDigest.h>
@implementation EnglishHomeModel
+ ( NSString *)get_md5Str:( NSString *)str {
    
    const char *myPasswd = [str UTF8String ];
    
    unsigned char mdc[ 16 ];
    
    CC_MD5 (myPasswd, ( CC_LONG ) strlen (myPasswd), mdc);
    
    NSMutableString *md5String = [ NSMutableString string ];
    
    for ( int i = 0 ; i< 16 ; i++) {
        
        [md5String appendFormat : @"%02x" ,mdc[i]];
        
    }
    
    return md5String;
}
+(NSString*)ImageWithText:(NSData *)EnglishimageData{
    NSString    *salt = [EnglishHomeModel  GetNumberNumberOne],
                *appid = @"20190618000308571",
                *key = @"FKQal3m_rfa8E5Taetcr",
                *fromLang = @"zh",
                *toLang = @"en",
                *mac = @"mac",
                *cuid = @"APICUID",
                *version = @"3",
                *paste = @"1";
    
//    UIImage *image = [UIImage imageNamed:@"1.jpg"];
//    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1)];
    NSData *imageData = EnglishimageData;
    NSString *imageMD5 = [imageData md5String];  // 这里用的YY的哈希方法，可以自己实现
    
    NSString *beforeSign = [NSString stringWithFormat:@"%@%@%@%@%@%@", appid, imageMD5, salt, cuid, mac, key];
    NSString *sign = [beforeSign md5String];

    
//    NSString *beforStr = [beforeSign stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    sign = [EnglishHomeModel get_md5Str:beforStr];
    
    AFHTTPSessionManager *httpSessionManager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"mutipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", @"text/json", nil];
    
    httpSessionManager.requestSerializer = requestSerializer;
    httpSessionManager.responseSerializer = responseSerializer;
    
    NSString *url = @"https://fanyi-api.baidu.com/api/trans/sdk/picture";
//    NSString* oneUrl = @"https://fanyi-api.baidu.com/api/trans/sdk/picture?from=zh&to=en&appid=20180905000111111&salt=1435660288&sign=bf7303b9be4191726f62c19115c9a165&cuid=APICUID&mac=mac&version=3";
    
//    NSString *oneUrl = [NSString stringWithFormat:@"https://fanyi-api.baidu.com/api/trans/sdk/picture?from=zh&to=en&appid=%@&salt=%@&sign=%@&cuid=APICUID&mac=mac&version=3",appid,salt,sign];

  
    
    
    
   NSString* oneUrl = @"https://webapi.xfyun.cn/v1/service/v1/ocr/general";
//
    NSDictionary*diaaaa=    @{
        @"language": @"en",
        @"location": @"false"
    };
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:diaaaa options:0 error:nil];

    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    NSString *base64Str = [strJson base64EncodedString];

    NSString*timeStr = [EnglishHomeModel getNowTimeTimestamp];

    NSString *sraaa = [NSString stringWithFormat:@"%@%@%@", @"e23ea6cf65d2786c60373576e200b88b", timeStr, base64Str];
    NSString *signaa = [sraaa md5String];

    NSString * XAppid=@"90053474",
             * XCurTime=timeStr,
             * XParam = base64Str,
             * CheckSum = signaa;
    NSString* baseImage64 = [EnglishimageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *aaa = [baseImage64 stringByURLDecode];
    NSDictionary *header = @{
                             @"X-Appid": XAppid,
                             @"X-CurTime":XCurTime,
                             @"X-Param":@"eyJsYW5ndWFnZSI6ImVuIiwibG9jYXRpb24iOiJmYWxzZSJ9",
                             @"X-CheckSum":CheckSum,
                             @"image":aaa
    };
    
    
//    [httpSessionManager GET:oneUrl parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//            }];
//    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//    NSString* totalPath = [documentPath stringByAppendingPathComponent:@"imageA"];
//    [imageData writeToFile:totalPath atomically:NO];
//    @{
//        @"from"  : fromLang,
//        @"to"    : toLang,
//        @"appid" : appid,
//        @"salt" : salt,
//        @"cuid" : cuid,
//        @"mac"  : mac,
//        @"sign" : sign,
//        @"version" : version,
//        @"paste" : paste
//    }
    
    NSURLSessionDataTask *task = [httpSessionManager POST:oneUrl parameters:header headers:header constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:imageData
//                                    name:@"imageA"
//                                fileName:totalPath
//                                mimeType:@"image/*"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [task resume];
    
    return @"";
}
+ (NSString *)GetNumberNumberOne

{
    static int kNumber = 10;
    NSString *sourceStr = @"0123456789";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
    
}

+(NSString *)getNowTimeTimestamp{
 NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
 [formatter setDateStyle:NSDateFormatterMediumStyle];
 [formatter setTimeStyle:NSDateFormatterShortStyle];
 [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
 //设置时区,这个对于时间的处理有时很重要
 NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
 [formatter setTimeZone:timeZone];
 NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
 NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
 return timeSp;
}
+(NSString *)getNowTimeTimestamp2{
 NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
 NSTimeInterval a=[dat timeIntervalSince1970];
 NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
 ;
return timeString;
}
@end
