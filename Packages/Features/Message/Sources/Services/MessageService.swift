import ServiceBoard
import ServiceContracts

public protocol NetworkProtocol {
    func request()
}

public struct MessageService: MessageServiceContract {
    public let moduleName = "Message"
    
    let network: NetworkProtocol?
    let category: String
    
    init(network: NetworkProtocol? , category: String) {
        self.network = network
        self.category = category
    }
    
    public func logMsg() {
        network?.request()
        print("hello: \(category)")
    }
}

extension MessageService: DiscoverableService {
    public static func onDiscovery(resolver: ServiceResolver, contract: MessageContract) -> MessageContract.Content {
//        let net = resolver.newtwork()
        MessageService(network: nil, category: contract.category)
    }
}

public struct EmptyContract: ServiceContract {
    public typealias Content = Void
}



