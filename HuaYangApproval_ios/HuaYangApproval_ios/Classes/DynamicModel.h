//
//  DynamicModel.h
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;

@interface DynamicModel : NSObject

//本地缓存需要用到的字段
@property(strong,nonatomic)NSNumber *ID;
@property(strong,nonatomic)NSString *weiboType;   //微博类型 allmsg:动态更新，mymsg:我的动态，followmsg：我关注的动态

@property(strong,nonatomic)NSString *dataid;      //微博uuid
@property(strong,nonatomic)NSString *upicture;    //发布微博用户头像
@property(strong,nonatomic)NSString *uid;         //发布微博的人员uuid
@property(strong,nonatomic)NSString *authorid;    //发布微博的人员uuid，与uid相同
@property(strong,nonatomic)NSString *authorname;  //发布微博的人员名称
@property(strong,nonatomic)NSString *content;     //微博内容


@property(strong,nonatomic)NSNumber *dateTime;    //发布时间戳
@property(strong,nonatomic)NSNumber *praise;      //是否有赞
@property(strong,nonatomic)NSNumber *praiseNumber;//赞的次数
@property(strong,nonatomic)NSNumber *replysNumber;//回复数量
@property(strong,nonatomic)NSNumber *iscollect;   //是否收藏


@property(strong,nonatomic)NSMutableArray *replys;//回复数组
@property(strong,nonatomic)NSMutableArray *files; //文件数组

- (id)initWithDictionary:(NSDictionary *)dataDic weiboType:(NSString *)weiboType_;
- (id)initWithFMResultSet:(FMResultSet *)rs;
@end
