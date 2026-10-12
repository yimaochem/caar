//
//  RootView.swift
//  IPlay
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ConnectionView()) {
                    Label("连接设置", systemImage: "antenna.radiowaves.left.and.right")
                }
                NavigationLink(destination: DisplayView()) {
                    Label("显示设置", systemImage: "display")
                }
                NavigationLink(destination: AudioView()) {
                    Label("音频设置", systemImage: "speaker.wave.2")
                }
                NavigationLink(destination: AboutView()) {
                    Label("关于", systemImage: "info.circle")
                }
            }
            .navigationTitle("IPlay")
            .listStyle(SidebarListStyle())
            
            if appState.isShowingCarPlay {
                CarPlayView()
            } else {
                Text("选择左侧“连接设置”开始")
                    .foregroundColor(.secondary)
            }
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}
