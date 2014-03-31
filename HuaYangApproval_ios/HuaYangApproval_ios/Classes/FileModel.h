//
//  FileModel.h
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject
@property(strong,nonatomic)NSString *href;     //文件连接地址
@property(strong,nonatomic)NSString *filename; //文件名称
- (id)initWithDictionary:(NSDictionary *)dataDic;
@end
