import SwiftUI;

struct ReportingInterface : View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // TODO: Add icons next to text
            Button(action: {}) {
                Text("Add Photo")
            }
            Button(action: {}) {
                Text("Add Location")
            }
            Button(action: {}) {
                Text("Estimate Severity")
            }
        }
    }
}

struct ReportingInterfaceUI_Previewa: PreviewProvider {
    static var previews: some View {
        ReportingInterface()
    }
}
