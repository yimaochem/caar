//
//  VideoDecoder.swift
//  IPlay
//
//  H.264 视频解码
//

import Foundation
import AVFoundation
import VideoToolbox

class VideoDecoder: ObservableObject {
    static let shared = VideoDecoder()
    
    @Published var isDecoding: Bool = false
    @Published var currentFrame: CVPixelBuffer?
    
    private var decompressionSession: VTDecompressionSession?
    private var videoFormatDescription: CMVideoFormatDescription?
    
    private init() {}
    
    func setupDecoder(width: Int, height: Int) {
        // TODO: 配置 H.264 解码会话
        print("初始化视频解码器: \(width)x\(height)")
        
        // 创建视频格式描述
        var formatDescription: CMVideoFormatDescription?
        var status = CMVideoFormatDescriptionCreate(
            allocator: kCFAllocatorDefault,
            codecType: kCMVideoCodecType_H264,
            width: Int32(width),
            height: Int32(height),
            extensions: nil,
            formatDescriptionOut: &formatDescription
        )
        
        guard status == noErr, let formatDesc = formatDescription else {
            print("创建格式描述失败: \(status)")
            return
        }
        
        videoFormatDescription = formatDesc
        
        // 创建解码会话
        let callback: VTDecompressionOutputCallback = { decompressionOutputRefCon, sourceFrameRefCon, status, infoFlags, imageBuffer, presentationTimeStamp, duration in
            // 解码完成回调
            if status == noErr, let imageBuffer = imageBuffer {
                DispatchQueue.main.async {
                    VideoDecoder.shared.currentFrame = imageBuffer
                }
            }
        }
        
        var callbackWithOutput = VTDecompressionOutputCallbackRecord(
            decompressionOutputCallback: callback,
            decompressionOutputRefCon: UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        )
        
        var decoderSession: VTDecompressionSession?
        status = VTDecompressionSessionCreate(
            allocator: kCFAllocatorDefault,
            formatDescription: formatDesc,
            decoderSpecification: nil,
            imageBufferAttributes: [
                kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA
            ] as CFDictionary,
            outputCallback: &callbackWithOutput,
            decompressionSessionOut: &decoderSession
        )
        
        guard status == noErr, let session = decoderSession else {
            print("创建解码会话失败: \(status)")
            return
        }
        
        decompressionSession = session
        isDecoding = true
        print("视频解码器就绪")
    }
    
    func decodeFrame(_ data: Data) {
        guard let session = decompressionSession else { return }
        
        // TODO: 解码 H.264 帧数据
        // 1. 把 Data 包装成 CMBlockBuffer
        // 2. 调用 VTDecompressionSessionDecodeFrame
    }
    
    func stopDecoding() {
        decompressionSession?.invalidate()
        decompressionSession = nil
        isDecoding = false
    }
}
