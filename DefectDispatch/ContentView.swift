//
//  ContentView.swift
//  DefectDispatch
//
//  Created by csuftitan on 6/8/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @StateObject var manager = ReportManager()
    var body: some View {
        TabView {
            ReportList()
                .tabItem {
                    Image(systemName: "car")
                    Text("Defects")
                }
            ReportingInterface()
                .tabItem{
                    Image(systemName: "plus")
                    Text("Add Defect")
                }

        }.environmentObject(manager)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

