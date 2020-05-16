//
//  Normal.swift
//  ProperyWrapper
//
//  Created by xj on 2020/5/16.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Capitalized {
    public var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }

    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

struct User {
    @Capitalized var firstName: String
    @Capitalized var lastName: String
}


struct Document {
    @Capitalized var name = "Untitled document"
}
