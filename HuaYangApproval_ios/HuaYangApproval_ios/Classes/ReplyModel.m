//
//  ReplyModel.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "ReplyModel.h"
#import "FileModel.h"
#import "FMResultSet.h"
#import "DatabaseManager.h"

@implementation ReplyModel
- (id)initWithDictionary:(NSDictionary *)dataDic dynamicid:(NSString *)dynamicid_
{
    if (self=[super init]) {
        self.dynamicid = dynamicid_;
        self.dataid =   [dataDic objectForKey:@"dataid"];
        self.upicture = [dataDic objectForKey:@"upicture"];
        self.uid =      [dataDic objectForKey:@"uid"];
        self.uname =    [dataDic objectForKey:@"uname"];
        self.content =  [dataDic objectForKey:@"content"];
        self.dateTime = [dataDic objectForKey:@"dateTime"];
        
        self.files =    [NSMutableArray array];
        NSArray *files_ = [dataDic objectForKey:@"files"];
        for (int i=0; i<files_.count; i++) {
            NSDictionary *file_ = [files_ objectAtIndex:i];
            FileModel *fileModel = [[FileModel alloc] initWithDictionary:file_ dataid:self.dataid];
            [self.files addObject:fileModel];
        }
    }
    
    return self;
}

- (id)initWithFMResultSet:(id)rs
{
    if (self=[super init]) {
        self.dynamicid = [rs objectForColumnName:@"dynamicid"];
        self.dataid =    [rs objectForColumnName:@"dataid"];
        self.upicture =  [rs objectForColumnName:@"upicture"];
        self.uid =       [rs objectForColumnName:@"uid"];
        self.uname =     [rs objectForColumnName:@"uname"];
        self.content =   [rs objectForColumnName:@"content"];
        self.dateTime =  [rs objectForColumnName:@"dateTime"];
        
        self.files = [DatabaseManager getFileListByDataID:self.dataid];
    }
    
    return self;
}
@end
