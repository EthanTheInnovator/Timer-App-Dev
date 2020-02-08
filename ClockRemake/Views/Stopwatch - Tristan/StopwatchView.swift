//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Ethan Humphrey on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//
//Calculates the difference in time between when the stopwatch was started and the current time using the Date structure and calendars with a few if statements
import SwiftUI
struct StopwatchView: View {
    @State private var currentDate: Date = Date() //starting date, @state recreates interface whenever value is changed
    @State private var firstDate: Date = Date()
    @State private var timerActive: Bool = false
    var timer: Timer {
       Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            if(self.timerActive){ //only increments time if it is active
                self.currentDate = Date(timeInterval: 1, since: self.currentDate)
            }
        }
    }
    //updates text on screen using given timer invervals
    var body: some View {
        VStack {
            Button(action: {
                self.timerActive = true
            }) {
                Text("Start")
            }
            VStack {
                Button(action: {
                    self.timerActive = false
                }) {
                    Text("Stop")
                }
                VStack {
                    Button(action: {
                        self.firstDate = Date()
                        self.currentDate = Date()
                    }) { //lets user reset clock
                        Text("Reset")
                    }
                    VStack { //shows current stopwatch time
                            Text(countupString(from: firstDate))
                            .font(.title) //sets the font to a "title" font
                    }
                    .onAppear(perform: { // called when text appears
                        _ = self.timer
                })
                }
            }
        }
    }
    //makes a string that counts up using a first and current date
    func countupString(from date: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: date, to: currentDate)
        let resultString: String = ("\(components.hour ?? 0 + (24 * (components.day ?? 0))) : \(components.minute ?? 0) : \(components.second ?? 0)")
        //makes a result start with proper formatting, adding days * 24 in hours to account for days in hours, Format: Hours : Minutes : Seconds
        return resultString
    }
}


struct Stopwatch_Previews: PreviewProvider {
    static var previews: some View {
        StopwatchView()
    }
}
