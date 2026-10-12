//
//  VideoDecoder.swift
//  IPlay
//

import Foundation
import VideoToolbox
import AVFoundation

class VideoDecoder: ObservableObject {
    static let shared = VideoDecoder()
    
    @Published var currentFrame: CVPixelBuffer?
    
    private var decompressionSession: VTDecompressionSession?
    private var formatDescription: CMVideoFormatDescription?
    
    func setupDecoder(width: Int, height: Int) {
        var codecSpec = 0
        codecSpec = kCMVideoCodecType_H264
        
        var desc: CMVideoFormatDescription?
        CMVideoFormatDescriptionCreate(
            allocator: kCFAllocatorDefault,
            codecType: codecSpec,
            width: Int32(width),
            height: Int32(height),
            extensions: nil,
            formatDescriptionOut: &desc
        )
        formatDescription = desc
        
        var callback = VTDecompressionOutputCallbackRecord(
            decompressionOutputCallback: { (decompressionOutputRefCon, _, _, status, _, pixelBuffer, _, _) in
                if status == noErr, let pb = pixelBuffer {
                    DispatchQueue.main.async {
                        VideoDecoder.shared.currentFrame = pb
                    }
                }
            },
            decompressionOutputRefCon: UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        )
        
        var session: VTDecompressionSession?
        VTDecompressionSessionCreate(
            allocator: kCFAllocatorDefault,
            formatDescription: desc!,
            decoderSpecification: nil,
            imageBufferAttributes: [
                kCVPixelBufferPixelFormatTypeKey: kCVPixelFormatType_32BGRA
            ] as CFDictionary,
            outputCallback: &callback,
            decompressionSessionOut: &session
        )
        decompressionSession = session
    }
    
    func decodeFrame(data: Data) {
        guard let session = decompressionSession else { return }
        
        data.withUnsafeBytes { buffer in
            var blockBuffer: CMBlockBuffer?
            CMBlockBufferCreateWithMemoryBlock(
                allocator: kCFAllocatorDefault,
                memoryBlock: UnsafeMutableRawPointer(mutating: buffer.baseAddress),
                blockLength: data.count,
                blockAllocator: nil,
                customBlockSource: nil,
                offsetToData: 0,
                dataLength: data.count,
                flags: 0,
                blockBufferOut: &blockBuffer
            )
            
            var sampleBuffer: CMSampleBuffer?
            CMSampleBufferCreate(
                allocator: kCFAllocatorDefault,
                dataBuffer: blockBuffer!,
                dataReady: true,
                makeDataReadyCallback: nil,
                refCon: nil,
                formatDescription: formatDescription!,
                sampleCount: 1,
                sampleTimingEntryCount: 0,
                sampleTimingArray: nil,
                sampleSizeEntryCount: 0,
                sampleSizeArray: nil,
                sampleBufferOut: &sampleBuffer
            )
            
            if let sb = sampleBuffer {
                VTDecompressionSessionDecodeFrame(
                    session,
                    sampleBuffer: sb,
                    flags: [],
                    frameRefCon: nil,
                    infoFlags: nil
                )
            }
        }
    }
}
