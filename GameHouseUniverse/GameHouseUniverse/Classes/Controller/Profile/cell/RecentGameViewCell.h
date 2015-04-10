//
//  RecentGameViewCell.h
//  GameHouseUniverse
//
//  Created by Admin on 1/28/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecentGameViewCell : UITableViewCell{
    
    
}

@property (nonatomic, retain) NSMutableArray* aryItems;


- (void) populateItem:(NSMutableArray*) items;
@end
