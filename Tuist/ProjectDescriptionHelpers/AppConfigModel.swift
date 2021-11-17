import ProjectDescription

public enum FeatureTarget {
    case framework
    case tests
    case examples
    case contracts
}

protocol BasicConfig {
    var name: String { get }
    var dependencies: [String] { get }
    var testDependencies: [String] { get }
    var path: String { get }
    
    var targetDependencies: [TargetDependency] { get }
}

extension BasicConfig {
    var platformDependencies: [TargetDependency] {
        [.target(name: "CoreKit")]
//        [.external(name: "ServiceBoard"), .external(name: "RecoilSwift")]
    }
}

public struct AppConfig: BasicConfig {
    let name: String
    let features: [ModuleConfig]
    let dependencies: [String] = []
    let testDependencies: [String] = []
    
    public init(name: String, features: [ModuleConfig] = []) {
        self.name = name
        self.features = features
    }
    
    public var featureNames: [String] {
        features.map { $0.name }
    }
    
    public var targetDependencies: [TargetDependency] {
        let deps: [TargetDependency] = (dependencies + featureNames).map({ .target(name: $0) })
        return deps + platformDependencies
    }
    
    public var path: String {
        return "App"
    }
}

public struct ModuleConfig: BasicConfig {
    let name: String
    let dependencies: [String]
    let testDependencies: [String]
    let targetTypes: [FeatureTarget]
    let dependsOnXCTest = false
    
    public init(name: String,
                dependencies: [String] = [],
                testDependencies: [String] = [],
                targets: [FeatureTarget] = [.framework, .tests, .examples, .contracts]) {
        self.name = name
        self.dependencies = dependencies
        self.testDependencies = testDependencies
        self.targetTypes = targets
    }
    
    public var targetDependencies: [TargetDependency] {
        dependencies.map({ .target(name: $0) }) + platformDependencies
    }
    
    public var path: String {
        return "Features/\(name)"
    }
}
