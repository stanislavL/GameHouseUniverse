//
//  NSDictionary+ALExtended.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//


#import "NSDictionary+ALExtended.h"

@implementation NSDictionary (String)

-(NSString*)stringForKey:(id)key{
	if([[self objectForKey:key] isKindOfClass:[NSString class]])
		return [self objectForKey:key];
	else if([[self objectForKey:key] isKindOfClass:[NSNumber class]])
		return [(NSNumber*)[self objectForKey:key] stringValue];
	else 
		return @"";
}

-(BOOL)isNullForKey:(id)key{
	return [[self objectForKey:key] isKindOfClass:[NSNull class]];
}

-(NSArray*)arrayForKey:(id)key{
	if([[self objectForKey:key] isKindOfClass:[NSArray class]])
		return [self objectForKey:key];
	else
		return [NSArray array];
}

@end
