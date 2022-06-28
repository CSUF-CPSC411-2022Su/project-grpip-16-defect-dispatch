//
//  DefectList.swift
//  DefectDispatch
//
//  Created by Stefan Parrish
//

import Foundation
import UIKit
import SwiftUI


struct ReportList: View {
    @EnvironmentObject var manager: ReportManager
    @AppStorage("darkMode") var darkMode = 1;
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Defect Dispatch")
                    .bold()
                    .modifier(DefectDispatchText())
                Button(action: {
                    darkMode = (darkMode-1)*(-1)
                }, label: {
                    Text("💡")
                })
            }
            NavigationView {
                List {
                    ForEach(manager.reports) { reports in
                        NavigationLink(destination: ReportView(description: reports.description, title: reports.name, address: reports.address)) {
                            VStack (alignment: .leading) {
                                Text(reports.name)
                                    .font(.largeTitle)
                                Text(reports.description)
                                    .font(.caption)
                            }
                        }.modifier(listModifier())
                    }
                    .onDelete {
                        offset in
                        manager.reports.remove(atOffsets: offset)
                        ReportManager.save(manager)
                    }
                    .onMove {
                        offset, index in
                        manager.reports.move(fromOffsets: offset,
                                                toOffset: index)
                        ReportManager.save(manager)
                    }
                }.modifier(darkModeReport())
            }
        } .modifier(darkModeReport())
    }
}

struct ReportView: View {
    @State var description = "";
    @State var title = "";
    @State var address = "";
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    Text(title)
                        .font(.largeTitle)
                    Image("StopStreet")
                                .resizable()
                                .scaledToFit()
                                .frame(width:250, height: 250)
                }
                .frame(width: geometry.size.width, height:geometry.size.height/2)
                VStack {
                    Text(description)
                        .font(.title2)
                    Text("Located at: \(address)")
                        .font(.subheadline)
                        .padding()
                }
                .frame(width: geometry.size.width, height:geometry.size.height/2)
            }.modifier(darkModeReport())
        }
    }
}

struct DefectDispatchText: ViewModifier {
    @AppStorage("darkMode") var darkMode = 1;
   func body(content: Content) -> some View {
       if(darkMode == 1) {
            content
               .font(.custom("Courier New", size: 20))
               .foregroundColor(Color.white)
               .padding()
               .background(Color.black)
       } else {
           content
              .font(.custom("Courier New", size: 20))
              .foregroundColor(Color.black)
              .padding()
              .background(Color.white)
       }
    }
}

struct darkModeReport: ViewModifier {
    @AppStorage("darkMode") var darkMode = 1;
    func body(content: Content) -> some View {
        if(darkMode == 1) {
            content
                .background(Color.black)
                .foregroundColor(Color.white)
        } else {
            content
                .background(Color.white)
                .foregroundColor(Color.black)
        }
    }
}

struct listModifier: ViewModifier {
    @AppStorage("darkMode") var darkMode = 1;
    func body(content: Content) -> some View {
        if(darkMode == 1) {
            content
                .listRowBackground(Color("DarkGray"))
                .foregroundColor(Color.white)
        } else {
            content
                .listRowBackground(Color.white)
                .foregroundColor(Color.black)
        }
    }
}


class ReportManager: ObservableObject, Codable {
    @Published var reports: [Report] = []
    
    init() {
        
    }
    enum CodingKeys: CodingKey {
        case reports
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        reports = try container.decode([Report].self, forKey: .reports)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(reports, forKey: .reports)
    }
    static func load() -> ReportManager
    {
        let documentsDirectory =
           FileManager.default.urls(for: .documentDirectory,
           in: .userDomainMask).first!
        let archiveURL =
           documentsDirectory.appendingPathComponent("manager")
           .appendingPathExtension("plist")
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedManager = try? Data(contentsOf: archiveURL),
            let decodedManager = try?
            propertyListDecoder.decode(ReportManager.self,
           from: retrievedManager) {
            return decodedManager
        } else {
            return ReportManager()
        }
    }
    static func save(_ manager: ReportManager)
    {
        let documentsDirectory =
           FileManager.default.urls(for: .documentDirectory,
           in: .userDomainMask).first!
        let archiveURL =
           documentsDirectory.appendingPathComponent("manager")
           .appendingPathExtension("plist")
        let propertyListEncoder = PropertyListEncoder()
        if let encodedManager = try? propertyListEncoder.encode(manager) {
           try? encodedManager.write(to: archiveURL,
           options: .noFileProtection)
            print("Saved")
        }
    }
}
