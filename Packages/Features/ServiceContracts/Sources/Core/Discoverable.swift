
public protocol ServiceRegitry {
    func registerService<Service: ServiceContract>(
        _ serviceType: Service.Type,
        factory: @escaping (ServiceResolver, Service) -> Service.Content
    )
    
    func resolve() -> ServiceResolver
}

public protocol ServiceResolver {
    func resolveService<Service: ServiceContract>(
        _ serviceType: Service.Type,
        argument: Service
    ) -> Service.Content?
    
    var appStatusService: AppStatusService { get }
}


public protocol DiscoverableService {
    var moduleName: String { get }

    associatedtype Contract: ServiceContract
    
    static func onDiscovery(resolver: ServiceResolver, contract: Contract) -> Contract.Content
}

public protocol ServiceContract {
    associatedtype Content
}

public protocol DiscoveredEntry {
    func register(registry: ServiceRegitry)
}

public struct EmptyServiceContract: ServiceContract {
    public typealias Content = Void
    
    public init() {}
}
