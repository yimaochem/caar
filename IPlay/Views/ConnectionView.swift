//
//  ConnectionView.swift
//  IPlay
//

import SwiftUI

struct ConnectionView: View {
    @EnvironmentObject var appState: AppState
    @State private var devices: [String] = []
    @State private var selectedDevice: String = ""
    @State private var isScanning: Bool = false
    
    var body: some View {
        Form {
            Section(header: Text("发现的设备")) {
                if isScanning {
                    HStack {
                        ProgressView()
                        Text("正在扫描...")
                    }
                } else if devices.isEmpty {
                    Text("未发现设备")
                        .foregroundColor(.secondary)
                } else {
                    Picker("选择设备", selection: $selectedDevice) {
                        ForEach(devices, id: \.self) { device in
                            Text(device).tag(device)
                        }
                    }
                }
                
                Button(action: startScan) {
                    Label("重新扫描", systemImage: "arrow.clockwise")
                }
            }
            
            Section(header: Text("网络模式")) {
                Picker("模式", selection: $appState.networkMode) {
                    ForEach(NetworkMode.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("热点配置"), footer: Text("iPad开启个人热点后，iPhone连接该热点即可配对")) {
                TextField("SSID", text: $appState.ssid)
                SecureField("密码", text: $appState.password)
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
        .toolbar {
            Button(action: toggleConnection) {
                Image(systemName: appState.isReceiving ? "stop.circle.fill" : "play.circle.fill")
                    .font(.title)
            }
            .tint(appState.isReceiving ? .red : .blue)
        }
        .onAppear { startScan() }
    }
    
    func startScan() {
        isScanning = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            devices = ["iPhone 15 Pro", "iPhone 14", "iPhone 13"]
            selectedDevice = devices.first ?? ""
            isScanning = false
        }
    }
    
    func toggleConnection() {
        if appState.isReceiving {
            appState.isReceiving = false
            appState.connectionStatus = "已停止"
            appState.isShowingCarPlay = false
        } else {
            appState.isReceiving = true
            appState.connectionStatus = "正在连接..."
            appState.connectedDeviceName = selectedDevice
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                appState.connectionStatus = "已连接"
                appState.isShowingCarPlay = true
            }
        }
    }
}
