//
//  VideoCreator.m
//  Vooconnect
//
//  Created by Mac on 27/07/2023.
//

#import "VideoGenerator.h"
#import <AVFoundation/AVFoundation.h>

@implementation VideoGenerator

- (void)createVideoFromImage:(UIImage *)image withAudio:(NSURL *)audioURL {
    // Create an AVAssetWriter object
        AVAssetWriter *videoWriter = [[AVAssetWriter alloc] initWithURL:[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"output.mp4"]] fileType:AVFileTypeMPEG4 error:nil];
        
        // Define video settings
        NSDictionary *videoSettings = @{
            AVVideoCodecKey : AVVideoCodecTypeH264,
            AVVideoWidthKey : @(image.size.width),
            AVVideoHeightKey : @(image.size.height)
        };
        
        // Create an AVAssetWriterInput object
        AVAssetWriterInput *writerInput = [[AVAssetWriterInput alloc] initWithMediaType:AVMediaTypeVideo outputSettings:videoSettings];
        
        // Create an AVAssetWriterInputPixelBufferAdaptor object
        NSDictionary *sourcePixelBufferAttributesDictionary = @{
            (NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32ARGB),
            (NSString *)kCVPixelBufferWidthKey : @(image.size.width),
            (NSString *)kCVPixelBufferHeightKey : @(image.size.height)
        };
        
        AVAssetWriterInputPixelBufferAdaptor *adaptor = [[AVAssetWriterInputPixelBufferAdaptor alloc] initWithAssetWriterInput:writerInput sourcePixelBufferAttributes:sourcePixelBufferAttributesDictionary];
        
        // Start writing session
        [videoWriter startWriting];
        [videoWriter startSessionAtSourceTime:kCMTimeZero];
        
        // Write video frames
        CVPixelBufferRef buffer = NULL;
        
        for (int i = 0; i < 30; i++) {
            // Create pixel buffer from image
            CVPixelBufferCreate(kCFAllocatorDefault,
                                image.size.width,
                                image.size.height,
                                kCVPixelFormatType_32ARGB,
                                (__bridge CFDictionaryRef)sourcePixelBufferAttributesDictionary,
                                &buffer);
            
            CVPixelBufferLockBaseAddress(buffer, 0);
            
            void *pixelData = CVPixelBufferGetBaseAddress(buffer);
            
            CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
            
            CGContextRef context = CGBitmapContextCreate(pixelData,
                                                         image.size.width,
                                                         image.size.height,
                                                         8,
                                                         CVPixelBufferGetBytesPerRow(buffer),
                                                         rgbColorSpace,
                                                         kCGImageAlphaNoneSkipFirst);
            
            CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
            
            CGColorSpaceRelease(rgbColorSpace);
            CGContextRelease(context);
            
            CVPixelBufferUnlockBaseAddress(buffer, 0);
            
            // Append pixel buffer to adaptor
            CMTime frameTime = CMTimeMake(i, 30);
            [adaptor appendPixelBuffer:buffer withPresentationTime:frameTime];
            
            // Release pixel buffer
            CVPixelBufferRelease(buffer);
        }
    // End writing session
    [writerInput markAsFinished];
    [videoWriter finishWritingWithCompletionHandler:^{
        if (videoWriter.status == AVAssetWriterStatusCompleted) {
            NSLog(@"Video writing succeeded.");
            
            // Add audio to video
            AVMutableComposition *composition = [[AVMutableComposition alloc] init];
            AVMutableCompositionTrack *compositionTrack = [composition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
            AVURLAsset *audioAsset = [[AVURLAsset alloc] initWithURL:audioURL options:nil];
            AVAssetTrack *audioTrack = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
            [compositionTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:audioTrack atTime:kCMTimeZero error:nil];
            
            AVMutableCompositionTrack *videoCompositionTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
            AVURLAsset *videoAsset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent:@"output.mp4"]] options:nil];
            AVAssetTrack *videoTrack = [[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
            [videoCompositionTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, videoAsset.duration) ofTrack:videoTrack atTime:kCMTimeZero error:nil];

            // Create an AVAssetExportSession to export the final video with audio
            AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:composition presetName:AVAssetExportPresetHighestQuality];
            NSString *outputFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"final_output.mp4"];
            exportSession.outputURL = [NSURL fileURLWithPath:outputFilePath];
            exportSession.outputFileType = AVFileTypeMPEG4;
            exportSession.shouldOptimizeForNetworkUse = YES;

            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                switch ([exportSession status]) {
                    case AVAssetExportSessionStatusCompleted: {
                        NSLog(@"Video export succeeded.");
                        // At this point, you have the final video saved at `outputFilePath`.
                        // You can now do whatever you want with the video, such as saving it to the camera roll or presenting it to the user.
                        break;
                    }
                    case AVAssetExportSessionStatusFailed: {
                        NSLog(@"Video export failed with error: %@", [exportSession error]);
                        break;
                    }
                    case AVAssetExportSessionStatusCancelled: {
                        NSLog(@"Video export cancelled.");
                        break;
                    }
                    default: {
                        break;
                    }
                }
            }];
        }
        else {
            NSLog(@"Video writing failed with error: %@", [videoWriter error]);
        }
    }];
}

@end
