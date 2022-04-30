//
//  TCNetworkService.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 30/04/22.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURLRequest
    case parsingError
    case noData
}

class TCNetworkService {
    
    static func getData<T>(_ url: String, _ modelType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        
        AF.request(url).response { (data) in
            switch data.result {
            case .success(let data):
                completion(TCNetworkService.getParsedData(modelType, data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getParsedData<T>(_ modelType: T.Type, _ data: Data?) -> Result<T, Error> where T: Decodable {
        guard let receivedData = data else {
            return .failure(NetworkError.noData)
        }
        
        let jsonDecoder = JSONDecoder()
        do {
            let data = try jsonDecoder.decode(modelType, from: receivedData)
            return .success(data)
        } catch let exception {
            return .failure(exception)
        }
    }
}
