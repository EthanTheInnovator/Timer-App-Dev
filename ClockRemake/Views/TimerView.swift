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
        @State private var currentDate: Date = Date() //starting date, @state recreates interface whenever value is changed
        @State private var showAlert = false //if alert is being shown
        @State private var userInput: String = "" //gets users input
        @State private var refDate: Date = Date() //date to count down from
        @State private var countDown: Bool = false //if app is counting down
        var timer: Timer {
           Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                if(!self.countDown){ //if timer is paused (adds 1 to keep time consistent)
                    self.refDate = Date(timeInterval: 1, since: self.refDate)
                }
                    self.currentDate = Date()
            }
        }
        var body: some View {
            VStack { //Just tells user to input time
                Text("Input timer time (in seconds) below")
                //start btn
                Button(action: {
                    let timeGiven: Int = Int(self.userInput) ?? 0
                    if(timeGiven > 0){
                        self.refDate = Date(timeIntervalSinceNow: TimeInterval(timeGiven))
                        self.countDown = true
                        UIApplication.shared.keyWindow?.endEditing(true) //dismisses keyboard
                    } else {
                        //mabye make an alert saying you need a value > 0
                    }
                }) {
                    Text("Start")
                }
                //pause btn
                Button(action: {
                    self.countDown = !self.countDown //inverts wether or not countdown is happening
                }) {
                    if(countDown){
                        Text("Pause")
                    } else {
                        Text("Unpause")
                    }
                }
                VStack { // Gets time from user
                    TextField("Put time here", text: $userInput)
                    .multilineTextAlignment(TextAlignment.center)
                    .keyboardType(.numberPad) //numpad so only number can be input
                    VStack { //updates text on screen using given timer invervals
                            Text(countdownString(from: refDate))
                            .font(.title) //sets the font to a "title" font
                    }
                    .onAppear(perform: { // called when text appears
                        _ = self.timer
                })
                }
            }
        }
        //makes a countdown string using a start and end date
        func countdownString(from date: Date) -> String {
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate, to: date)
            let resultString: String = ("\(components.hour ?? 0 + (24 * (components.day ?? 0))) : \(components.minute ?? 0) : \(components.second ?? 0)")
            //makes a result start with proper formatting, adding days * 24 in hours to account for days in hours, Format: Hours : Minutes : Seconds
            if(components.second ?? 0 < 0 || components.minute ?? 0 < 0 || components.hour ?? 0 < 0 || components.day ?? 0 < 0 ){ //if going negative / done
                return "0 : 0 : 0"
            }
            return resultString
        }
    }

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
