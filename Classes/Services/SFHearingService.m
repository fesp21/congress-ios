//
//  SFHearingService.m
//  Congress
//
//  Created by Jeremy Carbaugh on 7/30/13.
//  Copyright (c) 2013 Sunlight Foundation. All rights reserved.
//

#import "SFHearingService.h"
#import "SFCongressApiClient.h"
#import <ISO8601DateFormatter.h>

@implementation SFHearingService

+ (void)hearingsForCommitteeId:(NSString *)committeeId completionBlock:(void(^)(NSArray *hearings))completionBlock
{
    
    [[SFCongressApiClient sharedInstance] getPath:@"hearings"
                                       parameters:@{@"committee_id": committeeId,
//                                                    @"occurs_at__gte": now,
                                                    @"order": @"occurs_at__desc",
                                                    @"fields": @"committee,occurs_at,congress,chamber,dc,room,description,bill_ids,url,hearing_type"}
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             NSArray *hearings = [self convertResponseToHearings:responseObject];
                                             completionBlock(hearings);
                                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             completionBlock(nil);
                                          }];
}

+ (void)recentHearingsWithCompletionBlock:(void(^)(NSArray *hearings))completionBlock
{
    ISO8601DateFormatter *dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime:YES];
    [dateFormatter setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
    
    [[SFCongressApiClient sharedInstance] getPath:@"hearings"
                                       parameters:@{@"occurs_at__lt": now,
                                                    @"order": @"occurs_at__desc",
                                                    @"fields": @"committee,occurs_at,congress,chamber,dc,room,description,bill_ids,url,hearing_type"}
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              NSArray *hearings = [self convertResponseToHearings:responseObject];
                                              completionBlock(hearings);
                                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              completionBlock(nil);
                                          }];    
}

+ (void)upcomingHearingsWithCompletionBlock:(void(^)(NSArray *hearings))completionBlock
{
    ISO8601DateFormatter *dateFormatter = [[ISO8601DateFormatter alloc] init];
    [dateFormatter setIncludeTime:YES];
    [dateFormatter setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    NSString *now = [dateFormatter stringFromDate:[NSDate date]];
    
    [[SFCongressApiClient sharedInstance] getPath:@"hearings"
                                       parameters:@{@"occurs_at__gte": now,
                                                    @"order": @"occurs_at__asc",
                                                    @"fields": @"committee,occurs_at,congress,chamber,dc,room,description,bill_ids,url,hearing_type"}
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              NSArray *hearings = [self convertResponseToHearings:responseObject];
                                              completionBlock(hearings);
                                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              completionBlock(nil);
                                          }];
}

#pragma mark - private

+ (NSArray *)convertResponseToHearings:(id)responseObject
{
    NSArray *resultsArray = [responseObject valueForKeyPath:@"results"];
    NSMutableArray *objectArray = [NSMutableArray arrayWithCapacity:resultsArray.count];
    for (NSDictionary *jsonElement in resultsArray) {
        SFHearing *object = [SFHearing objectWithJSONDictionary:jsonElement];
        [objectArray addObject:object];
    }
    return [NSArray arrayWithArray:objectArray];
}

@end
