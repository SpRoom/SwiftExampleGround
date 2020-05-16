//
//  Encoder.swift
//  ProperyWrapper
//
//  Created by xj on 2020/5/16.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import Foundation

private protocol EncodableFlag {
    typealias Container = KeyedEncodingContainer<FlagCodingKey>
    func encodeValue(from container: inout Container) throws
}

extension Flag: EncodableFlag where Value: Encodable {
    
     fileprivate func encodeValue(from container: inout Container) throws {
        
        let key = FlagCodingKey(name: name)
        
        try container.encode(wrappedValue, forKey: key)
    }
}


extension FeatureFlags: Codable {}
extension FeatureFlags: CadableModel {
    init(from decoder: Decoder) throws {
        try deco(decoder: decoder)
    }
}
extension CadableModel where Self: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: FlagCodingKey.self)

        for child in Mirror(reflecting: self).children {

            guard let flag = child.value as? EncodableFlag else {
                continue
            }
            try flag.encodeValue(from: &container)
        }
    }
}
