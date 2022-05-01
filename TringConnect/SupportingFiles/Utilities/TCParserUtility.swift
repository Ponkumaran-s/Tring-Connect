//
//  TCParserUtility.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import Foundation

struct NBCParserUtility {
    
    private static let kTypePlist = "plist"
    
    enum ParserError: Error {
        case fileNotFound
        case parsingError
    }
    
    static func getInfoDictFromPlist<T>(_ name: String, _ : T.Type) -> Result<T, Error> where T: Decodable {
        guard let commonConfigPath = Bundle.main.path(forResource: name, ofType: kTypePlist) else {
            return .failure(ParserError.fileNotFound)
        }
        
        let url = URL(fileURLWithPath: commonConfigPath)
        
        do {
            let data = try Data(contentsOf: url, options: .alwaysMapped)
            let decoder = PropertyListDecoder()
            let decodedPlistInfo = try decoder.decode(T.self, from: data)
            
            return .success(decodedPlistInfo)
        } catch _ {
            return .failure(ParserError.parsingError)
        }
    }
}
