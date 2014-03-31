//
//  FileModel.m
//  HuaYangApproval_ios
//
//  Created by jijeMac2 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "FileModel.h"

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
@end
