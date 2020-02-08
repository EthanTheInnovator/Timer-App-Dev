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
    
    @State private var showModal: Bool = false
    
    @State var selectedCity: [IbraTimeZone] = [IbraTimeZone(zone: "\(TimeZone.current.abbreviation() ?? "")", location: "Randolph")]
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(selectedCity.indices, id:\.self) { idx in
                        IbraTimeZoneRow(timeZone: self.selectedCity[idx])
                    }
                }
            }
            .navigationBarTitle("World Clock")
            .navigationBarItems(leading: Button(action: {
                
            }, label: {
                Text("Edit")
            }), trailing: Button(action: {
                self.showModal = true
            }, label: {
                Image(systemName: "plus")
                    .padding(5)
            }).sheet(isPresented: self.$showModal) {
                WorldCityPickerView(selectedCity: self.$selectedCity)
            })
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
