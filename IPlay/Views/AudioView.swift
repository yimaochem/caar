//
//  AudioView.swift
//  IPlay
//

import SwiftUI

struct AudioView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Form {
            Section(header: Text("音质")) {
                Picker("音质", selection: $appState.audioQuality) {
                    ForEach(AudioQuality.allCases, id: \.self) { q in
                        Text(q.rawValue).tag(q)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("音量")) {
                Slider(value: $appState.volume, in: 0...1) {
                    Text("音量")
                }
                Text("\(Int(appState.volume * 100))%")
            }
        }
        .navigationTitle("音频设置")
    }
}
