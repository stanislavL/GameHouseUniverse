//
//  GHUContact.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//
//

#import <Foundation/Foundation.h>

@interface GHUGameIDs : NSObject{

	NSNumber* gamer_id;
 
    
    NSMutableDictionary* battlename;   //1
    NSMutableDictionary* gametag;      //2
    NSMutableDictionary* pnsname;      //3
    NSMutableDictionary* wiiuname;     //4
    NSMutableDictionary* threedcode;   //5
    NSMutableDictionary* wargaming;    //6
    NSMutableDictionary* softnyx;      //7
    NSMutableDictionary* armor;        //8
    NSMutableDictionary* eve;          //9
    NSMutableDictionary* minecraft;    //10
    NSMutableDictionary* originname;   //11
    NSMutableDictionary* steamname;    //12
    NSMutableDictionary* twitchname;   //13
    NSMutableDictionary* lolname;      //14
    NSMutableDictionary* skypename;    //15



}


@property (nonatomic, retain) NSNumber* gamer_id;

@property (nonatomic, retain) NSMutableDictionary* battlename;
@property (nonatomic, retain) NSMutableDictionary* gametag;
@property (nonatomic, retain) NSMutableDictionary* pnsname;
@property (nonatomic, retain) NSMutableDictionary* wiiuname;
@property (nonatomic, retain) NSMutableDictionary* threedcode;
@property (nonatomic, retain) NSMutableDictionary* wargaming;
@property (nonatomic, retain) NSMutableDictionary* softnyx;
@property (nonatomic, retain) NSMutableDictionary* armor;
@property (nonatomic, retain) NSMutableDictionary* eve;
@property (nonatomic, retain) NSMutableDictionary* minecraft;
@property (nonatomic, retain) NSMutableDictionary* originname;
@property (nonatomic, retain) NSMutableDictionary* steamname;
@property (nonatomic, retain) NSMutableDictionary* twitchname;
@property (nonatomic, retain) NSMutableDictionary* lolname;
@property (nonatomic, retain) NSMutableDictionary* skypename;
 

-(void)readDataFromDictionary:(NSDictionary*)data;
//-(NSString*)formatContactFullNameReadable;
//-(NSString*)formatCommunicationMeans;
//-(UIImage*) formatProfilePicture;

@end
