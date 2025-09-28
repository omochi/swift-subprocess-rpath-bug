# On macOS...

As shown below, the build succeeds, but the program cannot be executed.

```
[omochi@omochi-mbp swift-subprocess-rpath-bug (main =)]$ uname -a
Darwin omochi-mbp.local 25.0.0 Darwin Kernel Version 25.0.0: Mon Aug 25 21:17:51 PDT 2025; root:xnu-12377.1.9~3/RELEASE_ARM64_T6020 arm64
[omochi@omochi-mbp swift-subprocess-rpath-bug (main =)]$ sw_vers
ProductName:		macOS
ProductVersion:		26.0
BuildVersion:		25A354
[omochi@omochi-mbp swift-subprocess-rpath-bug (main =)]$ xcode-select -p
/Applications/Xcode26-beta.1.app/Contents/Developer
[omochi@omochi-mbp swift-subprocess-rpath-bug (main =)]$ swift --version
swift-driver version: 1.127.14.1 Apple Swift version 6.2.1 (swiftlang-6.2.1.1.1 clang-1700.4.1.1)
Target: arm64-apple-macosx26.0
[omochi@omochi-mbp swift-subprocess-rpath-bug (main =)]$ swift build
Building for debugging...
[1/1] Write swift-version-4CD727DE078F09A4.txt
Build complete! (0.12s)
[omochi@omochi-mbp swift-subprocess-rpath-bug (main =)]$ swift run  
Building for debugging...
[1/1] Write swift-version-4CD727DE078F09A4.txt
Build of product 'Bug' complete! (0.12s)
dyld[48424]: Library not loaded: @rpath/libswiftCompatibilitySpan.dylib
  Referenced from: <E771F9ED-AE48-355E-9D70-2B484AA3AC86> /Users/omochi/github/omochi/swift-subprocess-rpath-bug/.build/arm64-apple-macosx/debug/Bug
  Reason: tried: '/Users/omochi/github/omochi/swift-subprocess-rpath-bug/.build/arm64-apple-macosx/debug/libswiftCompatibilitySpan.dylib' (no such file), '/Users/omochi/github/omochi/swift-subprocess-rpath-bug/.build/arm64-apple-macosx/debug/libswiftCompatibilitySpan.dylib' (no such file)
zsh: abort      swift run
```

It seems that `libswiftCompatibilitySpan.dylib` cannot be found.
Curiously, it does run when executed from Xcode.
When I checked with `otool`, I found that when Xcode builds, `/usr/lib/swift` is set as an RPath, but when built with SwiftPM, that RPath is missing.
