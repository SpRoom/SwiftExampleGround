//
//  Decoder.swift
//  ProperyWrapper
//
//  Created by xj on 2020/5/16.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import Foundation

@propertyWrapper final class Flag<Value> {
    let name: String
    var wrappedValue: Value
    var projectedValue: Flag { self }

    fileprivate init(name: String, defaultValue: Value) {
        self.name = name
        self.wrappedValue = defaultValue
    }
}

struct FlagCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?

    init(name: String) {
        stringValue = name
    }
    
    // These initializers are required by the CodingKey protocol:

    init?(stringValue: String) {
        self.stringValue = stringValue
    }

    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
}

private protocol DecodableFlag {
    typealias Container = KeyedDecodingContainer<FlagCodingKey>
    func decodeValue(from container: Container) throws
}

extension Flag: DecodableFlag where Value: Decodable {
    fileprivate func decodeValue(from container: Container) throws {
        // This enables us to pass an override using a command line
        // argument matching the flag's name:
        if let value = UserDefaults.standard.value(forKey: name) {
            if let matchingValue = value as? Value {
                wrappedValue = matchingValue
                return
            }
        }

        let key = FlagCodingKey(name: name)

        // We only want to attempt to decode a value if it's present,
        // to enable our app to fall back to its default value
        // in case the flag is missing from our backend data:
        if let value = try container.decodeIfPresent(Value.self, forKey: key) {
            wrappedValue = value
        }
    }
}

extension FeatureFlags: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: FlagCodingKey.self)

        for child in Mirror(reflecting: self).children {
            guard let flag = child.value as? DecodableFlag else {
                continue
            }

            try flag.decodeValue(from: container)
        }
    }
}


struct FeatureFlags {
    @Flag(name: "feature-search", defaultValue: false)
    var isSearchEnabled: Bool

    @Flag(name: "experiment-note-limit", defaultValue: 999)
    var maximumNumberOfNotes: Int
    
    init(enabled: Bool, num: Int) {
        isSearchEnabled = enabled
        maximumNumberOfNotes = num
    }
}
