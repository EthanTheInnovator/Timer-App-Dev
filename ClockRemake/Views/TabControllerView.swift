//
//  ContentView.swift
//  Timer
//
//  Created by Ethan Humphrey on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//
// Note: Comments are in each individual view
import SwiftUI

struct TabControllerView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection){
            WorldClockView()
                .tabItem {
                    VStack {
                        Image(systemName: "globe")
                            .font(.system(size: 25))
                        Text("World Clock")
                    }
            }
            .tag(0)
            AlarmView()
                .tabItem {
                    VStack {
                        Image(systemName: "alarm.fill")
                            .font(.system(size: 25))
                        Text("Alarms")
                    }
            }
            .tag(1)
            StopwatchView()
                .tabItem {
                    VStack {
                        Image(systemName: "stopwatch.fill")
                            .font(.system(size: 25))
                        Text("Stopwatch")
                    }
            }
            .tag(2)
        }
        .accentColor(Color(.systemPurple))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabControllerView()
    }
}
