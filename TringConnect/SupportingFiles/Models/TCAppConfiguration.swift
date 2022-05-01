//
//  TCAppConfiguration.swift
//  TringConnect
//
//  Created by Ponkumar's Mac on 01/05/22.
//

import Foundation

struct TCAppConfiguration: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case homeUrl 
    }
    
    let homeUrl: String
    
}

class TCAppConfigurationManager {
    
    static let shared = TCAppConfigurationManager()
    
    private var appConfig: TCAppConfiguration!
    private let pListAppConfig = "App"

    
    private init() {
        getAppConfigPListInfo()
    }

    private func getAppConfigPListInfo() {
        let parseResult = NBCParserUtility.getInfoDictFromPlist(pListAppConfig, TCAppConfiguration.self)
        switch parseResult {
        case .success(let config):
            appConfig = config
        case .failure(let error):
            debugPrint(error)
        }
    }
    
    var homeUrl: String {
        appConfig.homeUrl 
    }
}
