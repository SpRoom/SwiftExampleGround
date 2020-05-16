import UIKit

var str = "Hello, playground"

protocol TeslaFactoryProtocol {
    func produce() -> Tesla
}
struct Tesla {
    let type = "electric"
    let brand = "Tesla"
}

struct TeslaFactory: CarFactoryProtocol {
    typealias CarType = ElectricCar
    func produce() -> CarType {
        print("producing tesla car ...")
        return CarType(brand: "Tesla")
    }
}

protocol CarFactoryProtocol {
    associatedtype CarType
    func produce() -> CarType
}

struct ElectricCar {
    let brand: String
}

struct PetrolCar {
    let brand: String
}

struct BMWFactory: CarFactoryProtocol {
    typealias CarType = ElectricCar
    
    func produce() -> CarType {
        print("producing bmw electric car ...")
        return CarType(brand: "BMW")
    }
}

struct ToyotaFactory: CarFactoryProtocol {
    typealias CarType = PetrolCar
    
    func produce() -> CarType {
        print("producing toyota petrol car ...")
        return CarType(brand: "toyota")
    }
}


struct AnyCarFactory<CarType>: CarFactoryProtocol {
    private let _produce: () -> CarType
    
    init<Factory: CarFactoryProtocol>(_ carFactory: Factory) where Factory.CarType == CarType {
        _produce = carFactory.produce
    }
    
    func produce() -> CarType {
        return _produce()
    }
}

let facories = [AnyCarFactory(TeslaFactory()), AnyCarFactory(BMWFactory())]
facories.map { $0.produce() }

