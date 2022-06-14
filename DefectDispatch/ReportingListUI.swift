//
//  ReportingListUI.swift
//  DefectDispatch
//
//  Created by csuftitan on 6/13/22.
//

import SwiftUI

struct Report: Identifiable {
    var id = UUID()
    let title: String
}

class ReportsViewModel: ObservableObject {
    @Published var reports: [Report] = [
        Report(title: "Stop Sign"),
        Report(title: "Pothole"),
        Report(title: "Graffiti")
    ]
}

struct ReportingListUI: View {
    @StateObject var viewModel = ReportsViewModel()
    @State var text = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Section(header: Text("Add New Report")) {
                    TextField("Type Report Here", text: $text).padding()
                    Button(action: {
                        self.addToList()
                    }, label: {
                        Text("Add").frame(width: 250, height: 50, alignment: .center).background(Color.blue).cornerRadius(8).foregroundColor(Color.white)
                    })
                }
                
                List {
                    ForEach(viewModel.reports) { report in ReportRow(title: report.title)}
                }
            }.navigationTitle("Reports")
        }
    }
    
    func addToList() {
        // Makes sure that the textbox is not empty
        guard !text.isEmpty else {
            return
        }
        
        let newReport = Report(title: text)
        viewModel.reports.append(newReport)
        text = ""
    }
}

struct ReportRow: View {
    let title: String
    
    var body: some View {
        Label(
            title: { Text(title) },
            icon : { Image("") })
    }
}

struct ReportingListUI_Previews: PreviewProvider {
    static var previews: some View {
        ReportingListUI()
    }
}
