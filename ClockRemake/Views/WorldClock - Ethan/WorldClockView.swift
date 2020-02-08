//
//  WorldClockView.swift
//  Timer
//
//  Created by Ibrahim Syed on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

// I, Ibrahim Syed, did the World Clock. This is pretty straightforward and taught me a lot about the
// way SwiftUI works. It starts by automatically adding a row that indicates the local time zone.
// Next, there is an edit button, which does not work, and an add button. The add button
// pulls up a list of all the possible time zones built into the apple time zone library
// from where one can either scroll to choose one or they can type in a search query to find
// A location of interest. When the item is selected, it gets added to a dynamic array
// which then automatically adds a new row to the world clock view. There aren't any bugs as far
// as I can tell. It doesn't have persistance and the city names are kind of weird, but substrings
// are weird in Swift and I'd rather not mess with them.

import SwiftUI

struct WorldClockView: View {
    
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
            .navigationBarItems(trailing: Button(action: {
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
    
    func getDate(zone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = zone
        return dateFormatter.string(from: Date())
    }
    
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
                HStack {
                    Text(getDate(zone: TimeZone.init(abbreviation: timeZone.zone)!))
                    Spacer()
                }
            }
            LargeTimeView(time: Date(), timeZone: TimeZone(abbreviation: timeZone.zone))
        }
        .padding(8)
    }
    
}
