//
//  WorldClockView.swift
//  Timer
//
//  Created by Ibrahim Syed on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

import SwiftUI

struct WorldClockView: View {
    
    let zones = [IbraTimeZone(zone: "\(TimeZone.current.abbreviation() ?? "")", location: "Randolph"),
                 IbraTimeZone(zone: "GMT", location: "London"),
                 IbraTimeZone(zone: "EDT", location: "NYC")]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(zones) { zone in
                        IbraTimeZoneRow(timeZone: zone)
                    }
                }
            }
            .navigationBarTitle("World Clock")
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                Text("Edit")
            }), trailing: Button(action: {
                
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}

struct WorldClockView_Previews: PreviewProvider {
    static var previews: some View {
        WorldClockView()
    }
}

struct IbraTimeZone: Identifiable {
    var id = UUID()
    var zone: String
    var location: String
}

struct IbraTimeZoneRow: View {
    @State var timeZone: IbraTimeZone
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text(timeZone.location)
                    Spacer()
                }
                HStack {
                    Text("\(timeZone.zone)")
                    Spacer()
                }
            }
            LargeTimeView(time: Date(), timeZone: TimeZone(abbreviation: timeZone.zone))
        }
        .padding(8)
    }
    
}
