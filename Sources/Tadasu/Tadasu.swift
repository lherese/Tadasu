import Foundation

struct Tadasu {

  static var bundle: Bundle = {
    #if DEBUG
    return Bundle(url: URL(fileURLWithPath: "\(NSString(#filePath).deletingLastPathComponent)/../../.build/debug/Tadasu_Tadasu.bundle"))!
    #else
    return Bundle.module
    #endif
  }()

}
