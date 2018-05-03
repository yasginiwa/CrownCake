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
    NSData *adsData = [NSKeyedArchiver archivedDataWithRootObject:adsValue];
    
    NSValue *bannerValue = [NSValue valueWithCGRect:homeFrame.bannerFrame];
    NSData *bannerData = [NSKeyedArchiver archivedDataWithRootObject:bannerValue];
    
    NSValue *rollValue = [NSValue valueWithCGRect:homeFrame.rollFrame];
    NSData *rollData = [NSKeyedArchiver archivedDataWithRootObject:rollValue];
    
    NSValue *gridValue = [NSValue valueWithCGRect:homeFrame.gridFrame];
    NSData *gridData = [NSKeyedArchiver archivedDataWithRootObject:gridValue];
    
    NSValue *rowValue = [NSValue valueWithCGRect:homeFrame.rowFrame];
    NSData *rowData = [NSKeyedArchiver archivedDataWithRootObject:rowValue];
    
    NSValue *mapValue = [NSValue valueWithCGRect:homeFrame.mapFrame];
    NSData *mapData = [NSKeyedArchiver archivedDataWithRootObject:mapValue];
    
    NSValue *bottomBtnValue = [NSValue valueWithCGRect:homeFrame.bottomBtnFrame];
    NSData *bottomBtnData = [NSKeyedArchiver archivedDataWithRootObject:bottomBtnValue];
    
    NSData *homeProductData = [NSKeyedArchiver archivedDataWithRootObject:homeFrame.homeProduct];
    
    BOOL result = [self.db executeUpdate:@"INSERT INTO t_homeFrame(id, homeProduct, adsFrame, bannerFrame, rollFrame, gridFrame, rowFrame, mapFrame, bottomBtnFrame, cellHeight) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);", NULL, homeProductData, adsData, bannerData, rollData, gridData, rowData, mapData, bottomBtnData, @(homeFrame.cellHeight)];
    
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
    
    NSMutableArray *frameArray = [NSMutableArray array];
    
    FMResultSet *res = [self.db executeQuery:@"SELECT * FROM t_homeFrame"];
    
    while ([res next]) {
        
        YGHomeFrame *homeFrame = [[YGHomeFrame alloc] init];
        
        NSData *homeProductData = [res objectForColumn:@"homeProduct"];
        homeFrame.homeProduct = [NSKeyedUnarchiver unarchiveObjectWithData:homeProductData];
        
        NSData *adsData = [res objectForColumn:@"adsFrame"];
        homeFrame.adsFrame = [[NSKeyedUnarchiver unarchiveObjectWithData:adsData] CGRectValue];
        
        NSData *bannerData = [res objectForColumn:@"bannerFrame"];
        homeFrame.bannerFrame = [[NSKeyedUnarchiver unarchiveObjectWithData:bannerData] CGRectValue];
        
        NSData *rollData = [res objectForColumn:@"rollFrame"];
        homeFrame.rowFrame = [[NSKeyedUnarchiver unarchiveObjectWithData:rollData] CGRectValue];
        
        NSData *gridData = [res objectForColumn:@"gridFrame"];
        homeFrame.gridFrame = [[NSKeyedUnarchiver unarchiveObjectWithData:gridData] CGRectValue];
        
        NSData *rowData = [res objectForColumn:@"rowFrame"];
        homeFrame.rowFrame = [[NSKeyedUnarchiver unarchiveObjectWithData:rowData] CGRectValue];
        
        NSData *mapData = [res objectForColumn:@"mapFrame"];
        homeFrame.mapFrame = [[NSKeyedUnarchiver unarchiveObjectWithData:mapData] CGRectValue];
                           
        NSData *bottomBtnData = [res objectForColumn:@"bottomBtnFrame"];
        homeFrame.bottomBtnFrame = [[NSKeyedUnarchiver unarchiveObjectWithData:bottomBtnData] CGRectValue];
        
        homeFrame.cellHeight = [res doubleForColumn:@"cellHeight"];
        
        [frameArray addObject:homeFrame];
    }
    
    [self.db close];
    
    return frameArray;
}
@end
