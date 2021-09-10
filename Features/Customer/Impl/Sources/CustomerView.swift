import SwiftUI
import CustomerContracts
import ServiceBoard

public struct CustomerView: View {
    public let moduleName: String = "Customer"
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
          NavigationView {
              CustomerContentView()
              .navigationTitle("Profile")
          }
        }
    }
}

extension CustomerView: DiscoverableService {
    public static func onDiscovery(resolver: ServiceResolver, contract: CustomerEntryRequest) -> CustomerEntryRequest.Response {
        AnyView(CustomerView())
    }
}
