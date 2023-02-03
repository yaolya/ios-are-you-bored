//
//  APIClient.swift
//  ios-are-you-bored
//
//  Created by Оля Галягина on 02.02.2023.
//

import Foundation

class APIClient {
    
    static let shared: APIClient = APIClient()
    
    func getActivityURL() -> String {
        return "https://www.boredapi.com/api/activity/"
    }
    
}
