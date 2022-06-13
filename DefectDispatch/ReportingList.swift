//
//  ReportingList.swift
//  DefectDispatch
//
//  Created by csuftitan on 6/12/22.
//

import SwiftUI

struct ReportingList: View {
    var accidentToReport: [Report]
    var body: some View {
        NavigationView {
            List(accidentToReport) {
                report in ListView(newReport: report)
            }.navigationBarTitle(Text("Defect Reports"))
        }
    }
}

var reportList = [
    Report(id: 1, name: "Stop Sign"),
    Report(id: 2, name: "Graffiti"),
    Report(id: 3, name: "Pothole")
]

struct Report: Identifiable {
    var id: Int
    var name: String
}

struct ListView: View {
    var newReport: Report
    var body: some View {
        HStack {
            Text(newReport.name)
        }
    }
}

struct ReportingList_Previews: PreviewProvider {
    static var previews: some View {
        ReportingList(accidentToReport: reportList)
    }
}
