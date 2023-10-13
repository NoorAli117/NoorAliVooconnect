//
//  FFmpegHelper.swift
//  Vooconnect
//
//  Created by Yaseen Raza Turabi on 10/12/23.
//

import Foundation

struct FFmpegHelper {
    static func runFFmpegCommand(leftVideoPath: String, rightVideoPath: URL, outputUrl: URL, completion: @escaping (Bool) -> Void) {
//        let task = CommandLine()
//        task.executableURL = URL(fileURLWithPath: "/usr/local/bin/ffmpeg") // Set the path to your ffmpeg executable
//        task.arguments = [
//            "-i", leftVideoPath,
//            "-i", rightVideoPath.path,
//            "-filter_complex", "hstack",
//            "-c:v", "libx264",
//            "-c:a", "aac",
//            "-strict", "experimental",
//            outputUrl.path
//        ]
//
//        let pipe = Pipe()
//        task.standardOutput = pipe
//        do {
//            try task.run()
//            task.waitUntilExit()
//
//            if task.terminationStatus == 0 {
//                completion(true)
//            } else {
//                completion(false)
//            }
//        } catch {
//            print("Error running FFmpeg command: \(error)")
//            completion(false)
//        }
    }
}



