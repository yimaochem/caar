//
//  DisplayView.swift
//  IPlay
//
//  显示设置页（兼容 iOS 15）
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var appState: AppState
    
    let resolutions = ["1280×720", "1920×1080", "2560×1440"]
    let fpsOptions = [30, 60]
    
    var body: some View {
        Form {
            Section(header: Text("视频输出")) {
                Picker("视频分辨率", selection: $appState.resolution) {
                    ForEach(resolutions, id: \.self) { res in
                        Text(res).tag(res)
                    }
                }
                
                Picker("帧率", selection: $appState.fps) {
                    ForEach(fpsOptions, id: \.self) { fps in
                        Text("\(fps) fps").tag(fps)
                    }
                }
            }
            
            Section(header: Text("显示模式"), footer: Text("开启后画面按请求的物理像素尺寸显示，不受系统缩放影响")) {
                Toggle("严格物理像素对齐", isOn: $appState.strictPixelAlignment)
            }
        }
        .navigationTitle("显示设置")
    }
}
