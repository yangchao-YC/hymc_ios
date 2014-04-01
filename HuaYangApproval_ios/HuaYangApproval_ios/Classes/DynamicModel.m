//
//  DynamicModel.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "DynamicModel.h"
#import "FileModel.h"
#import "ReplyModel.h"
#import "FMResultset.h"
#import "DatabaseManager.h"

@implementation DynamicModel
- (id)initWithDictionary:(NSDictionary *)dataDic weiboType:(NSString *)weiboType_
{
    if (self=[super init]) {
        self.weiboType =    weiboType_;
        self.dataid =       [dataDic objectForKey:@"dataid"];
        self.upicture =     [dataDic objectForKey:@"upicture"];
        self.uid =          [dataDic objectForKey:@"uid"];
        self.authorid =     [dataDic objectForKey:@"authorid"];
        self.authorname =   [dataDic objectForKey:@"authorname"];
        self.content =      [dataDic objectForKey:@"content"];
        
        self.dateTime =     [dataDic objectForKey:@"dateTime"];
        self.praise =       [dataDic objectForKey:@"praise"];
        self.praiseNumber = [dataDic objectForKey:@"praiseNumber"];
        self.replysNumber = [dataDic objectForKey:@"replysNumber"];
        self.iscollect =    [dataDic objectForKey:@"iscollect"];
        
        self.replys = [NSMutableArray array];
        NSArray *replys_ = [dataDic objectForKey:@"replys"];
        for (int i=0; i<replys_.count; i++) {
            NSDictionary *reply_ = [replys_ objectAtIndex:i];
            ReplyModel *replyModel = [[ReplyModel alloc] initWithDictionary:reply_ dynamicid:self.dataid];
            [self.replys addObject:replyModel];
        }
        
        self.files = [NSMutableArray array];
        NSArray *files_ = [dataDic objectForKey:@"files"];
        for (int i=0; i<files_.count; i++) {
            NSDictionary *file_ = [files_ objectAtIndex:i];
            FileModel *fileModel = [[FileModel alloc] initWithDictionary:file_ dataid:self.dataid];
            [self.files addObject:fileModel];
        }
    }
    
    return self;
}

- (id)initWithFMResultSet:(FMResultSet *)rs
{
    if (self=[super init]) {
        self.weiboType =    [rs objectForColumnName:@"weiboType"];
        self.dataid =       [rs objectForColumnName:@"dataid"];
        self.upicture =     [rs objectForColumnName:@"upicture"];
        self.uid =          [rs objectForColumnName:@"uid"];
        self.authorid =     [rs objectForColumnName:@"authorid"];
        self.authorname =   [rs objectForColumnName:@"authorname"];
        self.content =      [rs objectForColumnName:@"content"];
        
        self.dateTime =     [rs objectForColumnName:@"dateTime"];
        self.praise =       [rs objectForColumnName:@"praise"];
        self.praiseNumber = [rs objectForColumnName:@"praiseNumber"];
        self.replysNumber = [rs objectForColumnName:@"replysNumber"];
        self.iscollect =    [rs objectForColumnName:@"iscollect"];
        
        self.replys = [DatabaseManager getReplyListByDynamicID:self.dataid];
        
        self.files = [DatabaseManager getFileListByDataID:self.dataid];
        
    }
    
    return self;
}
@end
