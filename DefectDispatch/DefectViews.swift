//
//  DefectViews.swift
//  DefectDispatch
//
//  Created by Jed Verry on 6/20/22.
//

import SwiftUI

struct DefectsList: View {
    @EnvironmentObject var manager: DefectsManager
    var body: some View {
        VStack {
            Text("Defect Dispatch")
                .bold()
                .modifier(DefectDispatchText())
            List {
                ForEach(manager.defects) {
                    defects in
                    VStack (alignment: .leading) {
                        Text(defects.name)
                            .font(.largeTitle)
                        Text(defects.description)
                            .font(.caption)
                    }
                }
                .onDelete {
                    offset in
                    manager.defects.remove(atOffsets: offset)
                }
                .onMove {
                    offset, index in
                    manager.defects.move(fromOffsets: offset,
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



struct AddDefects: View {
    @SceneStorage("defectwalkName") var defectName: String = ""
    @SceneStorage("defectAddress") var defectAddress: String = ""
    @EnvironmentObject var manager: DefectsManager
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                Text("New Defect")
                    .bold()
                    .font(.largeTitle)
                }
                .padding(.bottom, 30)
                
                HStack{
                Text("Add a picture")
                        .bold()
                }
                .padding(.bottom, 20)
                Spacer()

                HStack {
                    Text("Defect Name")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                HStack {
                    TextField("Defect name", text: $defectName)
                        .modifier(TextEntry())
                    Spacer()
                }
                .padding(.bottom, 20)
                HStack {
                    Text("Defect address")
                        .bold()
                    Spacer()
                }
                .padding(.bottom, 5)
                TextEditor(text: $defectAddress)
                    .modifier(TextEntry())
                    .padding(.bottom, 30)
                Button(action: {
                    manager.defects.append(Defects(name: defectName, description: defectAddress))
                    defectName = ""
                    defectAddress = ""
                }) {
                    Text("Submit")
                        .modifier(ButtonDesign())
                }
                Spacer()
            }
            .padding()
        }
    }
}
