import Network
import SwiftUI

// An enum to handle the network status
enum NetworkStatus: String {
    case connected
    case disconnected
}

class Monitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")

    @Published var score = 0
    @Published var status: NetworkStatus = .connected
  
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }

            // Monitor runs on a background thread so we need to publish
            // on the main thread
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    print("We're connected!")
                    self.status = .connected
                    self.score = 1
                  

                } else {
                    print("No connection.")
                    self.score = 0
                    self.status = .disconnected
                }
            }
        }
        monitor.start(queue: queue)
    }
}
