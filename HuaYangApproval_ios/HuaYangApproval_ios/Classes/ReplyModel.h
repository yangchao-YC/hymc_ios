//
//  ReplyModel.h
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplyModel : NSObject

@property(strong,nonatomic)NSNumber *ID;
@property(strong,nonatomic)NSString *dynamicid;      //微博uuid


@property(strong,nonatomic)NSString *dataid;         //回复uuid
@property(strong,nonatomic)NSString *upicture;       //回复人员头像地址
@property(strong,nonatomic)NSString *uid;            //回复人员uuid
@property(strong,nonatomic)NSString *uname;          //回复人员名称
@property(strong,nonatomic)NSString *content;        //回复内容（html格式）
@property(strong,nonatomic)NSNumber *dateTime;       //回复时间戳
@property(strong,nonatomic)NSMutableArray *files;    //文件数组

- (id)initWithDictionary:(NSDictionary *)dataDic dynamicid:(NSString *)dynamicid_;
@end
