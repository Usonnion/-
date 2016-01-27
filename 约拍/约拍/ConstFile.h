//
//  ConstFile.h
//  约拍
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 ArtisticPhoto. All rights reserved.
//

#ifndef ConstFile_h
#define ConstFile_h


#endif /* ConstFile_h */

#define Device_Height [[UIScreen mainScreen] bounds].size.height

#define getActualHeight(height)  (height * Device_Height / 678)

#define screenBounds [[UIScreen mainScreen] bounds]

typedef NS_ENUM(NSInteger, NavigatorType) {
    NavigatorTypeByType,
    NavigatorTypeByStore,
    NavigatorTypeToPayment
};
