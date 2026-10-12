//
//  NetworkManager.swift
//  IPlay
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    
    @Published var localIP: String = ""
    @Published var discoveredDevices: [String] = []
    
    private var browser: NWBrowser?
    private var listener: NWListener?
    
    func startBrowsing() {
        let descriptor = NWBrowser.Descriptor.bonjour(type: "_carplay._tcp", domain: "")
        let params = NWParameters.tcp
        
        browser = NWBrowser(for: descriptor, using: params)
        
        browser?.browserQueue = DispatchQueue.global(qos: .userInitiated)
        browser?.browseResultsChangedHandler = { results, changes in
            DispatchQueue.main.async {
                self.discoveredDevices = results.map { result in
                    if case .service(let name, _, _, _) = result.endpoint {
                        return name
                    }
                    return "未知设备"
                }
            }
        }
        
        browser?.start()
    }
    
    func stopBrowsing() {
        browser?.cancel()
        browser = nil
    }
    
    func startListening(port: UInt16 = 5000) {
        do {
            listener = try NWListener(using: .tcp, on: port)
            listener?.newConnectionHandler = { conn in
                print("收到连接: \(conn.endpoint)")
                conn.start(queue: .main)
            }
            listener?.start(queue: .main)
        } catch {
            print("监听失败: \(error)")
        }
    }
}
