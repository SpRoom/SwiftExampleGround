//
//  UserDefaults.swift
//  ProperyWrapper
//
//  Created by xj on 2020/5/16.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "group.johnsundell.app")
        return combined
    }
}

@propertyWrapper struct UserDefaultsBacked<Value> {
    let key: String
    let defaultValue: Value
    var storage: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            let value = storage.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                storage.setValue(newValue, forKey: key)
            }
        }
    }
}

private protocol AnyOptional {
    var isNil: Bool { get }
}

extension Optional: AnyOptional {
    var isNil: Bool { self == nil }
}

struct SettingsViewModel {
    @UserDefaultsBacked(key: "mark-as-read", defaultValue: true)
    var autoMarkMessagesAsRead: Bool

    @UserDefaultsBacked(key: "search-page-size", defaultValue: 20)
    var numberOfSearchResultsPerPage: Int
    
    @UserDefaultsBacked(key: "signature")
    var messageSignature: String?
}

extension UserDefaultsBacked where Value: ExpressibleByNilLiteral {
    init(key: String, storage: UserDefaults = .standard) {
        self.init(key: key, defaultValue: nil, storage: storage)
    }
}
