// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



import ServiceBoard
import Books
import BooksContracts

struct DiscoveredServices: DiscoveredEntry {
  func register(registry: ServiceRegitry) {
    registry.registerService(ProductListRequest.self, factory: AllBooksView.onDiscovery)
  }
}
