
public protocol ServiceRegitry {
    func registerService<Service: ServiceContract>(
        _ serviceType: Service.Type,
        factory: @escaping (ServiceResolver, Service) -> Service.Response
    )
    
    func resolve() -> ServiceResolver
}

public protocol ServiceResolver {
    func service<T: ServiceContract>(for contract: T) -> T.Response
    
    var appStatusService: AppStatusService { get }
}


public protocol DiscoverableService {
    var moduleName: String { get }

    associatedtype Contract: ServiceContract
    
    static func onDiscovery(resolver: ServiceResolver, contract: Contract) -> Contract.Response
}

public protocol ServiceContract {
    associatedtype Response
}

public protocol DiscoveredEntry {
    func register(registry: ServiceRegitry)
}

public struct EmptyServiceContract: ServiceContract {
    public typealias Response = Void
    
    public init() {}
}
