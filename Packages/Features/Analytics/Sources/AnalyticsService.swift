import ServiceContracts
import ServiceBoard

struct FirebaseSDK {
    func setupSDK() {
        print("setup SDK")
    }
}

public struct AnalyticsService: DiscoverableService {
    public var moduleName = "Analytics"
    
    public static func onDiscovery(resolver: ServiceResolver, contract: EmptyServiceContract) {
        let firebaseSDK = FirebaseSDK()
        firebaseSDK.setupSDK()
    }
}
