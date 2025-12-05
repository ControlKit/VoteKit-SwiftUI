# VoteKit-SwiftUI

A powerful and customizable iOS voting component built with **SwiftUI** that provides an elegant way to collect user feedback and votes in your iOS applications. VoteKit-SwiftUI is the SwiftUI version of the popular [VoteKit](https://github.com/ControlKit/VoteKit.git) framework, offering the same functionality with modern SwiftUI declarative syntax.

## 🚀 Features

* **SwiftUI Native**: Built entirely with SwiftUI for modern iOS development
* **Multiple Presentation Styles**: Choose from 5 different UI styles (Fullscreen, Popover variants)
* **Highly Customizable**: Extensive theming options for colors, fonts, layouts, and animations
* **Localization Support**: Built-in multi-language support with `CKLanguage`
* **Async/Await Ready**: Modern Swift concurrency support
* **Network Integration**: Built-in API integration for vote submission
* **Smart Caching**: Prevents duplicate vote prompts using UserDefaults
* **Responsive Design**: Adapts to different screen sizes and orientations
* **Alert System**: Customizable success/error alerts with smooth animations
* **UIKit Compatible**: Can be used in UIKit projects via `UIHostingController`

## 📱 Screenshots

_Coming soon - Add screenshots of different styles_

## 🏗️ Architecture

VoteKit-SwiftUI follows a clean MVVM architecture with the following key components:

### Core Components

* **VoteKit**: Main entry point and coordinator
* **VoteView**: SwiftUI view that handles presentation and user interactions
* **VoteViewModelObservable**: Observable wrapper for business logic and data management
* **VoteViewConfig**: Comprehensive styling and configuration (SwiftUI version)
* **VoteViewStyle**: Multiple UI presentation styles

### Key Protocols

* **Votable**: Core voting functionality
* **VoteActionable**: Action handling
* **VoteSavable**: Data persistence

## 📦 Installation

### Swift Package Manager

Add VoteKit-SwiftUI to your project using Swift Package Manager:

```swift
dependencies: [
    .package(url: "https://github.com/ControlKit/VoteKit-SwiftUI.git", from: "1.0.0")
]
```

### CocoaPods

Add VoteKit-SwiftUI to your `Podfile`:

```ruby
pod 'VoteKit-SwiftUI'
```

Then run:

```bash
pod install
```

## 🎯 Quick Start

### SwiftUI Usage (Recommended)

Get started with VoteKit-SwiftUI in just a few lines:

```swift
import VoteKit_SwiftUI
import SwiftUI

struct ContentView: View {
    @State private var voteView: VoteView?
    
    var body: some View {
        VStack {
            Button("Show Vote") {
                Task {
                    await loadVote()
                }
            }
            
            if let voteView = voteView {
                voteView
            }
        }
    }
    
    private func loadVote() async {
        let voteKit = VoteKit()
        let config = VoteServiceConfig(
            style: .fullscreen1,
            appId: "your-app-id",
            name: "feature-feedback",
            language: .english
        )
        
        voteView = await voteKit.configure(config: config)
    }
}
```

### UIKit Usage

You can also use VoteKit-SwiftUI in UIKit projects:

```swift
import VoteKit_SwiftUI
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVoteKit()
    }
    
    private func setupVoteKit() {
        Task {
            let voteKit = VoteKit()
            let config = VoteServiceConfig(
                style: .popover1,
                appId: "com.yourapp.vote",
                name: "user-satisfaction",
                language: .english
            )
            
            guard let voteView = await voteKit.configure(config: config) else {
                return
            }
            
            let hostingController = UIHostingController(rootView: voteView)
            hostingController.modalPresentationStyle = .overCurrentContext
            present(hostingController, animated: true)
        }
    }
}
```

## 🎨 Advanced Usage

### Custom Styling

VoteKit-SwiftUI offers extensive customization options using SwiftUI's declarative syntax:

```swift
let customConfig = VoteServiceConfig(
    style: .popover1,
    appId: "your-app-id",
    name: "custom-vote",
    language: .english
)

// Customize appearance
customConfig.viewConfig.title = "Rate Our App"
customConfig.viewConfig.question = "How would you rate your experience?"
customConfig.viewConfig.buttonBackColor = .blue
customConfig.viewConfig.popupViewCornerRadius = 20
customConfig.viewConfig.titleFont = Font.system(size: 24, weight: .bold)

// Apply custom colors
customConfig.viewConfig.popupViewBackColor = Color(.systemBackground)
customConfig.viewConfig.questionViewBackColor = Color(.secondarySystemBackground)
customConfig.viewConfig.buttonTitleColor = .white

// Customize alerts
customConfig.viewConfig.successMessage = "Thank you for your feedback!"
customConfig.viewConfig.errorMessage = "Oops! Something went wrong. Please try again."
customConfig.viewConfig.alertSuccessIconColor = .green
customConfig.viewConfig.alertErrorIconColor = .red
```

### Multiple Presentation Styles

Choose from 5 different presentation styles:

```swift
// Fullscreen style
let fullscreenConfig = VoteServiceConfig(
    style: .fullscreen1,
    appId: "app-id",
    name: "fullscreen-vote",
    language: .english
)

// Popover styles
let popover1Config = VoteServiceConfig(
    style: .popover1,  // Close button as icon in top-right
    appId: "app-id",
    name: "popover1",
    language: .english
)

let popover2Config = VoteServiceConfig(
    style: .popover2,  // Submit and close buttons side by side
    appId: "app-id",
    name: "popover2",
    language: .english
)

let popover3Config = VoteServiceConfig(
    style: .popover3,  // Submit and close buttons vertically stacked
    appId: "app-id",
    name: "popover3",
    language: .english
)

let popover4Config = VoteServiceConfig(
    style: .popover4,  // Bottom-aligned popover
    appId: "app-id",
    name: "popover4",
    language: .english
)
```

### Complete SwiftUI Example

```swift
import SwiftUI
import VoteKit_SwiftUI

struct VoteExampleView: View {
    @State private var showVote = false
    @State private var voteView: VoteView?
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to VoteKit")
                .font(.largeTitle)
            
            Button("Show Vote Survey") {
                Task {
                    await loadVote()
                    showVote = true
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $showVote) {
            if let voteView = voteView {
                voteView
            }
        }
    }
    
    private func loadVote() async {
        let voteKit = VoteKit()
        let config = VoteServiceConfig(
            style: .popover1,
            appId: "com.example.app",
            name: "user-feedback",
            language: .english
        )
        
        // Customize config
        config.viewConfig.title = "Help Us Improve"
        config.viewConfig.question = "How satisfied are you with our app?"
        config.viewConfig.buttonBackColor = .blue
        config.viewConfig.buttonTitleColor = .white
        
        voteView = await voteKit.configure(config: config)
    }
}
```

## 🔧 Configuration Options

### VoteServiceConfig Properties

| Property   | Type          | Description                 |
| ---------- | ------------- | --------------------------- |
| `appId`    | String        | Your application identifier |
| `name`     | String        | Vote campaign name          |
| `language` | CKLanguage    | Language for localization   |
| `style`    | VoteViewStyle | UI presentation style       |
| `sdkVersion` | String      | SDK version (auto-set)      |

### VoteViewConfig Styling Options

#### Layout & Appearance

* `style`: Presentation style (`.fullscreen1`, `.popover1-4`)
* `popupViewBackColor`: Background color (SwiftUI `Color`)
* `popupViewCornerRadius`: Corner radius
* `contentViewBackColor`: Overlay background
* `contentViewAlpha`: Overlay transparency

#### Typography

* `titleFont`: Title font (SwiftUI `Font`)
* `title`: Title text
* `titleColor`: Title color (SwiftUI `Color`)
* `questionFont`: Question font
* `question`: Question text
* `questionColor`: Question color
* `voteItemFont`: Vote option font
* `voteItemColor`: Vote option color

#### Buttons

* `buttonFont`: Submit button font
* `buttonNormalTitle`: Submit button text
* `buttonBackColor`: Submit button background
* `buttonTitleColor`: Submit button text color
* `buttonCornerRadius`: Submit button corner radius
* `closeButtonFont`: Close button font
* `closeButtonNormalTitle`: Close button text
* `closeButtonBackColor`: Close button background
* `closeButtonTitleColor`: Close button text color

#### Alert System

* `successMessage`: Success alert message
* `errorMessage`: Error alert message
* `alertContainerBackgroundColor`: Alert background
* `alertContainerCornerRadius`: Alert corner radius
* `alertSuccessIconColor`: Success icon color
* `alertErrorIconColor`: Error icon color
* `alertFadeAnimationDuration`: Fade animation duration
* `alertScaleAnimationDuration`: Scale animation duration

## 🌐 API Integration

VoteKit-SwiftUI automatically handles:

1. **Vote Data Fetching**: Retrieves vote campaigns from your server
2. **Vote Submission**: Submits user selections
3. **Duplicate Prevention**: Uses UserDefaults to prevent showing the same vote multiple times
4. **Error Handling**: Graceful error handling with user-friendly messages

### API Endpoints

VoteKit-SwiftUI expects your backend to provide:

* **GET** `/vote`: Fetch vote campaign data
* **POST** `/vote/{id}/submit`: Submit vote selection

### Request/Response Format

```swift
// Vote Request
struct VoteRequest {
    let appId: String
    let name: String
    let sdkVersion: String
}

// Vote Response
struct VoteResponse {
    let data: VoteModel?
}

struct VoteModel {
    let id: String
    let name: String
    let force: Bool
    let title: LocalString?
    let question: LocalString?
    let accept_button_title: LocalString?
    let cancel_button_title: LocalString?
    let vote_options: [VoteOption]
    let sdk_version: String?
    let created_at: String?
}
```

## 🎯 Use Cases

### Simple Feedback Collection

```swift
let voteKit = VoteKit()
let config = VoteServiceConfig(
    appId: "com.app.feedback",
    name: "satisfaction-survey",
    language: .english
)
let voteView = await voteKit.configure(config: config)
```

### Feature Rating

```swift
let config = VoteServiceConfig(
    style: .popover1,
    appId: "com.app.features",
    name: "feature-rating",
    language: .english
)
config.viewConfig.title = "Rate This Feature"
config.viewConfig.question = "How useful is this new feature?"
```

### A/B Testing

```swift
let styleA = VoteServiceConfig(
    style: .fullscreen1,
    appId: "app",
    name: "test-a",
    language: .english
)
let styleB = VoteServiceConfig(
    style: .popover1,
    appId: "app",
    name: "test-b",
    language: .english
)
```

## 🔄 Migration from UIKit Version

If you're using the UIKit version of VoteKit, migrating to VoteKit-SwiftUI is straightforward:

### Before (UIKit)

```swift
let voteKit = VoteKit()
await voteKit.configure(
    root: self,
    config: VoteServiceConfig(...)
)
```

### After (SwiftUI)

```swift
let voteKit = VoteKit()
let voteView = await voteKit.configure(
    config: VoteServiceConfig(...)
)
// Use voteView in your SwiftUI view hierarchy
```

The main differences:
- No need to pass `UIViewController` - returns a SwiftUI `View` instead
- All styling uses SwiftUI types (`Color`, `Font`) instead of UIKit types
- More declarative and composable

## 🔗 Related Projects

* **[VoteKit (UIKit)](https://github.com/ControlKit/VoteKit.git)**: The original UIKit version of VoteKit
* **[VoteKit-Android](https://github.com/ControlKit/VoteKit-Android.git)**: Android version of VoteKit

## 🔒 Privacy & Security

* **No Personal Data**: VoteKit-SwiftUI only collects vote selections, not personal information
* **Device UUID**: Uses anonymous device identifiers for duplicate prevention
* **Secure Communication**: All API calls use HTTPS
* **Local Storage**: Minimal local storage for vote state management

## 🛠️ Requirements

* iOS 13.0+
* Swift 5.5+
* Xcode 13.0+
* SwiftUI support

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📞 Support

If you encounter any issues or have questions:

1. Check the Issues page
2. Create a new issue with detailed information
3. Contact: [your-email@example.com]

## 🚀 Roadmap

* Additional UI styles
* Custom animations
* Analytics integration
* Offline support
* Custom vote types (rating scales, multiple choice, etc.)
* SwiftUI Navigation integration improvements

## 📚 Documentation

For more detailed documentation, please refer to:

* [API Documentation](docs/API.md)
* [Styling Guide](docs/Styling.md)
* [Migration Guide](docs/Migration.md)

---

Made with ❤️ for the iOS community

## About

VoteKit-SwiftUI is the SwiftUI-native version of VoteKit, providing the same powerful voting functionality with modern SwiftUI declarative syntax. Perfect for new SwiftUI projects or migrating existing UIKit projects to SwiftUI.
