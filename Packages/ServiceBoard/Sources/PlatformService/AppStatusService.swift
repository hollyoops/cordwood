import ServiceContracts

public class DefaultAppStatusService: AppStatusService {
    public init() {}
    
    private var listeners: [AppStatusListener] = []
    
    public private(set) var appStatus: AppStatus = .inactive {
        didSet {
            fireAppStatusChange(to: appStatus)
        }
    }
    
    public func add<T: AppStatusListener & Equatable>(listener: T) {
        listeners.append(listener)
    }
    
    public func remove<T: AppStatusListener & Equatable>(listener: T) {
        listeners = listeners.filter { handler in
            guard let element = handler as? T  else {
                return true
            }
            return element == listener
        }
    }
    
    private func fireAppStatusChange(to status: AppStatus) {
        listeners.forEach {  $0.onAppStatusChange(status: status) }
    }
}

extension DefaultAppStatusService: AppStatusDispather {
     public func changeAppStatus(to status: AppStatus) {
        appStatus = status
    }
}
