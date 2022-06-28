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
    let description: String
}

class ReportsViewModel: ObservableObject {
    @Published var reports: [Report] = []
}

struct ReportingListUI: View {
    @StateObject var viewModel = ReportsViewModel()
    @State var text = ""
    @State var textDesc = ""

    var body: some View {
        NavigationView {
            VStack {
                Section(header: Text("Add New Report")) {
                    TextField("Type Report Here", text: $text).padding()
                    TextField("Type Desc Here", text: $textDesc).padding()
                    Button(action: {
                        self.addToList()
                    }, label: {
                        Text("Add").frame(width: 250, height: 50, alignment: .center).background(Color.blue).cornerRadius(8).foregroundColor(Color.white)
                    })
                }
                Button(action: {print("hi")}, label: {Text("💡")})
                List {
                    ForEach(viewModel.reports) { report in
                        if let description = report.description {
                            NavigationLink(destination: ReportView(description: description, title: report.title)) {
                                VStack {
                                Text(report.title)
                                        .font(.largeTitle)
                                Text(report.description)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("Reports")
        }
    }

    func addToList() {
        // Makes sure that the textbox is not empty
        guard !text.isEmpty else {
            return
        }

        let newReport = Report(title: text, description: textDesc)
        viewModel.reports.append(newReport)
        text = ""
        textDesc = ""
    }
}

struct ReportView: View {
    @State var description = "";
    @State var title = "";
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text(title)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Image("StopStreet")
                                .resizable()
                                .scaledToFit()
                }
                .frame(width: geometry.size.width, height:geometry.size.height/2)
                VStack {
                    Text(description)
                        .font(.title)
                        .foregroundColor(.white)
                }
                .frame(width: geometry.size.width, height:geometry.size.height/2)
            }.background(Color.black)
        }
    }
}

struct ReportRow: View {
    let title: String

    var body: some View {
        Label(
            title: { Text(title) },
            icon: { Image("") })
    }
}



struct ReportingListUI_Previews: PreviewProvider {
    static var previews: some View {
        ReportingListUI()
    }
}
