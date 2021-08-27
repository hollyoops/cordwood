// Generated using Sourcery 1.8.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



import Swinject
import ServiceContracts



public extension ServiceBoard {    
    func main_mainTabBar(_ contract: MainTabBarService) -> MainTabBarService.Content {
        resolveService(MainTabBarService.self, argument: contract)!
    }
}

public extension ServiceBoard {    
    func message_messageService(_ contract: MessageContract) -> MessageContract.Content {
        resolveService(MessageContract.self, argument: contract)!
    }
}



import ServiceBoard
import ServiceContracts
import Analytics
import Main
import Message

struct DiscoveredServices: DiscoveredEntry {
  func register(registry: ServiceRegitry) {
    AnalyticsService.onDiscovery(resolver: registry.resolve(),
                                contract: EmptyServiceContract())
    registry.registerService(MainTabBarService.self, factory: MainTabBar.onDiscovery)
    registry.registerService(MessageContract.self, factory: MessageService.onDiscovery)
  }
}
