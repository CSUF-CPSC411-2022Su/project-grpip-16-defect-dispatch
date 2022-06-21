import SwiftUI

struct SecondView: View {
    @State var total_mileage = ""
    @State var arriving_time = ""
    @State var temp = ""
    //@ObservedObject var helper = calculate_ideal_speed()

    var body: some View {
        Text("Hello, Second View!")
            .font(.largeTitle)
            .fontWeight(.medium)
            .foregroundColor(Color.blue)
        Form{
            Section {
                TextField("total mileage(mile)",text:$total_mileage)
                TextField("time left(minute)",text:$arriving_time)
            }
            VStack {
                Button(action:{calculate()
                }, label: {
                    Text("begin calculate")
                })
            }


            Text("Min average speed:\(self.temp) mph")

        }



    }
    func calculate() {
        temp = String((Double(total_mileage) ?? 0)/(Double(arriving_time) ?? 0))
    }

}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}


