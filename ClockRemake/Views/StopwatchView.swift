//
//  Stopwatch.swift
//  Timer
//
//  Created by Ethan Humphrey on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

import SwiftUI
struct StopwatchView: View {
    @State var currentDate: Date = Date() //starting date, @state recreates interface whenever value is changed
    let firstDate: Date = Date()
    var timer: Timer {
       Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.currentDate = Date()
        }
    }
    //updates text on screen using given timer invervals
    var body: some View {
        VStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Start")
            }
            VStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Stop")
                }
                VStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) { //lets user reset clock
                        Text("Reset")
                    }
                    VStack { //counts up when active
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
