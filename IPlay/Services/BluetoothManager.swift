//
//  BluetoothManager.swift
//  IPlay
//

import Foundation
import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject {
    static let shared = BluetoothManager()
    
    @Published var isPoweredOn: Bool = false
    
    override init() {
        super.init()
    }
    
    func startScan() {}
    func stopScan() {}
}
