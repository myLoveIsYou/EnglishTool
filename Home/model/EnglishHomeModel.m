//
//  EnglishHomeModel.m
//  EnglishTool
//
//  Created by MarkLiu on 2022/10/25.
//

#import "EnglishHomeModel.h"
@implementation EnglishHomeModel
+(NSString*)ImageWithText:(NSData *)EnglishimageData{
    NSString    *salt = @"1Basd1",
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
    
    
    AFHTTPSessionManager *httpSessionManager = [AFHTTPSessionManager manager];
    
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"mutipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/html", @"text/json", nil];
    
    httpSessionManager.requestSerializer = requestSerializer;
    httpSessionManager.responseSerializer = responseSerializer;
    
    NSString *url = @"https://fanyi-api.baidu.com/api/trans/sdk/picture";

    
    NSURLSessionDataTask *task = [httpSessionManager POST:url parameters:@{
        @"from"  : fromLang,
        @"to"    : toLang,
        @"appid" : appid,
        @"salt" : salt,
        @"cuid" : cuid,
        @"mac"  : mac,
        @"sign" : sign,
        @"version" : version,
        @"paste" : paste
    } headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [task resume];
    
    return @"";
}
@end
