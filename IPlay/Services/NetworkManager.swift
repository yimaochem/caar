//
//  NetworkManager.swift
//  IPlay
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    
    @Published var localIP: String = "192.168.1.1"
    @Published var discoveredDevices: [String] = []
    
    func startBrowsing() {
        discoveredDevices = ["iPhone 15 Pro", "iPhone 14"]
    }
    
    func stopBrowsing() {}
    
    func startListening() {}
}
