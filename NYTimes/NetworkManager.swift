//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Ashley Park on 5/14/20.
//  Copyright © 2020 Ashley Park. All rights reserved.
//

import Foundation
import Alamofire

enum ExampleDataResponse<T: Any> {
    case success(data: T)
    case failure(error: Error)
}

class NetworkManager {
    private static let nytimesURL = "https://api.nytimes.com/svc/search/v2/articlesearch.json"
    private static let apiKey = "OawnDa3dF4IuevIJ6JUVkvJPlA54a828"
    
    static func getNews(fromKeyword keywords: [String], _
        didGetNews: @escaping ([News]) -> Void) {
        let keywordStr = keywords.joined(separator: "+")
        let parameter: [String: Any] = ["q": keywordStr, "api-key": apiKey]
        
        AF.request(nytimesURL, method: .get, parameters: parameter).validate().responseData{ (response) in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                
                print("here")
                if let newsData = try?
                    decoder.decode(NewsSearchResponse.self, from: data) {
                    print("after decode")
                    didGetNews(newsData.response.docs)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    static func fetchImage(imageURL: String, completion: @escaping ((UIImage) -> Void)) {
        let complete_url = "https://www.nytimes.com/\(imageURL)"
        AF.request(complete_url, method: .get).validate().responseData { (response) in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(image)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
