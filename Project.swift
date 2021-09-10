import ProjectDescription
import ProjectDescriptionHelpers

let configurations: [Configuration] = [
    .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/Base/Configurations/Debug.xcconfig")),
    .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/Base/Configurations/Release.xcconfig")),
]

let features: [ModuleConfig] = [
    .init(name: "Customer"),
    .init(name: "Cart"),
    .init(name: "Books")
]

let appInfo = AppConfig(name: "BookStore",
                        features: features)


let project = Project.makeAppProject(appConfig: appInfo)
