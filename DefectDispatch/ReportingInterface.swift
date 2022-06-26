import SwiftUI

struct ReportingInterface: View {
    @StateObject var report: Report = .init()
    @State private var showingConfirmationPage: Bool = false;
    @State private var showingErrorMessage: Bool = false;
    var body: some View {
        GeometryReader { _ in
            NavigationView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        NavigationLink(destination: ReportConfirmationPage().environmentObject(report), isActive: $showingConfirmationPage) {
                            EmptyView()
                        }
                            .navigationBarBackButtonHidden(true)
                        Spacer()
                        HStack {
                            Spacer()
                            Button("Submit", action: {
                                if report.severity != .unknown && report.type != .undefined
                                {
                                    showingConfirmationPage = true;
                                } else
                                {
                                    showingErrorMessage = true
                                }
                            }).alert("Error!", isPresented: $showingErrorMessage, actions: {}, message: {
                                Text("All reports must have a severity and a type!")
                            })
                            .modifier(RoundedButton(padding: 5, background: .green, cornerRadius: 40))
                        }
                    }
                    Menu {
                        Picker("Report Type", selection: $report.type, content: {
                            ForEach(ReportType.allCases) { reportType in
                                Text(reportType.rawValue)
                            }
                        })
                    } label: {
                        HStack
                        {
                            Text("Report Type:")
                            Spacer()
                            Text(report.type.rawValue)
                        }.foregroundColor(.white)
                            .modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))
                    }
                    HStack {
                        Image(systemName: "camera.aperture")
                        Text("Add Photo")
                    }
                    .modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))
                    HStack {
                        Image(systemName: "location.north.circle")
                        Text("Add Location")
                    }
                    .modifier(RoundedButton(padding: 5, background: .blue, cornerRadius: 40))
                    
                    Menu {
                        Picker("Severity Level", selection: $report.severity, content: {
                            ForEach(Severity.allCases) { severity in
                                Text(severity.rawValue.capitalized)
                            }
                        })
                    } label: {
                        HStack {
                            Image(systemName: "exclamationmark.circle")
                            Text(report.severity.rawValue.capitalized)
                        }
                        .modifier(SeverityButton(severity: $report.severity))
                    }
                    
                    TextEditor(text: $report.details)
                        .padding()
                        .border(.gray, width: 2.0)
                }.padding()
                .navigationTitle("")
                .navigationBarHidden(true)
            }
        }
    }
}

struct RoundedButton: ViewModifier {
    var padding: CGFloat;
    var background: Color;
    var cornerRadius: CGFloat;
    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background(background)
            .cornerRadius(cornerRadius)
            .foregroundColor(.white)
    }
}

struct ReportingInterfaceUI_Preview: PreviewProvider {
    static var previews: some View {
        ReportingInterface()
    }
}

struct SeverityButton: ViewModifier {
    @Binding var severity: Severity;
    func body(content: Content) -> some View {
        switch(severity)
        {
        case .high:
            content
                .modifier(RoundedButton(padding: 5, background: .red, cornerRadius: 40))
        case .medium:
            content
                .modifier(RoundedButton(padding: 5, background: .yellow, cornerRadius: 40))
                .foregroundColor(.black)
        case .low:
            content
                .modifier(RoundedButton(padding: 5, background: .green, cornerRadius: 40))
        default:
            content
                .modifier(RoundedButton(padding: 5, background: .gray, cornerRadius: 40))
        }
    }
}
