//
//  AlarmView.swift
//  Timer
//
//  Created by Ethan Humphrey on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

import SwiftUI

struct AlarmView: View {
    
    var body: some View {
        NavigationView {
            AlarmListView()
        }
    }
}

struct AlarmListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Alarm.time, ascending: true)],
        animation: .default)
    var alarms: FetchedResults<Alarm>

    @Environment(\.managedObjectContext)
    var viewContext
    
    var body: some View {
        List {
            ForEach(alarms, id: \.self) { alarm in
                HStack {
                    VStack {
                        Text("9:21AM")
//                        Text(alarm.name)
                    }
                    Spacer()
                    
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
