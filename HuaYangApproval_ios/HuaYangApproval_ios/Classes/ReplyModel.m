//
//  ReplyModel.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "ReplyModel.h"
#import "FileModel.h"

@implementation ReplyModel
- (id)initWithDictionary:(NSDictionary *)dataDic
{
    if (self=[super init]) {
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
            FileModel *fileModel = [[FileModel alloc] initWithDictionary:file_];
            [self.files addObject:fileModel];
        }
    }
    
    return self;
}
@end
