//
//  Report.swift
//  DefectDispatch
//
//  Created by csuftitan on 6/13/22.
//

import Foundation
import CoreLocation
import SwiftUI

enum ReportType: String, CaseIterable, Identifiable {
    static var allCases: [ReportType] {
        return [.pothole, .suggestion, .brokenLight]
    }
    case pothole = "Pothole"
    case suggestion = "Suggestion"
    case brokenLight = "Broken Streetlight"
    case undefined = "Select Report type"
    var id: Self { self }
}

enum Severity: String, CaseIterable, Identifiable {
    static var allCases: [Severity] {
        return [.high, .medium, .low]
    }
    case high = "High";
    case medium = "Medium";
    case low = "Low";
    case unknown = "Estimate Severity";
    var id: Self { self }
}

class Report: ObservableObject, Identifiable {
    var id: UUID = UUID()
    @Published var name: String
    @Published var address: String
    var date: Date
    @Published var type: ReportType;
    @Published var severity: Severity
    @Published var description: String
    var location: CLLocationCoordinate2D?
    var photo: Image?
    var valid: Bool {
        return severity != .unknown && type != .undefined && name != "" && address != ""
    }
    
    init() {
        date = Date.now
        type = ReportType.undefined
        severity = Severity.unknown
        description = ""
        name = ""
        address = ""
    }
    
    func printType()
    {
        print(type.rawValue)
    }
}
