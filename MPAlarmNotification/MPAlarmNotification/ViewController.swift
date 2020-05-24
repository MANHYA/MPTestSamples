//
//  ViewController.swift
//  MPAlarmNotification
//
//  Created by Manish on 4/10/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit
import UserNotifications

extension UNUserNotificationCenter{
    func cleanRepeatingNotifications(){
        //cleans notification with a userinfo key endDate
        //which have expired.
        var cleanStatus = "Cleaning...."
        getPendingNotificationRequests {
            (requests) in
            for request in requests{
                if let endDate = request.content.userInfo["endDate"]{
                    if Date() >= (endDate as! Date){
                        cleanStatus += "Cleaned request"
                        let center = UNUserNotificationCenter.current()
                        center.removePendingNotificationRequests(withIdentifiers: [request.identifier])
                        center.removeDeliveredNotifications(withIdentifiers: [request.identifier])
                        
                    } else {
                        cleanStatus += "No Cleaning"
                    }
                    print(cleanStatus)
                }
            }
        }
    }
    
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { (granted, error) in
            if error == nil {
                //self.repeatNotification()
                self.setAlarm()
            }
            if let error = error {
                print("granted, but Error in notification permission:\(error.localizedDescription)")
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func repeatNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Pizza Time!!"
        content.body = "Monday is Pizza Day"
        content.categoryIdentifier = "pizza.reminder.category"
        
        //for testing
        content.userInfo["endDate"] = Date(timeIntervalSinceNow: 60.00)
        
        // Set the end date to a number of days
        //let dayInSeconds = 86400.0
        //content.userInfo["endDate"] = Date(timeIntervalSinceNow: dayInSeconds * 90)
        
        //A repeat trigger for every minute
        //You cannot make a repeat shorter than this.
        //let  trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60.0, repeats: true)
        
        //Date component trigger
        var dateComponents = DateComponents()
        
        // a more realistic example for Gregorian calendar. Every Monday at 11:30AM
        //dateComponents.hour = 11
        //dateComponents.minute = 30
        //dateComponents.weekday = 2
        
        // for testing, notification at the top of the minute.
        dateComponents.second = 10
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "pizza.reminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error in pizza reminder: \(error.localizedDescription)")
            }
        }
        print("added notification:\(request.identifier)")
    }

    func setAlarm() {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Hi!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "Its time to meditate",
                                                                arguments: nil)
        content.categoryIdentifier = "TIMER_EXPIRED"
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "out.caf"))
        
        let weekdaySet = [1,2,3,4,5,6,7]
        
        for i in weekdaySet {
            
            let anchorComponents = Calendar.current.dateComponents([.second, .minute, .hour], from: Date())
            var dateInfo = DateComponents()
            dateInfo.hour = anchorComponents.hour
            dateInfo.minute = anchorComponents.minute
            dateInfo.second = anchorComponents.second
            dateInfo.weekday = i
            dateInfo.timeZone = .current
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateInfo, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { (error : Error?) in
                if let theError = error {
                    print(theError.localizedDescription)
                }
            }
        }
    }
}

