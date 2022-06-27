//
//  ReportConfirmationPage.swift
//  DefectDispatch
//
//  Created by csuftitan on 6/25/22.
//

import SwiftUI

struct PreviewReport: View {
    var body: some View {
        VStack
        {
            ViewReport()
        }
    }
}

struct ViewReport: View {
    @EnvironmentObject var report: Report
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Report Type:")
                    Spacer()
                    Text(report.type.rawValue)
                }.foregroundColor(.white)
                    .modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))

                
                if let photo = report.photo
                {
                    HStack {
                        Image(systemName: "camera.aperture")
                        Text("TODO: Add photo view")
                    }.modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))

                }
                if let location = report.location {
                    HStack {
                        Image(systemName: "location.north.circle")
                        Text("TODO: Add location view")
                    }.modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))

                }

                VStack(alignment: .leading)
                {
                    Text("Severity:")
                    HStack {
                        Image(systemName: "exclamationmark.circle")
                        Text("Severity: " + report.severity.rawValue.capitalized)
                    }
                    .modifier(SeverityButton(severity: $report.severity))
                }
                if report.description != "" {
                    Text("Description:")
                    HStack
                    {
                        Text(report.description)
                        Spacer()
                    }
                        .padding()
                        .border(.gray, width: 2.0)
                }
                
            }.padding()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}
