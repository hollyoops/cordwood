import SwiftUI
import RecoilSwift
import ServiceBoard
import CartContracts

public struct CartView: View {
  public var moduleName = "Cart"
    
  public var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      NavigationView {
        CartContent()
          .navigationTitle("Cart")
      }
    }
  }
}

extension CartView: DiscoverableService {
    public static func onDiscovery(resolver: ServiceResolver, contract: CartEntryRequest) -> CartEntryRequest.Response {
        AnyView(CartView())
    }
}
