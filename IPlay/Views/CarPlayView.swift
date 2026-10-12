//
//  CarPlayView.swift
//  IPlay
//
//  CarPlay 投屏画面
//

import SwiftUI
import AVKit

struct CarPlayView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingSettings = false
    
    var body: some View {
        ZStack {
            // 黑色背景
            Color.black
                .ignoresSafeArea()
            
            // CarPlay 画面区域
            // TODO: 替换为实际的视频渲染层
            Rectangle()
                .fill(Color(white: 0.1))
                .aspectRatio(16/9, contentMode: .fit)
                .overlay {
                    VStack(spacing: 20) {
                        Text("CarPlay 画面")
                            .foregroundColor(.white)
                            .font(.title)
                        Text("等待视频流...")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                }
            
            // 右上角退出按钮
            VStack {
                HStack {
                    Spacer()
                    Button {
                        appState.isShowingCarPlay = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.white.opacity(0.8))
                            .background(.ultraThinMaterial)
                            .clipShape(Circle())
                    }
                    .padding()
                }
                Spacer()
            }
        }
        .statusBarHidden()
    }
}
