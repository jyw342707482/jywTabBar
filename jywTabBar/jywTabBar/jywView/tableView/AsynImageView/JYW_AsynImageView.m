//
//  JYW_AsynImageView.m
//  jywTabBar
//
//  Created by 姜益伟 on 2020/7/27.
//  Copyright © 2020 姜益伟. All rights reserved.
//

#import "JYW_AsynImageView.h"
#import "AFNetworking/AFNetworking.h"

@implementation JYW_AsynImageView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
  
        self.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.layer.borderWidth = 2.0;
        self.backgroundColor = [UIColor grayColor];
          
    }
    return self;
}

//重写placeholderImage的Setter方法
-(void)setPlaceholderImage:(UIImage *)placeholderImage
{
    if(placeholderImage != _placeholderImage)
    {
        _placeholderImage = placeholderImage;
        self.image = _placeholderImage;    //指定默认图片
    }
}
  
//重写imageURL的Setter方法
//文件目录说明：转载：https://www.jianshu.com/p/572edba1ff9d
-(void)setImageURL:(NSString *)imageURL
{
    if(imageURL != _imageURL)
    {
        self.image = _placeholderImage;    //指定默认图片
        _imageURL = imageURL;
    }
      
    if(self.imageURL)
    {
        //确定图片的缓存地址
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        NSString *docDir=[path objectAtIndex:0];
        NSString *tmpPath=[docDir stringByAppendingPathComponent:@"AsynImage"];
          
        NSFileManager *fm = [NSFileManager defaultManager];
        if(![fm fileExistsAtPath:tmpPath])
        {
            [fm createDirectoryAtPath:tmpPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSArray *lineArray = [self.imageURL componentsSeparatedByString:@"/"];
        self.fileName = [NSString stringWithFormat:@"%@/%@", tmpPath, [lineArray objectAtIndex:[lineArray count] - 1]];
          
        //判断图片是否已经下载过，如果已经下载到本地缓存，则不用重新下载。如果没有，请求网络进行下载。
        if(![[NSFileManager defaultManager] fileExistsAtPath:_fileName])
        {
            //下载图片，保存到本地缓存中
            [self loadImageAFNetWorking];
        }
        else
        {
            //本地缓存中已经存在，直接指定请求的网络图片
            self.image = [UIImage imageWithContentsOfFile:_fileName];
        }
    }
}
//afnetworking下载图片
//文件目录说明：转载：https://www.jianshu.com/p/572edba1ff9d
-(void)loadImageAFNetWorking{
    /* 下载地址 */
    NSURL *url = [NSURL URLWithString:_imageURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    /* 下载路径 */
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Announcement"];
    NSString *fPath = [path stringByAppendingPathComponent:url.lastPathComponent];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

    NSURLSessionDownloadTask *downloadTask =[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        /* 设定下载到的位置 */
        return [NSURL fileURLWithPath:fPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        
        if(error){
            NSLog(@"completionHandler----%@",error);
        }
        else{
            NSLog(@"下载完成，图片位置：%@",filePath);
            self.imageURL=fPath;
        }
    }];
    [downloadTask resume];
}

@end
