
import SwiftUI

struct ContentView : View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Main Content View")
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(Color.blue)
                Spacer()
                Text("This is function is to help you determine which tranportation you should take based on time left and trip length.")

                Spacer()
                NavigationLink(destination: SecondView()) {
                    Text("Welcome")
                    .frame(minWidth: 0, maxWidth: 300)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .font(.title)
            }.buttonStyle(ThemeAnimationStyle())
          }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
