import ServiceBoard
import SwiftUI
import RecoilSwift

public struct CartEntryRequest: ServiceContract {
    public typealias Response = AnyView
    
    public init() {}
}

public struct CartServiceRequest: ServiceContract {
    public typealias Response = CartService
    
    public init() {}
}

public protocol CartService {
    var badgeText: RecoilSwift.Selector<String?> { get }
    
    func addBook(context: RecoilCallbackContext, newBook: [String: Any]) -> Bool
}
