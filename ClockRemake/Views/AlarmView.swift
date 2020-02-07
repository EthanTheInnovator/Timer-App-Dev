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
        }
    }
}

struct AlarmListView: View {
    @FetchRequest(entity: Alarm.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Alarm.time, ascending: true)],
    predicate: NSPredicate(value: true),
    animation: .default)
    var alarms: FetchedResults<Alarm>
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            List {
                ForEach(alarms, id: \.self) { alarm in
                    HStack {
                        VStack {
                            Text("\(alarm.name ?? "")")
                        }
                        Spacer()
                        
                    }
                }
            }
        }
    }
}

struct AlarmView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmView()
    }
}
