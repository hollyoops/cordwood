// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



import ServiceBoard
import Books
import BooksContracts
import Cart
import CartContracts
import Customer
import CustomerContracts

struct DiscoveredServices: DiscoveredEntry {
  func register(registry: ServiceRegitry) {
    registry.registerService(ProductListRequest.self, factory: AllBooksView.onDiscovery)
    registry.registerService(CartEntryRequest.self, factory: CartView.onDiscovery)
    registry.registerService(CustomerEntryRequest.self, factory: CustomerView.onDiscovery)
  }
}
