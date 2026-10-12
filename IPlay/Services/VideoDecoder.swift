//
//  VideoDecoder.swift
//  IPlay
//

import Foundation
import UIKit

class VideoDecoder: ObservableObject {
    static let shared = VideoDecoder()
    
    @Published var currentFrame: UIImage?
    
    func setupDecoder(width: Int, height: Int) {}
    
    func decodeFrame(data: Data) {}
}
