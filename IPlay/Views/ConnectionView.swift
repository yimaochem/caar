//
//  ConnectionView.swift
//  IPlay
//
//  连接设置页（兼容 iOS 15）
//

import SwiftUI

struct ConnectionView: View {
    @EnvironmentObject var appState: AppState
    @State private var devices: [String] = ["未发现设备"]
    @State private var selectedDevice: String = "未发现设备"
    
    var body: some View {
        Form {
            Section(header: Text("iPhone 设备")) {
                Picker("选择设备", selection: $selectedDevice) {
                    ForEach(devices, id: \.self) { device in
                        Text(device).tag(device)
                    }
                }
                
                Button(action: {
                    refreshDevices()
                }) {
                    Label("刷新", systemImage: "arrow.clockwise")
                }
            }
            
            Section(header: Text("网络模式")) {
                Picker("网络模式", selection: $appState.networkMode) {
                    ForEach(NetworkMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("网络配置"), footer: Text("本机热点模式：iPad 开启个人热点，iPhone 连接后进行 CarPlay 配对")) {
                TextField("SSID", text: $appState.ssid)
                SecureField("密码", text: $appState.password)
                Picker("信道", selection: $appState.channel) {
                    Text("自动").tag("自动")
                    Text("1").tag("1")
                    Text("6").tag("6")
                    Text("11").tag("11")
                }
            }
            
            Section(header: Text("连接状态")) {
                HStack {
                    Circle()
                        .fill(appState.isReceiving ? .green : .gray)
                        .frame(width: 8, height: 8)
                    Text(appState.connectionStatus)
                    Spacer()
                    if !appState.connectedDeviceName.isEmpty {
                        Text(appState.connectedDeviceName)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle("连接设置")
        .safeAreaInset(edge: .bottom) {
            Button(action: {
                toggleReceiving()
            }) {
                HStack {
                    Image(systemName: appState.isReceiving ? "stop.circle.fill" : "play.circle.fill")
                    Text(appState.isReceiving ? "停止接收" : "启动接收")
                }
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(appState.isReceiving ? Color.red : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
            .background(Color(.systemBackground))
        }
    }
    
    func refreshDevices() {
        devices = ["iPhone 15 Pro", "iPhone 14", "未发现设备"]
    }
    
    func toggleReceiving() {
        if appState.isReceiving {
            appState.isReceiving = false
            appState.connectionStatus = "已停止"
            appState.isShowingCarPlay = false
        } else {
            appState.isReceiving = true
            appState.connectionStatus = "正在连接..."
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                appState.connectionStatus = "已连接"
                appState.connectedDeviceName = "iPhone 15 Pro"
                appState.isShowingCarPlay = true
            }
        }
    }
}
