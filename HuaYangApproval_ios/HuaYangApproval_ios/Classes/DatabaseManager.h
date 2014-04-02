//
//  DatabaseManager.h
//  HuaYangApproval_ios
//
//  Created by 李迪 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject

//保存动态列表
+ (void)saveDynamicList:(NSArray *)dynamicList;

//通过微博类型查询动态列表
+ (id)getDynamicListByWeiboType:(NSString *)weiboType_;

//通过微博id查询微博回复列表
+ (id)getReplyListByDynamicID:(NSString *)dynamicID_;

//通过 dataid 查询文件列表
+ (id)getFileListByDataID:(NSString *)dataID_;




@end
