//
//  AlarmView.swift
//  Timer
//
//  Created by Ethan Humphrey on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

/*

 Welcome to Ethan's section of this project. Obviously I've had my hands in each different part of the app but this is what I spent the majority of my time on.
 The AlarmView displays all added alarms. Similar to my Run Mapper app, it uses CoreData to save the alarms and persist them.
 One interesting thing I collaborated on with Ibra is the "LargeTimeView". This is the view that has the time in large font with the am/pm in small font. We made it a separate view that takes both the time and time zone so that we can use it both in the world clock view and the alarm view.
 Adding an alarm is simple and just opens the NewAlarmView.
 To notify the user, I use iOS's notifications. Activating an alarm registers the notification and deactivating it deregisters.
 If the time is set to earlier than the current time, it schedules the alarm for tomorrow at that time (for morning alarms to work)
 Lastly, after an alarm goes off the system checks if there is a notification with that ID still pending, and if not changes the state of the alarm to reflect that it has gone off.
 Enjoy!
 
*/

import SwiftUI

struct AlarmView: View {
    
    @Environment(\.managedObjectContext)
    var viewContext
    
    @State var showNewAlarmView = false
    
    var body: some View {
        NavigationView {
            AlarmListView()
                .environment(\.managedObjectContext, self.viewContext)
                .navigationBarTitle("Alarms")
                .navigationBarItems(
                    leading: EditButton(),
                    trailing: Button(
                        action: {
                            withAnimation {
                                self.showNewAlarmView = true
                            }
                    }
                    ) {
                        Image(systemName: "plus")
                            .padding(5)
                    }
            )
                .sheet(isPresented: $showNewAlarmView) {
                    NewAlarmView(isPresented: self.$showNewAlarmView)
                        .accentColor(Color(.systemPurple))
                        .environment(\.managedObjectContext, self.viewContext)
            }
            .onAppear {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (authorized, error) in
                    print("Notifications Authorized: \(authorized)")
                }
            }
        }
    }
}

struct AlarmListView: View {
    @Environment(\.managedObjectContext)
    var viewContext
    
    @FetchRequest(entity: Alarm.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Alarm.time, ascending: true)],
    predicate: NSPredicate(value: true),
    animation: .default)
    var alarms: FetchedResults<Alarm>
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            List {
                ForEach(alarms, id: \.self) { alarm in
                    AlarmCell(alarm: alarm)
                }
                .onDelete { indices in
                    self.alarms.delete(at: indices, from: self.viewContext)
                }
            }
        }
    }
}

struct AlarmCell: View {
    
    @ObservedObject var alarm: Alarm
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: nil) {
                LargeTimeView(time: alarm.time, timeZone: TimeZone.current)
                Text(alarm.name ?? "Alarm")
            }
                
            Spacer()
            Toggle(isOn: $alarm.isOn) {
                Text("")
            }
                .labelsHidden()
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
