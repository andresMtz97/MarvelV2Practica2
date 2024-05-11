//
//  StringExtension.swift
//  MarvelV2
//
//  Created by DISMOV on 09/05/24.
//

import Foundation
import CryptoKit

extension String{
    
    var md5 : String {
        let hashedData = Insecure.MD5.hash(data: Data(self.utf8))
        let md5String = hashedData.map { String(format: "%02hhx", $0) }.joined()
        return md5String
    }
}
