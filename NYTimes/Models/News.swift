//
//  News.swift
//  NYTimes
//
//  Created by Ashley Park on 5/10/20.
//  Copyright © 2020 Ashley Park. All rights reserved.
//

import UIKit

struct Media: Codable {
    //image url
    var url: String
}

struct headlineObject: Codable {
    //headline title
    var main: String
}

struct News: Codable {
    var web_url: String
    var snippet: String
    var multimedia: [Media]
    var headline: headlineObject
    var pub_date: String
}

struct responseObject: Codable {
    var docs: [News]
}

struct NewsSearchResponse: Codable {
    var response: responseObject
}

