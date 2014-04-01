//
//  FileModel.h
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;

@interface FileModel : NSObject

@property(strong,nonatomic)NSNumber *ID;
@property(strong,nonatomic)NSString *dataid;      //数据库查询字段，标识属于哪个地方的文件

@property(strong,nonatomic)NSString *href;     //文件连接地址
@property(strong,nonatomic)NSString *filename; //文件名称
- (id)initWithDictionary:(NSDictionary *)dataDic dataid:(NSString *)dataid_;
- (id)initWithFMResultSet:(FMResultSet *)rs;
@end
