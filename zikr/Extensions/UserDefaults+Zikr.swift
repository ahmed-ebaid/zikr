import Foundation

extension UserDefaults {
    static func isFirstLaunch() -> Bool {
        let hasLaunchedBeforeFlag = "hasLaunchedBefore"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasLaunchedBeforeFlag)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: hasLaunchedBeforeFlag)
        }
        return isFirstLaunch
    }
}
