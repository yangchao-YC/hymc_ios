//
//  FileModel.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "FileModel.h"
#import "FMResultSet.h"

@implementation FileModel
- (id)initWithDictionary:(NSDictionary *)dataDic dataid:(NSString *)dataid_
{
    if (self=[super init]) {
        self.dataid =     dataid_;
        self.filename =   [dataDic objectForKey:@"filename"];
        self.href =       [dataDic objectForKey:@"href"];
    }
    
    return self;
}

- (id)initWithFMResultSet:(FMResultSet *)rs
{
    if (self=[super init]) {
        self.dataid =     [rs objectForColumnName:@"dataid"];
        self.filename =   [rs objectForColumnName:@"filename"];
        self.href =       [rs objectForColumnName:@"href"];
    }
    
    return self;
}
@end
