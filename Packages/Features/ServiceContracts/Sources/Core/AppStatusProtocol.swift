public typealias AppStatusProtocol = AppStatusService & AppStatusDispather

public enum AppStatus {
    case launch
    case inactive
    case active
    case background
}

public protocol AppStatusListener {
    func onAppStatusChange(status: AppStatus)
}

public protocol AppStatusDispather {
    func changeAppStatus(to status: AppStatus)
}

public protocol AppStatusService {
    var appStatus: AppStatus { get }
    
    func add<T: AppStatusListener & Equatable>(listener: T)
    
    func remove<T: AppStatusListener & Equatable>(listener: T)
}
