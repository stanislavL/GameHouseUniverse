//
//  SoundEffect.h
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>

@interface SoundEffect : NSObject
{
    SystemSoundID soundID;
}

- (id)initWithSoundNamed:(NSString *)filename;
- (void)play;

@end