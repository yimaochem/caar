//
//  CarPlayProtocol.swift
//  IPlay
//

import Foundation
import Network

class CarPlayProtocol: ObservableObject {
    static let shared = CarPlayProtocol()
    
    enum State {
        case disconnected, connecting, streaming
    }
    
    @Published var state: State = .disconnected
    
    func connect(to host: String) {
        state = .streaming
    }
    
    func disconnect() {
        state = .disconnected
    }
}
