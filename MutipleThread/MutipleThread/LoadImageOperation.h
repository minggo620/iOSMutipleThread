//
//  LoadImageOperation.h
//  MutipleThread
//
//  Created by minggo on 16/1/26.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LoadImageDelegate <NSObject>

-(void)loadImageFinish:(UIImage *) image;

@end

@interface LoadImageOperation : NSOperation

@property(nonatomic,copy) NSString *imgUrl;
@property(nonatomic,retain) id<LoadImageDelegate> loadDelegate;

@end
