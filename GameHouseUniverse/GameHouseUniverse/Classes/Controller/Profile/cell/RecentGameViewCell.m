//
//  RecentGameViewCell.m
//  GameHouseUniverse
//
//  Created by Admin on 1/28/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "RecentGameViewCell.h"
#import "UIView+Animation.h"

@implementation RecentGameViewCell


@synthesize aryItems;

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void) populateItem:(NSMutableArray *)items{

    
    for (int i = 0 ; i< [items count]; i++) {
        UIImageView* temp = [[UIImageView alloc] initWithFrame:CGRectMake(17.0f+(i*50.0f), 0.0f, 40.0f, 40.0f)];
        [temp setImage:(UIImage*)[items objectAtIndex:i]];
        [self.contentView addSubview:temp];
        [self.aryItems addObject:temp];
        
    }
    
    UIImageView* temp1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 40)];
    temp1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:temp1];
    
    UIImageView* temp2 = [[UIImageView alloc] initWithFrame:CGRectMake(308, 0, 15, 40)];
    temp2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:temp2];
    
}
- (IBAction)didPresPrevBtn:(id)sender{
    
    UIImageView* temp = (UIImageView*)[self.aryItems objectAtIndex:0];
    if (temp.frame.origin.x == 10.0f) {
        return;
    }else{
        
        for (int i = 0 ; i< [self.aryItems count]; i++) {
            UIImageView* img = (UIImageView*)[self.aryItems objectAtIndex:i];
            [img moveTo:CGPointMake(img.frame.origin.x + 50.0f, img.frame.origin.y)
                         duration:1.0f
                           option:UIViewAnimationOptionCurveEaseIn];
        }
        
    }
    
}
- (IBAction)didPresNextBtn:(id)sender{
     
    UIImageView* temp = (UIImageView*)[self.aryItems objectAtIndex:([self.aryItems count]-1)];
    if (temp.frame.origin.x == 260.0f) {
        return;
    }else{
        
        for (int i = 0 ; i< [self.aryItems count]; i++) {
            UIImageView* img = (UIImageView*)[self.aryItems objectAtIndex:i];
            [img moveTo:CGPointMake(img.frame.origin.x - 50.0f, img.frame.origin.y)
               duration:0.3f
                 option:UIViewAnimationOptionCurveEaseIn];
        }
        
    }
}
@end
