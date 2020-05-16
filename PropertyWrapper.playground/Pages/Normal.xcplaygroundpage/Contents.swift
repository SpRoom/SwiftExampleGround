//: [Previous](@previous)

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
//: [Next](@next)

var user = User(firstName: "john", lastName: "appleseed")

user.lastName = "sundell"

struct Document {
    @Capitalized var name = "Untitled document"
}

let doc = Document()

