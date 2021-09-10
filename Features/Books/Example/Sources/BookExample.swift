import SwiftUI
import ServiceBoard
import BooksContracts

@main
struct BookExample: App {
    @UIApplicationDelegateAdaptor(BookAppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            appDelegate.serviceBoard.service(for: ProductListRequest())
                .onOpenURL { url in
                    print("Received URL: \(url)")
                 }
        }
    }
}
