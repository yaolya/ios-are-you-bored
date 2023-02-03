//
//  Model.swift
//  ios-are-you-bored
//
//  Created by Оля Галягина on 02.02.2023.
//

import Foundation
import UIKit

class Storage {
    
    private var activities: [String] = []
    
    func saveActivity(_ activity: String) {
        activities.append(activity)
    }
    
    func resetActivities() {
        activities = []
    }
    
    func getRandomActivity() -> String {
        if checkActivities() {
            let randomNumber = Int.random(in: 0..<activities.count)
            return activities[randomNumber]
        } else {
            return "no activities selected"
        }
    }
    
    func checkActivities() -> Bool {
        return activities.count != 0 ? true : false
    }
    
}
