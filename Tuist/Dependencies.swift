import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: .init([
        .local(path: "./Core/ServiceBoard"),
        .remote(url: "https://github.com/hollyoops/RecoilSwift.git", requirement: .exact("0.2.1"))
    ], productTypes: ["ServiceBoard": .framework,
                      "RecoilSwift": .framework,
                      "Hooks": .framework]),
    platforms: [.iOS]
)
