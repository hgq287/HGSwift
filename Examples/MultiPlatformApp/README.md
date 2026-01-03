# Multi-Platform SwiftUI Architecture with XcodeGen

This project serves as a practical blueprint for building Apple multi-platform applications using **SwiftUI** and **XcodeGen**. It demonstrates a scalable approach to managing a shared SwiftUI codebase across iOS and macOS while maintaining a clean, modular architecture.

### Architectural Overview

The project is organized into three distinct layers to ensure separation of concerns and ease of maintenance:

* **Application Layer (SwiftUI)**: Dedicated targets for `MultiPlatformApp-iOS` and `MultiPlatformApp-macOS`. These handle platform-specific UI lifecycles using the SwiftUI App protocol.
* **Bridge Layer (Shared UI & Logic)**: A common framework containing shared SwiftUI views and ViewModels, ensuring a unified user experience across the Apple ecosystem.
* **Core Layer (MultiPlatformAppCore)**: The low-level engine where external dependencies (**Alamofire** and **GRDB**) are integrated. This layer is purely platform-agnostic and handles data persistence and networking.

### Technical Highlights

* **SwiftUI Multiplatform Ready**: Optimized for shared SwiftUI views, reducing the need for `#if os(iOS)` or `#if os(macOS)` checks by leveraging modular design.
* **Modular Dependency Management**: External packages (Alamofire, GRDB) are encapsulated within the Core framework. This prevents dependency "leakage" and simplifies the build graph.
* **Unified Platform Support**: Framework targets use a broad `SUPPORTED_PLATFORMS` configuration, enabling compatibility across iOS, macOS, tvOS, watchOS, and visionOS.
* **Professional Configuration**: Uses `.xcconfig` files and integrated unit test bundles for every module, ensuring code quality and environment-specific management.

### How to Build

1. **Requirement**: Ensure **XcodeGen** is installed:
    ```bash
    brew install xcodegen
    ```

2. **Generate**: Run the following command at the root of the project:
    ```bash
    xcodegen generate
    ```

3. **Develop**: Open the generated `MultiPlatformApp.xcodeproj` and you are ready to go.

### Engineering Goal

The primary objective of this setup is to treat project configuration as code. By doing so, we eliminate manual `.pbxproj` maintenance, avoid merge conflicts, and provide a predictable environment for scaling features across the Apple ecosystem.