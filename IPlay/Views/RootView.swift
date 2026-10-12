//
//  RootView.swift
//  IPlay
//
//  主界面：左侧导航 + 右侧内容区（兼容 iOS 15）
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HStack(spacing: 0) {
            // 左侧导航栏
            SidebarView()
                .frame(width: 200)
            
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
            .frame(maxWidth: .infinity)
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
        List {
            ForEach(AppState.Tab.allCases, id: \.self) { tab in
                Button {
                    appState.selectedTab = tab
                } label: {
                    Label(tab.rawValue, systemImage: tab.icon)
                        .foregroundColor(appState.selectedTab == tab ? .blue : .primary)
                }
            }
        }
        .navigationTitle("IPlay")
    }
}
