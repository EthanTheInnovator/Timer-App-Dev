//
//  TimerView.swift
//  Timer
//
//  Created by Ethan Humphrey on 1/31/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    //refreshes timer every 1 second + creates timer
        @State var currentDate: Date = Date() //starting date, @state recreates interface whenever value is changed
        let refDate: Date = Date(timeIntervalSinceNow: 10000)
        var timer: Timer {
           Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                self.currentDate = Date()
            }
        }
        //updates text on screen using given timer invervals
        var body: some View {
            VStack {
                Text(countdownString(from: refDate))
                .font(.title) //sets the font to a "title" font
            }
            .onAppear(perform: { // called when text appears
                _ = self.timer
            })
        }
        //makes a countdown string using a start and end date
        func countdownString(from date: Date) -> String {
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: date)
            let resultString: String = ("Days: \(components.day ?? 00) \nHours: \(components.hour ?? 0) \nMinutes: \(components.minute ?? 0) \nSeconds: \(components.second ?? 0)")
            return resultString
        }
    }

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
