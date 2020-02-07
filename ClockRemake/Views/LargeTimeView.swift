//
//  LargeTimeView.swift
//  ClockRemake
//
//  Created by Ethan Humphrey on 2/7/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

import SwiftUI

struct LargeTimeView: View {
    
    @State var time: Date!
    @State var timeZone: TimeZone!
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text(getCurrentTimeFormatted())
                .fontWeight(.light)
                .font(.system(size: 50))
            Text(getCurrentAMSymbol())
                .font(.system(size: 25))
        }
    }
    
    func getCurrentTimeFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "h:mm"
        return dateFormatter.string(from: time)
    }
    
    func getCurrentAMSymbol() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: time)
    }
}

struct LargeTimeView_Previews: PreviewProvider {
    static var previews: some View {
        LargeTimeView()
    }
}
