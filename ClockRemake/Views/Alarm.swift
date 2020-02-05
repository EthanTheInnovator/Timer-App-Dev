//
//  Alarm.swift
//  ClockRemake
//
//  Created by Ethan Humphrey on 2/3/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//


import SwiftUI
import CoreLocation
import CoreData
import UserNotifications

extension Alarm {
    static func create(in managedObjectContext: NSManagedObjectContext, name: String, time: Date) {
        let newAlarm = self.init(context: managedObjectContext)
        newAlarm.name = name
        if name == "" {
            newAlarm.name = "Alarm"
        }
        newAlarm.time = time
        newAlarm.registerNotification()
        
        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func registerNotification() {
        let content = UNMutableNotificationContent()
        content.title = self.name ?? "Alarm"
        
        if self.time != nil {
            let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: self.time!)
            var notifcationDate = Calendar.current.date(bySettingHour: timeComponents.hour!, minute: timeComponents.minute!, second: 0, of: Date())!
            if notifcationDate < Date() {
                notifcationDate = Calendar.current.date(byAdding: .day, value: 1, to: notifcationDate)!
            }
            
            content.body = getTimeString()
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.month, .year, .day, .hour, .minute], from: notifcationDate), repeats: false)
            
            
            let request = UNNotificationRequest(identifier: self.uuid?.uuidString ?? "", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { (error) in
                print(error)
            }
        }
    }
    
    func getTimeString() -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        return timeFormatter.string(from: time!)
    }
}

extension Collection where Element == Alarm, Index == Int {
    func delete(at indices: IndexSet, from managedObjectContext: NSManagedObjectContext) {
        indices.forEach { managedObjectContext.delete(self[$0]) }

        do {
            try managedObjectContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

