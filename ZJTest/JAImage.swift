//
//  JAImage.swift
//  Monking
//
//  Created by 庄记 on 2016/11/28.
//  Copyright © 2016年 lezhi. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
import UIKit

extension UIImage {
    
    static func videoFirstFrame(videoUrl:URL) -> UIImage? {
        let options = [AVURLAssetPreferPreciseDurationAndTimingKey:NSNumber(booleanLiteral:false)]
        let urlAsset = AVURLAsset(url: videoUrl, options: options)
        let generator = AVAssetImageGenerator(asset: urlAsset)
        generator.appliesPreferredTrackTransform = true
        let time = CMTime(value: 0, timescale: 5)
        if let img = try? generator.copyCGImage(at: time, actualTime: nil) {
            return UIImage(cgImage: img)
        } else {
            return nil
        }
    }
    
}

func videoFormatToMp4(videoUrl:URL , backUrl:String) -> String {
    let  urlAsset = AVURLAsset(url: videoUrl, options: nil)
    let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPresetPassthrough)
    exportSession?.shouldOptimizeForNetworkUse = true
    exportSession?.outputFileType = AVFileTypeMPEG4
    exportSession?.outputURL = URL(string: backUrl)
    exportSession?.exportAsynchronously(completionHandler: {
        switch exportSession!.status {
        case AVAssetExportSessionStatus.cancelled:
             print("cancelled")
        case AVAssetExportSessionStatus.failed:
             print(exportSession?.error)
        case AVAssetExportSessionStatus.exporting:
             print("exporting")
        case AVAssetExportSessionStatus.completed:
             print("completed")
        case AVAssetExportSessionStatus.unknown:
             print("unknown")
        case AVAssetExportSessionStatus.waiting:
             print("wating")
        }
    })
    return backUrl
}


