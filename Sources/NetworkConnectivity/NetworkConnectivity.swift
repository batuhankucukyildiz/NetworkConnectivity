// Created by Batuhan Kucukyildiz on 24.04.2024.


import Network
import Foundation

public class NetworkConnectivity: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    public var isConnected = false
    
    public init() {
        networkMonitor.pathUpdateHandler = {path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run {
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
