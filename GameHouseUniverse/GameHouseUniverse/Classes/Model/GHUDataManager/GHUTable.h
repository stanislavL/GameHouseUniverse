//
//  GHUTable.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <Foundation/Foundation.h>

@interface GHUTable : NSObject{
	
	NSNumber* table_id;
	NSString* name;
}

-(void)readDataFromDictionary:(NSDictionary*)data;

@property (nonatomic, retain) NSNumber* table_id;
@property (nonatomic, retain) NSString* name;

@end
