import SwiftUI
import ServiceContracts

public struct MainTabBar: View {
    public let moduleName: String = "Main"
    public var body: some View {
        VStack {
            Text(verbatim:"Family Outings")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.primary)
            
            TabView {
                Text("The First Tab")
                  .tabItem {
//                    Label("First", systemImage: "1.square.fill")
                      Text("First")
                  }
                
                Text("The Second Tab")
                  .tabItem {
//                    Label("Second", systemImage: "2.square.fill")
                      Text("2")
                  }
                
                Text("The Third Tab")
                  .tabItem {
//                    Label("Third", systemImage: "3.square.fill")
                      Text("3")
                  }
            }
        }
    }
}

extension MainTabBar: DiscoverableService {
    public static func onDiscovery(resolver: ServiceResolver, contract: MainTabBarService) -> MainTabBarService.Content {
        AnyView(MainTabBar())
    }
}
