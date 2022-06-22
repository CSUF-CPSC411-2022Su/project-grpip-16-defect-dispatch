//
//  DefectList.swift
//  DefectDispatch
//
//  Created by Jed Verry on 6/20/22.
//

import Foundation
import UIKit
import SwiftUI

class DefectsManager: ObservableObject {
    @Published var defects: [Defects] = []
    
    init() {
        
    }
}


struct Defects: Identifiable {
    /// The Identifiable protocol requires an id property that should be a unique value
    /// UUID generates a unique random hexadecimal string
    var id = UUID()
    var name: String
    var description: String
}
