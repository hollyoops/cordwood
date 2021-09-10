import UIKit
import Foundation
import ServiceBoard

class HostAppDelegate: DefaultAppDelegate {
    override init() {
        super.init()
        self.attachServiceBoard(ServiceBoard(serviceEntry: DiscoveredServices()))
    }
}
