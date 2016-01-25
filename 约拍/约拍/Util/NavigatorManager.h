//
//  NavigatorManager.h
//  约拍
//
//  Created by apple on 16/1/24.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActionModel.h"

@interface NavigatorManager : NSObject

+ (void)navigatorBy:(ActionModel *)action viewController:(UIViewController *)viewController;

@end
