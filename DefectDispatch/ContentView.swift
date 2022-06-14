//
//  ContentView.swift
//  DefectDispatch
//
//  Created by csuftitan on 6/8/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    var body: some View {
            VStack {
                VStack {
                    Text("Share a Picture")
                        .padding()
                VStack{
                    Button(action: {
                        print("Opens Library")
                    }) {
                        Text("Open Library")
                    }.padding()
                Button(action: {
                        print("Opens Camera")
                    }) {
                        Text("Open Camera")
                }.padding()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

