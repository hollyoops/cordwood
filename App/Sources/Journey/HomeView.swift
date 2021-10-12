import SwiftUI
import ServiceBoard
import BooksContracts
import CartContracts
import CustomerContracts
import RecoilSwift

extension View {
    func ifLet<T, V: View>(_ value: Optional<T>, fn: (Self, T) -> V) -> AnyView {
        guard let val = value else { return AnyView(self) }
        
        return AnyView(fn(self, val))
    }
}

public struct HomeView: HookView {
    private let serviceBoard: ServiceBoard
    
    init(board: ServiceBoard) {
        self.serviceBoard = board
    }
    
    public var hookBody: some View {
        let cartStore = serviceBoard.spc.getService(request: CartServiceRequest())!
        let badgeText = useRecoilValue(cartStore.badgeText)
        
        TabView {
            serviceBoard.spc.getService(request: ProductListRequest())!
                .tabItem {
                    Label("Store", systemImage: "books.vertical")
                }
            
            serviceBoard.spc.getService(request: CartEntryRequest())!
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }.ifLet(badgeText) {
                    $0.badge(Text($1))
                }
            
            serviceBoard.spc.getService(request: CustomerEntryRequest())!
                .tabItem {
                    Label("Me", systemImage: "person.crop.circle")
                }
        }
    }
}
