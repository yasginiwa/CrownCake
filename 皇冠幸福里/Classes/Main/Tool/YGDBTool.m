//
//  YGDBTool.m
//  皇冠幸福里
//
//  Created by YGLEE on 2018/5/1.
//  Copyright © 2018年 LiYugang. All rights reserved.
//

#import "YGDBTool.h"
#import "FMDB.h"
#import "YGHomeFrame.h"

@interface YGDBTool ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation YGDBTool

static id _instance;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedDBTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - 懒加载db
- (FMDatabase *)db
{
    if (_db == nil) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [documentPath stringByAppendingPathComponent:@"crowncake.db"];
        _db = [FMDatabase databaseWithPath:dbPath];
    }
    return _db;
}



- (instancetype)init
{
    if (self = [super init]) {
        NSString *homeFramesSql = @"CREATE TABLE IF NOT EXISTS 't_homeFrame' ('ID' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'homeProduct' BLOB, 'adsFrame' BLOB, 'bannerFrame' BLOB, 'rollFrame' BLOB, 'gridFrame' BLOB, 'rowFrame' BLOB, 'mapFrame' BLOB, 'bottomBtnFrame' BLOB, 'cellHeight' varchar(255))";
        
        [self.db open];
        [self.db executeUpdate:homeFramesSql];
        
        [self.db close];
    }
    return self;
}

- (void)addHomeFrame:(YGHomeFrame *)homeFrame
{
    [self.db open];
    
    NSValue *adsValue = [NSValue valueWithCGRect:homeFrame.adsFrame];
    NSValue *bannerValue = [NSValue valueWithCGRect:homeFrame.bannerFrame];
    NSValue *rollValue = [NSValue valueWithCGRect:homeFrame.rollFrame];
    NSValue *gridValue = [NSValue valueWithCGRect:homeFrame.gridFrame];
    NSValue *rowValue = [NSValue valueWithCGRect:homeFrame.rowFrame];
    NSValue *mapValue = [NSValue valueWithCGRect:homeFrame.mapFrame];
    NSValue *bottomBtnValue = [NSValue valueWithCGRect:homeFrame.bottomBtnFrame];
    NSData *homeProductData = [NSKeyedArchiver archivedDataWithRootObject:homeFrame.homeProduct];
    
    BOOL result = [self.db executeUpdate:@"INSERT INTO t_homeFrame(id, homeProduct, adsFrame, bannerFrame, rollFrame, gridFrame, rowFrame, mapFrame, bottomBtnFrame, cellHeight) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", NULL, homeProductData, bannerValue, adsValue, rollValue, gridValue, rowValue, mapValue, bottomBtnValue, @(homeFrame.cellHeight)];
    
    if (result) {
        NSLog(@"插表成功");
    } else {
        NSLog(@"插表失败");
    }
    
    [self.db close];
}

- (NSMutableArray *)getAllHomeFrame
{
    [self.db open];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    FMResultSet *res = [self.db executeQuery:@"SELECT * FROM t_homeFrame"];
    
    while ([res next]) {
        
        NSData *homeProductData = [res objectForColumn:@"homeProduct"];
        YGHomeFrame *homeFrame = [NSKeyedUnarchiver unarchiveObjectWithData:homeProductData];
        homeFrame.adsFrame =  [[res objectForColumn:@"adsFrame"] CGRectValue];
        homeFrame.bannerFrame = [[res objectForColumn:@"bannerFrame"] CGRectValue];
        homeFrame.rollFrame = [[res objectForColumn:@"rollFrame"] CGRectValue];
        homeFrame.gridFrame = [[res objectForColumn:@"gridFrame"] CGRectValue];
        homeFrame.rowFrame = [[res objectForColumn:@"rowFrame"] CGRectValue];
        homeFrame.mapFrame = [[res objectForColumn:@"mapFrame"] CGRectValue];
        homeFrame.bottomBtnFrame = [[res objectForColumn:@"bottomBtnFrame"] CGRectValue];
        homeFrame.cellHeight = [res doubleForColumn:@"cellHeight"];
        
        [dataArray addObject:homeFrame];
    }
    
    [self.db close];
    
    return dataArray;
}
@end
