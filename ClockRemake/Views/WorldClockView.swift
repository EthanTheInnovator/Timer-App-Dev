//
//  WorldClockView.swift
//  Timer
//
//  Created by Ethan Humphrey on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

import SwiftUI

struct WorldClockView: View {
    
    let zones = [IbraTimeZone(zone: ""), IbraTimeZone(zone: ""), IbraTimeZone(zone: "")]
    
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
                Text("hi")
            }), trailing: Button(action: {
                
            }, label: {
                Text("hi2")
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
}

struct IbraTimeZoneRow: View {
    @State var timeZone: IbraTimeZone
    @State private var showGreeting = true
    
    var body: some View {
        HStack {
            Text("Here is the zone \(timeZone.zone)")
            Toggle(isOn: $showGreeting) {
                Text("Meow")
            }.padding()
            
            if showGreeting {
                Text("Test")
            }
        }
    }
}
