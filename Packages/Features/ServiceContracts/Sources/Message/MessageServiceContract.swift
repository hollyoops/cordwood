public protocol MessageServiceContract {
    func logMsg()
}

public struct MessageContract: ServiceContract {
    public typealias Content = MessageServiceContract
    
    public let category: String
}
