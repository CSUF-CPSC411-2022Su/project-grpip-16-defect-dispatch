//
//  Speed.swift
//  DefectDispatch
//
//  Created by Qice Sun on 6/12/22.
//

import Foundation

class Speed {
  var total_mileage: Double
  var arriving_time: Double
    
  init(total_mileage: Double, at arriving_time: Double) {
    self.total_mileage = total_mileage
    self.arriving_time = arriving_time
  }

  func calculate_ideal_speed() -> Double{
      return 0 //need to be done
  }
}
