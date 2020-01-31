//
//  ContentView.swift
//  Timer
//
//  Created by Ethan Humphrey on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            WorldClockView()
                .tabItem {
                    VStack {
                        Image(systemName: "globe")
                        Text("World Clock")
                    }
            }
            .tag(0)
            AlarmView()
                .tabItem {
                    VStack {
                        Image(systemName: "alarm.fill")
                        Text("Alarms")
                    }
            }
            .tag(1)
            StopwatchView()
                .tabItem {
                    VStack {
                        Image(systemName: "stopwatch.fill")
                        Text("Stopwatch")
                    }
            }
            .tag(2)
            StopwatchView()
                .tabItem {
                    VStack {
                        Image(systemName: "timer")
                        Text("Timer")
                    }
            }
            .tag(3)
        }
        .accentColor(Color(.systemPurple))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
