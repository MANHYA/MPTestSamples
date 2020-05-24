//
//  AppDelegate.swift
//  MPAlarmNotification
//
//  Created by Manish on 4/10/19.
//  Copyright © 2019 MANHYA. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    func setCategories(){
        let clearRepeatAction = UNNotificationAction(
            identifier: "clear.repeat.action",
            title: "Stop Repeat",
            options: [])
        let pizzaCategory = UNNotificationCategory(
            identifier: "pizza.reminder.category",
            actions: [clearRepeatAction],
            intentIdentifiers: [],
            options: [])
        UNUserNotificationCenter.current().setNotificationCategories([pizzaCategory])
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        setCategories()
        UNUserNotificationCenter.current().cleanRepeatingNotifications()
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UNUserNotificationCenter.current().cleanRepeatingNotifications()
        print("Did recieve response: \(response.actionIdentifier)")
        if response.actionIdentifier == "clear.repeat.action"{
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [response.notification.request.identifier])
        }
        completionHandler()
    }
}
