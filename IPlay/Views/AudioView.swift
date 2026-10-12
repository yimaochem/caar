//
//  AudioView.swift
//  IPlay
//
//  音频设置页
//

import SwiftUI

struct AudioView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Image(systemName: "speaker.fill")
                    Slider(value: $appState.volume, in: 0...1)
                    Image(systemName: "speaker.wave.3.fill")
                }
                Text("音量：\(Int(appState.volume * 100))%")
                    .foregroundColor(.secondary)
            } header: {
                Text("输出音量")
            }
            
            Section {
                Picker("输出设备", selection: $appState.outputDevice) {
                    Text("默认").tag("默认")
                    Text("iPad 扬声器").tag("iPad 扬声器")
                    Text("蓝牙耳机").tag("蓝牙耳机")
                }
                
                Picker("输入设备", selection: $appState.inputDevice) {
                    Text("默认").tag("默认")
                    Text("iPad 麦克风").tag("iPad 麦克风")
                }
            } header: {
                Text("音频设备")
            }
        }
        .formStyle(.grouped)
        .navigationTitle("音频设置")
    }
}
