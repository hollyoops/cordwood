import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .local(path: "./Core/ServiceBoard"),
        .remote(url: "https://github.com/hollyoops/RecoilSwift.git", requirement: .exact("0.2.1"))
    ],
    platforms: [.iOS]
)
