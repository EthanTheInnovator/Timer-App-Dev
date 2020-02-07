//
//  AlarmView.swift
//  Timer
//
//  Created by Ethan Humphrey on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

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
            VStack {
                Text("\(alarm.name ?? "")")
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
