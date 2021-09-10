import SwiftUI
import ServiceBoard
import CustomerContracts

@main
struct HostAppApp: App {
    @UIApplicationDelegateAdaptor(HostAppDelegate.self) var appDelegate
 
    var body: some Scene {
        WindowGroup {
            HomeView(board: appDelegate.serviceBoard)
                .onOpenURL { url in
                    print("Received URL: \(url)")
                 }
        }
    }
}
