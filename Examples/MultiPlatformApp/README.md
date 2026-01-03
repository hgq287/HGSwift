# Multi-Platform Architecture with XcodeGen

This project serves as a practical blueprint for building Apple multi-platform applications using **XcodeGen**. It demonstrates a scalable approach to managing shared logic across iOS and macOS while maintaining a clean, modular architecture.

### Architectural Overview

The project is organized into three distinct layers to ensure separation of concerns and ease of maintenance:

* **Application Layer**: Dedicated targets for `MultiPlatformApp-iOS` and `MultiPlatformApp-macOS`. These handle platform-specific UI, lifecycles, and entitlements.
* **Bridge Layer (Shared Framework)**: A common framework that acts as a gateway, ensuring a unified API surface for the application targets.
* **Core Layer (MultiPlatformAppCore)**: The low-level engine where external dependencies (**Alamofire** and **GRDB**) are integrated. This layer is designed to be purely platform-agnostic.

### Technical Highlights

* **Modular Dependency Management**: External packages (Alamofire, GRDB) are encapsulated within the Core framework. This prevents dependency "leakage" into the main app targets and simplifies the build graph.
* **Unified Platform Support**: The Framework targets use a broad `SUPPORTED_PLATFORMS` configuration, enabling compatibility across iOS, macOS, tvOS, watchOS, and visionOS from a single source.
* **Professional Configuration**: Uses `.xcconfig` files for Debug and Release environments to keep build settings out of the project file, making it easier to manage environment-specific variables.
* **Integrated Testing Suite**: Each module (App, Shared, and Core) includes its own unit test bundle. Schemes are pre-configured to gather coverage data and provide immediate feedback.
* **Native XcodeGen Features**: Demonstrates the use of `createIntermediateGroups`, `environmentVariables` for schemes, and direct `entitlements` path mapping.

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