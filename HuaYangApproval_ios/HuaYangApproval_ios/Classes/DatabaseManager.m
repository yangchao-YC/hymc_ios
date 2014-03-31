//
//  DatabaseManager.m
//  HuaYangApproval_ios
//
//  Created by 李迪 on 14-3-31.
//  Copyright (c) 2014年 huayang. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDatabase.h"
#import "DynamicModel.h"
#import "ReplyModel.h"
#import "FileModel.h"

#define DOCUMENTPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

static NSString *userID = @"test";

static NSString *cacheDBName = @"cache.db";

@implementation DatabaseManager

//检查登陆用户的缓存文件夹是否存在，不存在就根据用户的userid创建
+ (void)checkCachePath
{
    BOOL isCacheExist = [[NSFileManager defaultManager] fileExistsAtPath:[DOCUMENTPATH stringByAppendingPathComponent:userID]];
    if (!isCacheExist) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[DOCUMENTPATH stringByAppendingPathComponent:userID] withIntermediateDirectories:YES attributes:nil error:nil];
    }
}

//检查表是否存在，不存在创建
+ (void)checkTableExist:(NSString *)tableName createTableSQL:(NSString *)sqlString
{
    NSString *checkTableSql = [NSString stringWithFormat:@"select count(*) from sqlite_master where tbl_name = '%@'",tableName];
    BOOL isTableExist = NO;
    FMDatabase *db = [FMDatabase databaseWithPath:[[DOCUMENTPATH stringByAppendingPathComponent:userID] stringByAppendingPathComponent:cacheDBName]];
    if ([db open]) {
        FMResultSet *rs = [db executeQuery:checkTableSql];
        while ([rs next]) {
            int count = [rs intForColumnIndex:0];
            if (count) {
                isTableExist = YES;
                break;
            }
        }
        [db close];
    }
    
    if (!isTableExist) {
        if ([db open]) {
            [db executeUpdate:sqlString];
            [db close];
        }
    }
    
}

#pragma mark ------保存动态列表
static NSString *dynamicSQL = @"CREATE TABLE dynamic (id INTEGER PRIMARY KEY AUTOINCREMENT, weiboType TEXT, dataid TEXT, upicture TEXT, uid TEXT, authorid TEXT, authorname TEXT, content TEXT, dateTime NUMERIC, praise BOOLEAN, praiseNumber INTEGER, replysNumber INTEGER, iscollect BOOLEAN);";
static NSString *replySQL = @"CREATE TABLE reply (id INTEGER PRIMARY KEY AUTOINCREMENT, dynamicid TEXT, dataid TEXT, upicture TEXT, uid TEXT, uname TEXT, content TEXT, dateTime NUMERIC);";
static NSString *fileSQL = @"CREATE TABLE file (id INTEGER PRIMARY KEY AUTOINCREMENT, dataid TEXT, href TEXT, filename TEXT);";

static NSString *dynamicSqlString = @"INSERT INTO dynamic (weiboType,dataid,upicture,uid,authorid,authorname,content,dateTime,praise,praiseNumber,replysNumber,iscollect) VALUES (?,?,?,?,?,?,?,?,?,?,?,?);";
NSString *replySqlString = @"INSERT INTO reply (dynamicid,dataid,upicture,uid,uname,content,dateTime) VALUES (?,?,?,?,?,?,?);";
NSString *fileSqlString = @"INSERT INTO file (dataid,href,filename) VALUES (?,?,?);";

+ (void)saveDynamicList:(NSArray *)dynamicList
{
    [[DatabaseManager class] checkCachePath];
    [[DatabaseManager class] checkTableExist:@"dynamic" createTableSQL:dynamicSQL];
    [[DatabaseManager class] checkTableExist:@"reply" createTableSQL:replySQL];
    [[DatabaseManager class] checkTableExist:@"file" createTableSQL:fileSQL];
    
    FMDatabase *db = [FMDatabase databaseWithPath:[[DOCUMENTPATH stringByAppendingPathComponent:userID] stringByAppendingPathComponent:cacheDBName]];
    if ([db open]) {
        [db beginTransaction];
        
        for (DynamicModel *dynamicModel in dynamicList) {
            [db executeUpdate:dynamicSqlString,dynamicModel.weiboType,dynamicModel.dataid,dynamicModel.upicture,dynamicModel.uid,dynamicModel.authorid,dynamicModel.authorname,dynamicModel.content,dynamicModel.dateTime,dynamicModel.praise,dynamicModel.praiseNumber,dynamicModel.replysNumber,dynamicModel.iscollect];
            
            for (FileModel *fileModel in dynamicModel.files) {
                [db executeUpdate:fileSqlString,fileModel.dataid,fileModel.href,fileModel.filename];
            }
            
            for (ReplyModel *replyModel in dynamicModel.replys) {
                [db executeUpdate:replySqlString,replyModel.dynamicid,replyModel.dataid,replyModel.upicture,replyModel.uid,replyModel.uname,replyModel.content,replyModel.dateTime];
                for (FileModel *fileModel in replyModel.files) {
                    [db executeUpdate:fileSqlString,fileModel.dataid,fileModel.href,fileModel.filename];
                }
            }
            
        }
        
        [db commit];
        [db close];
    }
}

#pragma mark ------通过微博类型查询动态列表
+ (id)getDynamicListByWeiboType:(NSString *)weiboType_
{
    [[DatabaseManager class] checkCachePath];
    
    NSString *sqlString = [NSString stringWithFormat:@"SELECT * FROM dynamic WHERE weiboType = '%@'",weiboType_];

    return nil;
}

@end
