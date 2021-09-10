import ServiceBoard
import CartContracts
import BooksContracts
import RecoilSwift

extension CartStore: DiscoverableService, CartService {
    public var badgeText: Selector<String?> {
        CartStore.cartItemBadgeState
    }
    
    public func addBook(context: RecoilCallbackContext, newBook: [String: Any]) -> Bool {
        guard let book = Book(dict: newBook) else {
            return false
        }

        CartStore.addToCart(context: context, newBook: book)
        return true
    }
    
    public static func onDiscovery(
        resolver: ServiceResolver,
        contract: CartServiceRequest
    ) -> CartServiceRequest.Response {
        CartStore.shared
    }
}
