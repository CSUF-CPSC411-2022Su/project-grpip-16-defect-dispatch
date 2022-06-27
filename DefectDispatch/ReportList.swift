//
//  DefectList.swift
//  DefectDispatch
//
//  Created by Jed Verry on 6/20/22.
//

import Foundation
import UIKit
import SwiftUI


struct ReportList: View {
    @EnvironmentObject var manager: ReportManager
    var body: some View {
        VStack {
            Text("Defect Dispatch")
                .bold()
                .modifier(DefectDispatchText())
            List {
                ForEach(manager.reports) {
                    reports in
                    VStack (alignment: .leading) {
                        Text(reports.name)
                            .font(.largeTitle)
                        Text(reports.description)
                            .font(.caption)
                    }
                }
                .onDelete {
                    offset in
                    manager.reports.remove(atOffsets: offset)
                }
                .onMove {
                    offset, index in
                    manager.reports.move(fromOffsets: offset,
                                            toOffset: index)
                }

            }
        }
    }
}

struct DefectDispatchText: ViewModifier {
   func body(content: Content) -> some View {
        content
           .font(.custom("Courier New", size: 20))
           .foregroundColor(Color.white)
           .padding()
           .background(Color.black)
           .cornerRadius(10)
    }
}


class ReportManager: ObservableObject {
    @Published var reports: [Report] = []
    
    init() {
        
    }
}
