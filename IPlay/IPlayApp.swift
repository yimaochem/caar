//
//  IPlayApp.swift
//  IPlay
//
//  iPad 版无线 CarPlay 接收端
//  参考 WinPlay 项目
//

import SwiftUI

@main
struct IPlayApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .preferredColorScheme(.dark)
        }
    }
}

class AppState: ObservableObject {
    enum Tab: String, CaseIterable {
        case connection = "连接"
        case display = "显示"
        case audio = "音频"
        case about = "关于"
        
        var icon: String {
            switch self {
            case .connection: return "bluetooth"
            case .display: return "display"
            case .audio: return "speaker.wave.2"
            case .about: return "info.circle"
            }
        }
    }
    
    @Published var selectedTab: Tab = .connection
    @Published var isReceiving: Bool = false
    @Published var isShowingCarPlay: Bool = false
    @Published var connectionStatus: String = "未连接"
    @Published var connectedDeviceName: String = ""
    
    // 网络设置
    @Published var networkMode: NetworkMode = .hotspot
    @Published var ssid: String = ""
    @Published var password: String = ""
    @Published var channel: String = "自动"
    
    // 显示设置
    @Published var resolution: String = "1280×720"
    @Published var fps: Int = 60
    @Published var strictPixelAlignment: Bool = false
    
    // 音频设置
    @Published var volume: Double = 1.0
    @Published var inputDevice: String = "默认"
    @Published var outputDevice: String = "默认"
}

enum NetworkMode: String, CaseIterable {
    case hotspot = "本机热点"
    case lan = "局域网"
}
