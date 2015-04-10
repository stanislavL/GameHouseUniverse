//
//  NSMutableDictionary+ALExtended.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "NSMutableDictionary+ALExtended.h"

@implementation NSMutableDictionary (ALExtended)

-(void)setObject:(id)_objectOrNil withDefault:(id)_defaultOrNil forKey:(id)_key{
	
	if(_objectOrNil){
		// Not nil -> set object for key
		[self setObject:_objectOrNil forKey:_key];
	}
	else if(_defaultOrNil){
		// Object is nil but we have a default value
		[self setObject:_defaultOrNil forKey:_key];
	}
}

@end
