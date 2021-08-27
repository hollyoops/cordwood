import ServiceBoard
import ServiceContracts

@objc public class MessageModule: NSObject {

}

extension MessageModule : ModuleLoadable {
    public static func onModuleInitialize() {
        print("TestObject--->swiftyInitialize")
      
    }

    public static func onModuleLoad() {
        print("TestObject--->swiftyLoad")
    }
}
