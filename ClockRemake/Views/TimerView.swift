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
        @State private var showAlert = false //if alert is being shown
        @State private var userInput: String = "" //gets users input
        let refDate: Date = Date(timeIntervalSinceNow: 10)
        let alert: Alert = Alert(title: Text("Timer Over"), message: Text(""), dismissButton: .default(Text("OK")))
        var timer: Timer {
           Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
                self.currentDate = Date()
            }
        }
        var body: some View {
            VStack { //Just tells user to input time
                Text("Input timer time (in seconds) below")
                VStack { // Gets time from user
                    TextField("Put time here", text: $userInput)
                        .keyboardType(.numberPad)
                    VStack { //updates text on screen using given timer invervals
                        Text(countdownString(from: refDate))
                        .font(.title) //sets the font to a "title" font
                        .alert(isPresented: $showAlert, content: { self.alert }) //calls alert if at 0
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
            if(resultString == "00 : 00 : 00" && showAlert == false){ //creates an alert at 0
                self.showAlert.toggle()
            }
            //makes a result start with proper formatting, adding days * 24 in hours to account for days in hours, Format: Hours : Minutes : Seconds
            return resultString
        }
    }

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
