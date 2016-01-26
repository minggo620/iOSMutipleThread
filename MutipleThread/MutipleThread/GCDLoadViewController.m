//
//  GCDLoadViewController.m
//  MutipleThread
//
//  Created by minggo on 16/1/26.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "GCDLoadViewController.h"

@interface GCDLoadViewController()
@property (weak, nonatomic) IBOutlet UIImageView *imageview1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UILabel *loadingLb;
- (IBAction)onClick:(id)sender;


@end

@implementation GCDLoadViewController{
    NSString *imgUrl1;
    NSString *imgUrl2;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    imgUrl1 = @"https://d262ilb51hltx0.cloudfront.net/fit/t/880/264/1*zF0J7XHubBjojgJdYRS0FA.jpeg";
    imgUrl2 = @"https://d262ilb51hltx0.cloudfront.net/fit/t/880/264/1*kE8-X3OjeiiSPQFyhL2Tdg.jpeg";
}

//后台执行
-(void)globalQueue{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self loadImageSource:imgUrl1];
    });
}
//UI线程执行(只是为了测试)
-(void)mainQueue{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadImageSource:imgUrl1];
    });
}

//一次性执行(常用来写单例)
-(void)dispatchOnce{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self loadImageSource:imgUrl1];
    });
}

//并发地执行循环迭代
-(void)dispatchApply{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t count = 10;
    dispatch_apply(count, queue, ^(size_t i) {
        NSLog(@"循环执行第%li次",i);
        //[self loadImageSource:imgUrl1];
    });
}

//后台执行：加载两张图片
-(void)globalQueue2{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image1 = [self loadImage:imgUrl1];
        UIImage *image2 = [self loadImage:imgUrl2];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageview1.image = image1;
            self.imageView2.image = image2;
        });
    });
}

//并发线程组
-(void)dispatchGroup{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    dispatch_async(queue, ^{
        
        dispatch_group_t group = dispatch_group_create();
        
        __block UIImage *image1 = nil;
        __block UIImage *image2 = nil;
        
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            image1 = [self loadImage:imgUrl1];
        });
        
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            image2 = [self loadImage:imgUrl2];
        });
        
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            self.imageview1.image = image1;
            self.imageView2.image = image2;
            
        });
    });
}


// 延迟执行
-(void)dispatchAfter{
    NSLog(@"Delay 2 seconds");
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self loadImageSource:imgUrl1];
    });
}

// 自定义dispatch_queue_t
-(void)defineDispatch{
    
    dispatch_queue_t urls_queue = dispatch_queue_create("minggo.app.com", NULL);
    dispatch_async(urls_queue, ^{
        [self loadImageSource:imgUrl1];
    });
}

-(void)loadImageSource:(NSString *)url{
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:imgData];
    if (imgData!=nil) {
        [self performSelectorOnMainThread:@selector(refreshImageView1:) withObject:image waitUntilDone:YES];
    }else{
        NSLog(@"there no image data");
    }
    
}

-(void)refreshImageView1:(UIImage *)image{
    [self.loadingLb setHidden:YES];
    [self.imageview1 setImage:image];
}

-(UIImage *)loadImage:(NSString *)url{
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:imgData];
    if (image!=nil) {
        return image;
    }else{
        NSLog(@"there no image data");
        return image;
    }

}

- (IBAction)onClick:(id)sender {
    [self.loadingLb setHidden:NO];
    
    [self.imageview1 setImage:nil];
    [self.imageView2 setImage:nil];
    
    int index = (int)((UIButton *)sender).tag;
    
    switch (index) {
        case 1:
            [self globalQueue];
            break;
        case 2:
            [self mainQueue];
            break;
        case 3:
            [self dispatchOnce];
            break;
        case 4:
            [self dispatchApply];
            break;
        case 5:
            [self globalQueue2];
            break;
        case 6:
            [self dispatchGroup];
            break;
        case 7:
            [self dispatchAfter];
            break;
        case 8:
            [self dispatchAfter];
            break;
            
        default:
            break;
    }
}
@end
