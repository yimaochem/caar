//
//  CarPlayView.swift
//  IPlay
//

import SwiftUI
import AVFoundation

struct CarPlayView: View {
    @EnvironmentObject var appState: AppState
    @State private var showControls: Bool = true
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            // CarPlay视频画面占位
            Rectangle()
                .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .overlay(
                    VStack {
                        Image(systemName: "car.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                        Text("CarPlay 投屏中")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                )
            
            // 顶部控制栏
            VStack {
                if showControls {
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "house.fill")
                                .font(.title2)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "mic.fill")
                                .font(.title2)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    .transition(.move(edge: .top))
                }
                
                Spacer()
                
                if showControls && appState.showFPS {
                    HStack {
                        Text("FPS: 30")
                            .font(.caption)
                            .padding(4)
                            .background(Color.black.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(4)
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .onTapGesture {
            withAnimation { showControls.toggle() }
        }
    }
}
