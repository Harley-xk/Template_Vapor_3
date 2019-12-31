// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "{{cookiecutter.product_name}}",
    products: [
        .library(name: "{{cookiecutter.product_name}}", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on MySQL 3.
        .package(url: "https://github.com/vapor/fluent-mysql.git", from: "3.0.0"),

        // multipart
        .package(url: "https://github.com/vapor/multipart.git", from: "3.0.0"),
        
        // Authentication
        .package(url: "https://github.com/vapor/auth.git", from: "2.0.0"),

        // Swift HTML Renderer
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "App", dependencies: [
            "FluentMySQL",
            "Vapor",
            "Multipart",
            "Leaf",
            "Authentication",
        ]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

