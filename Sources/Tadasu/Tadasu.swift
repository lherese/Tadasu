import Foundation

struct Tadasu {

  static var bundle: Bundle = {
    #if DEBUG
    #if os(macOS)
    let url = URL(fileURLWithPath: "\(NSString(#filePath).deletingLastPathComponent)/../../.build/debug/Tadasu_Tadasu.bundle")
    #else
    let url = URL(fileURLWithPath: "\(NSString(#filePath).deletingLastPathComponent)/../../.build/debug/Tadasu_Tadasu.resources")
    #endif
    let bundle = Bundle(url: url)!
    #else
    let bundle = Bundle.module
    #endif

    return bundle
  }()

}
