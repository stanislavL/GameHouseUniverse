//
//  GHUCompany.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <Foundation/Foundation.h>

@interface GHUGame : NSObject{

	NSNumber* game_id;
	NSString* name;
}

@property (nonatomic, retain) NSNumber* game_id;
@property (nonatomic, retain) NSString* name;

-(void)readDataFromDictionary:(NSDictionary *)data;

@end


