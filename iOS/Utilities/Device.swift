import SwiftUI

enum DeviceName: String {
    case iPhone
    case iPad
    case watch
}

func getDeviceName() -> DeviceName {
#if os(iOS)
    if (UIDevice.current.userInterfaceIdiom == .phone) {
        return .iPhone
    } else {
      return .iPad
    }
#else
    return .watch
#endif
}
