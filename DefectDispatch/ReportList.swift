//
//  DefectList.swift
//  DefectDispatch
//
//  Created by Jed Verry on 6/20/22.
//

import Foundation
import UIKit
import SwiftUI


struct ReportList: View {
    @EnvironmentObject var manager: ReportManager
    var body: some View {
        VStack {
            Text("Defect Dispatch")
                .bold()
                .modifier(DefectDispatchText())
            List {
                ForEach(manager.reports) {
                    reports in
                    VStack (alignment: .leading) {
                        Text(reports.name)
                            .font(.largeTitle)
                        Text(reports.description)
                            .font(.caption)
                    }
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
