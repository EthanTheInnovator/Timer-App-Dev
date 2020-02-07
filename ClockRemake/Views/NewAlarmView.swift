//
//  NewAlarmView.swift
//  ClockRemake
//
//  Created by Ethan Humphrey on 2/3/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

import SwiftUI

struct NewAlarmView: View {
    
    @Binding var isPresented: Bool
    @State var alarmTime = Date()
    @State var alarmName = ""
    
    @Environment(\.managedObjectContext)
    var viewContext
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Alarm Label", text: $alarmName)
                DatePicker(selection: $alarmTime, displayedComponents: .hourAndMinute) {
                    Text("Alarm Time")
                }
            }
            .navigationBarItems(leading: Button(action: {
                self.isPresented = false
            }, label: {
                Text("Cancel")
            }), trailing: Button(action: {
                Alarm.create(in: self.viewContext, name: self.alarmName, time: self.alarmTime)
                self.isPresented = false
            }, label: {
                Text("Save")
            }))
            .navigationBarTitle("Add Alarm")
        }
        
    }
}

//struct NewAlarmView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewAlarmView()
//    }
//}
