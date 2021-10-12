import Swinject

public class ServiceBoard {
    // PlatformService
    private let appStatus: AppStatusProtocol
    private let entry: DiscoveredEntry
    private let serviceSPC: SPC
    
    // OndemandService
    let container = Container()
    
    public init(serviceEntry: DiscoveredEntry,
         appStatusService: AppStatusProtocol = DefaultAppStatusService()) {
        self.entry = serviceEntry
        self.appStatus = appStatusService
        self.serviceSPC = SPC(container: container)
    }
    
    public var registry: ServiceRegitry {
        self
    }

    public func discover() {
        entry.register(registry: self)
    }
    
    public func changeAppStatus(to status: AppStatus) {
        appStatus.changeAppStatus(to: status)
    }
}

extension ServiceBoard: ServiceRegitry {
    public func resolve() -> ServiceResolver {
        self
    }
    
    public func registerService<Service: ServiceContract>(
        _ serviceType: Service.Type,
        factory: @escaping (ServiceResolver, Service) -> Service.Response
    ) {
        container.register(Service.Response.self, name: nil) { _, spec in
            factory(self.resolve(), spec)
        }
    }
}

extension ServiceBoard: ServiceResolver {
    public var spc: ServiceProcedureCall {
        serviceSPC
    }
    
    public var appStatusService: AppStatusService {
        appStatus
    }
}


struct SPC: ServiceProcedureCall {
    private let container: Container
    
    init(container: Container) {
        self.container = container
    }
    
    public func resolveService<Service: ServiceContract>(
        _ serviceType: Service.Type,
        argument: Service
    ) -> Service.Response? {
        container.resolve(Service.Response.self, name: nil, argument: argument)
    }
    
    public func getService<T: ServiceContract>(request contract: T) -> T.Response? {
        resolveService(T.self, argument: contract)
    }
}
