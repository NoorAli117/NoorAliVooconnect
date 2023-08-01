//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

// VideoCreator.h
#import <UIKit/UIKit.h>

@interface VideoGenerator : NSObject

- (void)createVideoFromImage:(UIImage *)image withAudio:(NSURL *)audioURL completion:(void (^)(NSURL *videoURL, NSError *error))completion;

@end


