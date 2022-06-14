//
//  Report.swift
//  DefectDispatch
//
//  Created by csuftitan on 6/13/22.
//

import Foundation
import CoreLocation

enum ReportType {
    case pothole, suggestion, brokenLight;
}

struct Report {
    var date: Date
    var type: ReportType;
    var severity: Int?
    var details: String?
    var location: CLLocationCoordinate2D?
}
