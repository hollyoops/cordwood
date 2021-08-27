import ServiceBoard
import ServiceContracts

public struct ServiceBoardProvider {
    public static func createServiceBoard(
        appStatusService: AppStatusProtocol = DefaultAppStatusService()
    ) -> ServiceBoard {
        
    }
}
