//
//  AboutView.swift
//  IPlay
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("版本")
                    Spacer()
                    Text("v0.2.0")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("部署目标")
                    Spacer()
                    Text("iOS 15.1+")
                        .foregroundColor(.secondary)
                }
            }
            
            Section(header: Text("关于")) {
                Text("IPlay是原生iPad CarPlay接收端，支持Wi-Fi/蓝牙连接，硬解码H.264视频流。")
                    .font(.body)
            }
            
            Section(header: Text("开源协议")) {
                Text("MIT License")
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("关于")
    }
}
