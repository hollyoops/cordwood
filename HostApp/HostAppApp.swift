import SwiftUI
import ServiceBoard
import ServiceContracts

@main
struct HostAppApp: App {
    @UIApplicationDelegateAdaptor(HostAppDelegate.self) var appDelegate
    
//    @Service(MainTabBarService.self) var mainView: AnyView
 
    var body: some Scene {
        WindowGroup {
            appDelegate.serviceBoard.service(for: MainTabBarService())
                .onOpenURL { url in
                    print("Received URL: \(url)")
                 }
        }
    }
}
