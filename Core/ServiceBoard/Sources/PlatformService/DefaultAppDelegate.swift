import UIKit

public protocol SBAppDelegate: UIApplicationDelegate {
    var serviceBoard: ServiceBoard { get }
}

open class DefaultAppDelegate: NSObject, SBAppDelegate {
    private var board: ServiceBoard?
    
    public var serviceBoard: ServiceBoard {
        assert(board != nil)
        return board!
    }
    
    public func attachServiceBoard(_ board: ServiceBoard) {
        self.board = board
    }
    
    open func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        serviceBoard.discover()
        serviceBoard.changeAppStatus(to: .launch)
        return true
    }
    
    open func applicationDidBecomeActive(_ application: UIApplication) {
        serviceBoard.changeAppStatus(to: .active)
    }
    
    open func applicationWillResignActive(_ application: UIApplication) {
        serviceBoard.changeAppStatus(to: .inactive)
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        serviceBoard.changeAppStatus(to: .background)
    }
}

// MARK - Sence Dispather
extension DefaultAppDelegate {
    public func onSenceChange() {
        
    }
}
