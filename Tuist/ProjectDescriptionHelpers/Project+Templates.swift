import ProjectDescription

let runPhaseTemplate = """
ruby ${SOURCE_ROOT}/CodeGen.rb --configPath=${SOURCE_ROOT}/%@ --template=${SOURCE_ROOT}/Tuist/connectServices.stencil --output=${SOURCE_ROOT}/%@/Sources/__generated__/DiscoveredServices.swift
"""

extension Project {
    public static func makeAppProject(appConfig: AppConfig) -> Project {
        let appName = appConfig.name
        let appScheme = buildSchema(name: appName, path: appConfig.path)
        let exampleSchemes: [Scheme] = appConfig.features.compactMap { feature in
            guard feature.targetTypes.contains(.examples) else {
                return nil
            }
        
            let examplePath = "\(feature.path)/Example"
            return buildSchema(name: "\(feature.name)Example", path: examplePath)
        }
        
        return Project(name: appName,
                       organizationName: "io.microFE.\(appName)",
                       packages: [],
                       targets: Target.makeTargets(appConfig: appConfig),
                       schemes: exampleSchemes + [appScheme]
        )
    }
    
    private static func buildSchema(name: String, path: String) -> Scheme {
        let target = TargetReference(projectPath: nil, target: name)
        let scriptText = String(format: runPhaseTemplate, arguments: [path, path])
        
        return Scheme(
            name: name,
            shared: true,
            buildAction: BuildAction(
                targets: [target],
                preActions: [.init(scriptText: scriptText, target: target)]
            )
        )
    }
}

extension Target {
    public static func makeTargets(appConfig: AppConfig) -> [Target] {
        makeFeatureTargets(appConfig) + makeHostTargets(appConfig)
    }
    
    static func makeHostTargets(_ appInfo: AppConfig) -> [Target] {
        let name = appInfo.name
        return [
            Target(name: name,
                   platform: .iOS,
                   product: .app,
                   bundleId: "io.microFE.\(name)",
                   infoPlist: .default,
                   sources: ["\(appInfo.path)/Sources/**/*.swift"],
                   resources: ["\(appInfo.path)/Resources/**/*"],
                   dependencies: appInfo.targetDependencies
                  ),
            Target(name: "\(name)Tests",
                   platform: .iOS,
                   product: .unitTests,
                   bundleId: "io.microFE.\(name)Tests",
                   infoPlist: .default,
                   sources: ["\(appInfo.path)/Tests/**/*.swift"],
                   dependencies: [
                    .target(name: name),
                    .xctest,
                   ] + appInfo.testDependencies.map({ .target(name: $0) }))
        ]
    }
    
    static func makeFeatureTargets(_ appInfo: AppConfig) -> [Target] {
        appInfo.features.flatMap {
            makeFrameworkTargets($0)
        }
    }
    
    static func makeFrameworkTargets(_ module: ModuleConfig) -> [Target] {
        let dependencies: [String] = module.dependencies
        let testDependencies: [String] = module.testDependencies
        let targets = module.targetTypes
        let dependsOnXCTest = module.dependsOnXCTest
        let name = module.name
        let sdks = [String]()
        
        // Test dependencies
        var targetTestDependencies: [TargetDependency] = [
            .target(name: "\(name)"),
            .xctest,
        ] + testDependencies.map({ .target(name: $0) })
        dependencies.forEach { targetTestDependencies.append(.target(name: "\($0)Testing")) }
        
        // Target dependencies
        var targetDependencies: [TargetDependency] = dependencies.map { .target(name: $0) }
        targetDependencies.append(contentsOf: sdks.map { .sdk(name: $0, type: .framework) })
        if dependsOnXCTest {
            targetDependencies.append(.xctest)
        }
        
        // Targets
        var projectTargets: [Target] = []
        if targets.contains(.contracts) {
            projectTargets.append(Target(name: "\(name)Contracts",
                                         platform: .iOS,
                                         product: .framework,
                                         bundleId: "io.microFE.\(name)Contracts",
                                         infoPlist: .default,
                                         sources: ["\(module.path)/Contracts/**/*.swift"],
                                         dependencies: module.targetDependencies))
        }
        
        if targets.contains(.framework) {
            let td = targets.contains(.contracts) ? [TargetDependency.target(name: "\(name)Contracts")] : []
            projectTargets.append(Target(name: name,
                                         platform: .iOS,
                                         product: .framework,
                                         bundleId: "io.microFE.\(name)",
                                         infoPlist: .default,
                                         sources: ["\(module.path)/Impl/Sources/**/*.swift"],
                                         dependencies: td + targetDependencies))
        }
        
        if targets.contains(.tests) {
            projectTargets.append(Target(name: "\(name)Tests",
                                         platform: .iOS,
                                         product: .unitTests,
                                         bundleId: "io.microFE.\(name)Tests",
                                         infoPlist: .default,
                                         sources: ["\(module.path)/Impl/Tests/**/*.swift"],
                                         dependencies: targetTestDependencies))
        }
        if targets.contains(.examples) {
            projectTargets.append(Target(name: "\(name)Example",
                                         platform: .iOS,
                                         product: .app,
                                         bundleId: "io.microFE.\(name)Example",
                                         infoPlist: .default,
                                         sources: ["\(module.path)/Example/Sources/**/*.swift"],
                                         resources: ["\(module.path)/Example/Resources/**"],
                                         dependencies:
                                            [.target(name: "\(name)")] + module.platformDependencies
                                        ))
        }
        return projectTargets
    }
}
