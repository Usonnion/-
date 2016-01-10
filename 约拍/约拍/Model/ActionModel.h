//
//  ActionModel.h
//  约拍
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseCellModel.h"

@interface ActionModel : BaseCellModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, assign) NSInteger actionId;
@property (nonatomic, strong) NSString *imageURL;



@end
