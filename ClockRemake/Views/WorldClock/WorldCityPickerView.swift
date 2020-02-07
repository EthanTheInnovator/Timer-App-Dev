//
//  WorldCityPickerView.swift
//  ClockRemake
//
//  Created by Ibrahim Syed on 2/7/20.
//  Copyright © 2020 🅱️ Productions. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}

struct WorldCityPickerView: View {
    
    let array: [String] = TimeZone.knownTimeZoneIdentifiers
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        NavigationView {
            VStack {
                // Search View
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $searchText, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("on Commit")
                        }).foregroundColor(.primary)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true)
                            self.searchText = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton)
                
                List {
                    ForEach(array.filter{searchText == "" || $0.contains(searchText)}, id:\.self) {
                        searchText in
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text(searchText)
                        }
                    }
                }
                .navigationBarTitle(Text("Search"))
                .resignKeyboardOnDragGesture()
            }
        }
    }
}

struct WorldCityPickerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorldCityPickerView()
                .environment(\.colorScheme, .light)
            WorldCityPickerView()
                .environment(\.colorScheme, .dark)
        }
    }
}
