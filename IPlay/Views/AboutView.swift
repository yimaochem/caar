//
//  AboutView.swift
//  IPlay
//
//  关于页（兼容 iOS 15）
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Form {
            Section(header: Text("关于 IPlay")) {
                HStack {
                    Text("版本")
                    Spacer()
                    Text("0.1.0")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("项目")
                    Spacer()
                    Text("IPlay - iPad CarPlay 接收端")
                        .foregroundColor(.secondary)
                }
            }
            
            Section(header: Text("说明")) {
                Text("参考 WinPlay 项目开发，支持无线 CarPlay 接收，让 iPad 成为车载显示终端。")
                    .foregroundColor(.secondary)
            }
            
            Section(header: Text("维护")) {
                Button("检查更新") { }
                Button("导出诊断日志") { }
            }
        }
        .navigationTitle("关于")
    }
}
