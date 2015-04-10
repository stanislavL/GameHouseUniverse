//
//  SoundEffect.m
//  Game Hours Universe
//
//  Created by stanislav on 10/10/14.
//

#import "SoundEffect.h"

@implementation SoundEffect

- (id)initWithSoundNamed:(NSString *)filename
{
    if ((self = [super init]))
		{
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (fileURL != nil)
			{
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError)
                soundID = theSoundID;
			}
		}
    return self;
}

- (void)dealloc
{
    AudioServicesDisposeSystemSoundID(soundID);
    [super dealloc];
}

- (void)play
{
    AudioServicesPlaySystemSound(soundID);
}

@end