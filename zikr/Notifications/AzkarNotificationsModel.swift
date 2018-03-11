import UserNotifications

class AzkarNotificationsModel: NSObject, UNUserNotificationCenterDelegate {
    let center =  UNUserNotificationCenter.current()
    let morningAzkarcontent = UNMutableNotificationContent()
    let eveningAzkarContent = UNMutableNotificationContent()
    let identifier = "ContentIdentifier"
    
    private func configureAndGetNotificationRequest() -> UNNotificationRequest {
        morningAzkarcontent.title = "وقت أذكار الصباح"
        morningAzkarcontent.subtitle = "Lunch"
        morningAzkarcontent.body = "Its lunch time at the park, please join us for a dinosaur feeding"
        morningAzkarcontent.sound = UNNotificationSound.default()
    
    //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:60.0, repeats: true)
    
    //create request to display
        return UNNotificationRequest(identifier: "ContentIdentifier", content: morningAzkarcontent, trigger: trigger)
    }
    
    func toggleNotifications(with value: Bool) {
        if value {
            let notificationRequest = configureAndGetNotificationRequest()
            center.add(notificationRequest) { error in
                if error != nil {
                    print("error \(String(describing: error))")
                }
            }
        } else {
            center.removePendingNotificationRequests(withIdentifiers: [identifier])
        }
    }
    
    //Marker Delegate Methods
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge]) //required to show notification when in foreground
    }
    
}
