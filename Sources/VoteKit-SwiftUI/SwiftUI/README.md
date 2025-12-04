# VoteKit SwiftUI

این فولدر شامل نسخه SwiftUI از VoteKit است که از UIKit به SwiftUI تبدیل شده است.

## فایل‌های موجود:

1. **VoteViewConfigSwiftUI.swift**: کلاس کانفیگ برای SwiftUI که از `Color` و `Font` به جای `UIColor` و `UIFont` استفاده می‌کند.

2. **VoteItemSwiftUI.swift**: کامپوننت SwiftUI برای نمایش هر گزینه رای.

3. **AlertViewSwiftUI.swift**: ویو SwiftUI برای نمایش آلرت‌های موفقیت و خطا.

4. **VoteViewFullScreen1SwiftUI.swift**: ویو اصلی SwiftUI برای نمایش فرم رای‌گیری.

5. **VoteViewSwiftUI.swift**: ویو wrapper که منطق submit و dismiss را مدیریت می‌کند.

6. **VoteKitSwiftUI.swift**: کلاس اصلی برای استفاده از VoteKit در پروژه‌های SwiftUI.

## نحوه استفاده:

### در پروژه‌های SwiftUI:

```swift
let voteKit = VoteKitSwiftUI()
let config = VoteServiceConfig(
    style: .fullscreen1,
    appId: "your-app-id",
    name: "vote-name",
    language: .en
)

// دریافت ویو
if let voteView = await voteKit.configure(config: config) {
    // نمایش ویو
}
```

### در پروژه‌های UIKit (با استفاده از UIHostingController):

```swift
let voteKit = VoteKitSwiftUI()
let config = VoteServiceConfig(...)

await voteKit.present(
    in: self,
    config: config,
    modalPresentationStyle: .fullScreen
)
```

## تفاوت‌های کلیدی با نسخه UIKit:

- استفاده از `Color` به جای `UIColor`
- استفاده از `Font` به جای `UIFont`
- استفاده از `@State` و `@Binding` برای مدیریت state
- استفاده از `@ObservedObject` برای view model
- استفاده از modifiers SwiftUI برای styling

