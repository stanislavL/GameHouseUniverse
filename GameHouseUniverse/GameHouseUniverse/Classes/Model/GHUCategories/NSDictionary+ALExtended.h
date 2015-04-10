//
//  NSDictionary+ALExtended.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (String)

-(NSString*)stringForKey:(id)key;
-(NSArray*)arrayForKey:(id)key;
-(BOOL)isNullForKey:(id)key;

@end
