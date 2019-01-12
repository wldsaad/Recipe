//
//  Constants.swift
//  Recipe
//
//  Created by Waleed Saad on 1/12/19.
//  Copyright © 2019 Waleed Saad. All rights reserved.
//

import Foundation

class Constants {
    private let APP_ID = "3811f84b"
    private let APP_KEY = "09464942707ba0c1c3770f7067ea5c6b"
    
    func getBaseURL(withSearchText searchText: String) -> URL {
        let search = searchText.replacingOccurrences(of: " ", with: "%20")
        let baseURL = "https://api.edamam.com/search?q=\(search)&app_id=\(APP_ID)&app_key=\(APP_KEY)"
        let url = URL(string: baseURL)
        return url!
    }
}
