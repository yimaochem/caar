//
//  DisplayView.swift
//  IPlay
//

import SwiftUI

struct DisplayView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Form {
            Section(header: Text("分辨率")) {
                Picker("分辨率", selection: $appState.resolution) {
                    ForEach(Resolution.allCases, id: \.self) { res in
                        Text(res.rawValue).tag(res)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("帧率")) {
                Stepper(value: $appState.frameRate, in: 24...60, step: 6) {
                    Text("\(appState.frameRate) FPS")
                }
            }
            
            Section {
                Toggle("硬件解码", isOn: $appState.hardwareDecoding)
                Toggle("显示FPS", isOn: $appState.showFPS)
            }
        }
        .navigationTitle("显示设置")
    }
}
