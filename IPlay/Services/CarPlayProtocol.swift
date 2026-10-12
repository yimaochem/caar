//
//  CarPlayProtocol.swift
//  IPlay
//

import Foundation
import Network

class CarPlayProtocol: ObservableObject {
    static let shared = CarPlayProtocol()
    
    enum State {
        case disconnected
        case connecting
        case handshake
        case streaming
    }
    
    @Published var state: State = .disconnected
    @Published var videoWidth: Int = 1280
    @Published var videoHeight: Int = 720
    @Published var fps: Int = 30
    
    private var connection: NWConnection?
    
    func connect(to host: String, port: UInt16 = 5000) {
        let endpoint = NWEndpoint.hostPort(host: NWEndpoint.Port(rawValue: port)!, host: NWEndpoint.Host(host))
        connection = NWConnection(to: endpoint, using: .tcp)
        
        connection?.stateUpdateHandler = { state in
            DispatchQueue.main.async {
                switch state {
                case .ready:
                    self.state = .handshake
                    self.performHandshake()
                case .failed, .cancelled:
                    self.state = .disconnected
                default:
                    break
                }
            }
        }
        
        connection?.start(queue: .main)
    }
    
    func performHandshake() {
        // CarPlay协议握手包
        let handshake = Data([0x00, 0x01, 0x00, 0x00])
        connection?.send(content: handshake, completion: .contentProcessed { error in
            if error == nil {
                self.state = .streaming
            }
        })
    }
    
    func sendTouch(x: Float, y: Float, type: UInt8) {
        // 发送触摸坐标给iPhone
        var packet = Data()
        packet.append(type)
        packet.append(Float32(x).data)
        packet.append(Float32(y).data)
        connection?.send(content: packet, completion: .contentProcessed { _ in })
    }
    
    func disconnect() {
        connection?.cancel()
        connection = nil
        state = .disconnected
    }
}

extension Float32 {
    var data: Data {
        var value = self
        return Data(bytes: &value, count: MemoryLayout<Float32>.size)
    }
}
