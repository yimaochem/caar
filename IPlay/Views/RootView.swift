//
//  RootView.swift
//  IPlay
//
//  主界面：左侧导航 + 右侧内容区
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationSplitView {
            // 左侧导航栏
            SidebarView()
                .navigationSplitViewColumnWidth(min: 200, ideal: 220, max: 250)
        } detail: {
            // 右侧内容区
            ZStack {
                switch appState.selectedTab {
                case .connection:
                    ConnectionView()
                case .display:
                    DisplayView()
                case .audio:
                    AudioView()
                case .about:
                    AboutView()
                }
            }
        }
        .sheet(isPresented: $appState.isShowingCarPlay) {
            CarPlayView()
        }
    }
}

// MARK: - 左侧侧边栏
struct SidebarView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        List(selection: $appState.selectedTab) {
            ForEach(AppState.Tab.allCases, id: \.self) { tab in
                Label(tab.rawValue, systemImage: tab.icon)
                    .tag(tab)
            }
        }
        .listStyle(.sidebar)
        .navigationTitle("IPlay")
    }
}
