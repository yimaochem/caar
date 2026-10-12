//
//  NetworkManager.swift
//  IPlay
//
//  网络管理与 Bonjour 发现（兼容 iOS 15）
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    
    @Published var currentSSID: String = ""
    @Published var localIPAddress: String = ""
    @Published var isHotspotActive: Bool = false
    
    private var nwMonitor: NWPathMonitor!
    private var browser: NWBrowser?
    private var listener: NWListener?
    
    private init() {
        setupNetworkMonitor()
    }
    
    func setupNetworkMonitor() {
        nwMonitor = NWPathMonitor()
        nwMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.updateNetworkInfo(path: path)
            }
        }
        nwMonitor.start(queue: DispatchQueue.global(qos: .background))
    }
    
    func updateNetworkInfo(path: NWPath) {
        if path.status == .satisfied {
            print("网络已连接")
            localIPAddress = getIPAddress()
        } else {
            print("网络未连接")
            localIPAddress = ""
        }
    }
    
    func getIPAddress() -> String {
        return "192.168.1.x"
    }
    
    // MARK: - Bonjour 服务发现
    func startBrowsing() {
        // TODO: 浏览 CarPlay 相关的 Bonjour 服务
        let descriptor = NWBrowser.Descriptor.bonjour(type: "_carplay._tcp", domain: "")
        
        browser = NWBrowser(for: .bonjour(descriptor: descriptor), using: .tcp)
        
        browser?.browseResultsChangedHandler = { results, changes in
            for result in results {
                print("发现服务: \(result.endpoint)")
            }
        }
        
        browser?.start(queue: .main)
    }
    
    func stopBrowsing() {
        browser?.cancel()
        browser = nil
    }
    
    // MARK: - 启动接收服务
    func startListening() {
        do {
            listener = try NWListener(using: .tcp, on: 5000)
            
            listener?.newConnectionHandler = { connection in
                print("收到新连接: \(connection.endpoint)")
                connection.start(queue: .main)
            }
            
            listener?.start(queue: .main)
            print("开始监听端口 5000")
        } catch {
            print("启动监听失败: \(error)")
        }
    }
    
    func stopListening() {
        listener?.cancel()
        listener = nil
    }
}
