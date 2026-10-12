//
//  IPlayApp.swift
//  IPlay
//
//  原生iPad CarPlay接收端
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    static let shared = AppState()
    
    @Published var isReceiving: Bool = false
    @Published var connectionStatus: String = "未连接"
    @Published var connectedDeviceName: String = ""
    @Published var isShowingCarPlay: Bool = false
    
    @Published var networkMode: NetworkMode = .hotspot
    @Published var ssid: String = "IPlay-Hotspot"
    @Published var password: String = "12345678"
    @Published var channel: String = "自动"
    
    @Published var resolution: Resolution = .hd
    @Published var frameRate: Int = 30
    @Published var hardwareDecoding: Bool = true
    @Published var showFPS: Bool = false
    
    @Published var audioQuality: AudioQuality = .high
    @Published var volume: Double = 0.8
    
    @Published var autoReconnect: Bool = true
    @Published var lastConnectedDevice: String = ""
}

enum NetworkMode: String, CaseIterable {
    case hotspot = "热点模式"
    case wifi = "局域网"
    case bluetooth = "蓝牙连接"
}

enum Resolution: String, CaseIterable {
    case sd = "480p"
    case hd = "720p"
    case fhd = "1080p"
}

enum AudioQuality: String, CaseIterable {
    case low = "低质量"
    case medium = "中等"
    case high = "高质量"
}

@main
struct IPlayApp: App {
    @StateObject private var appState = AppState.shared
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
        }
    }
}
