//
//  GHUContact.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import "GHUGameIDs.h"
#import "NSDictionary+ALExtended.h"
#import "NSString+ALExtended.h"

@implementation GHUGameIDs

@synthesize gamer_id ;


@synthesize battlename, gametag, pnsname, wiiuname, originname,steamname, twitchname, lolname, skypename;
@synthesize threedcode,wargaming, softnyx, armor, eve, minecraft;

-(void)dealloc{
	
	self.gamer_id = nil;
	 
    
    
	self.battlename = nil;
	self.gametag = nil;
	self.pnsname = nil;
    self.wiiuname = nil;
    self.threedcode = nil;
    self.wargaming = nil;
    self.softnyx = nil;
    self.armor = nil;
    self.eve = nil;
    self.minecraft = nil;
    self.originname = nil;
    self.steamname = nil;
    self.twitchname = nil;
    self.lolname = nil;
    self.skypename = nil;

	
	[super dealloc];
}

- (GHUGameIDs *)copyWithZone:(NSZone *)zone {

    GHUGameIDs *contact = [[GHUGameIDs allocWithZone:zone] init];

    contact.gamer_id = self.gamer_id;
 
	contact.battlename = self.battlename;
	contact.gametag = self.gametag;
	contact.pnsname = self.pnsname;
	contact.wiiuname = self.wiiuname;
    contact.threedcode = self.threedcode;
    contact.wargaming = self.wargaming;
    contact.softnyx = self.softnyx;
    contact.armor = self.armor;
    contact.eve = self.eve;
    contact.minecraft = self.minecraft;
    contact.originname = self.originname;
    contact.steamname = self.steamname;
    contact.twitchname = self.twitchname;
    contact.lolname = self.lolname;
    contact.skypename = self.skypename;
 
	
    return contact;
}


-(void)readDataFromDictionary:(NSDictionary *)data{
    
	self.gamer_id = [NSNumber numberWithInt:[[data stringForKey:@"gamer_id"] intValue]];
    self.battlename = [data objectForKey:@"Battle.netID"];
    self.gametag = [data objectForKey:@"GamerTag"];
    self.pnsname = [data objectForKey:@"PNS ID"];
	self.wiiuname = [data objectForKey:@"WiiU ID"];
    self.threedcode = [data objectForKey:@"3Ds Code"];
    self.wargaming = [data objectForKey:@"Wargaming.net"];
    self.softnyx = [data objectForKey:@"Softnyx"];
    self.armor = [data objectForKey:@"Armor Games"];
    self.eve = [data objectForKey:@"Eve ID"];
    self.minecraft = [data objectForKey:@"Minecraft ID"];
    self.originname = [data objectForKey:@"Origin ID"];
    self.steamname = [data objectForKey:@"Steam ID"];
    self.twitchname = [data objectForKey:@"Twitch ID"];
    self.lolname = [data objectForKey:@"LolID"];
    self.skypename = [data objectForKey:@"Skype ID"];
    
}
@end
