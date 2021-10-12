import SwiftUI
import RecoilSwift
import BooksContracts
import CartContracts
import ServiceBoard

//typealias CartBook = CartContracts.

public struct AllBooksView: HookView {
    public let moduleName = "Books"
    public let addToCart: (RecoilCallbackContext, Book) -> Void
    
    public var hookBody: some View {
        let currentBooks = useRecoilValue(ProductStore.currentBooks)
        let fn = useRecoilCallback(addToCart)
        
        NavigationView {
            BooksContent(addClick: fn)
                .navigationTitle("Book shop")
                .ifTrue(!currentBooks.isEmpty) {
                    $0.navigationBarItems(
                        trailing: NavigationLink(
                            "Filter",
                            destination: FilterOptionsView()
                        )
                    )
                }
        }
    }
}

extension View {
    func ifTrue<T: View>(_ condition: Bool, _ transform: (Self) -> T) -> some View {
        condition ? AnyView(transform(self)) : AnyView(self)
    }
}

extension AllBooksView: DiscoverableService {
    public static func onDiscovery(resolver: ServiceResolver, contract: ProductListRequest) -> ProductListRequest.Response {
        let add = { (context: RecoilCallbackContext, book: Book) in
            guard let service = resolver.spc.getService(request: CartServiceRequest()) else {
                
                print("Cart Service Not Found!")
                return
            }
            guard let bookJson = book.json else { return }
            
            _ = service.addBook(context: context, newBook: bookJson)
        }
        
        return AnyView(AllBooksView(addToCart: add))
    }
}
