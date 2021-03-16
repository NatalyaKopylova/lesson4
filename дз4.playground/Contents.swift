import Foundation


//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

enum Action {
    case startEngine
    case stopEngine
    case openWindow
    case closeWindow
    case fillTrunk(cargoVolume: Double)
    case emptyTrunk(cargoVolume: Double)
    case raiseTheCab
    case lowerTheCab
    case raiseTheSpoiler
    case lowerTheSpoiler
}

class Car {
    let carBrand: String
    let yearOfRelease: Int
    let trunkVolume: Double
    var engineRunning: Bool
    var windowsIsOpen: Bool
    var filledTrunkVolume: Double
    
    init(carBrand: String, yearOfRelease: Int, trunkVolume: Double, engineRunning: Bool, windowsIsOpen: Bool, filledTrunkVolume: Double) {
        self.carBrand = carBrand
        self.yearOfRelease = yearOfRelease
        self.trunkVolume = trunkVolume
        self.engineRunning = true
        self.windowsIsOpen = true
        self.filledTrunkVolume = filledTrunkVolume
    }
        
    func makeAction(action: Action) {
        // метод не пустой (как в дз), потому что так меньше дублирования кода
        switch action {
        case .startEngine:
            engineRunning = true
            print("Двигатель запущен")
        case .stopEngine:
            engineRunning = false
            print("Двигатель заглушен")
        case .openWindow:
            windowsIsOpen = true
            print("Окна открыты")
        case .closeWindow:
            windowsIsOpen = false
            print("Окна закрыты")
        case .fillTrunk(let cargoVolume):
            if cargoVolume <= (trunkVolume - filledTrunkVolume) {
                filledTrunkVolume += cargoVolume
                print("Багажник загружен: \(filledTrunkVolume) л")
            } else {
                print("Объем багажника не позволяет поместить весь груз. Заполненный объем: \(trunkVolume - filledTrunkVolume)")
            }
        case .emptyTrunk(let cargoVolume):
            if cargoVolume <= filledTrunkVolume {
                print("Недостаточное количество груза в багажнике")
            } else {
                filledTrunkVolume -= cargoVolume
                print("Багажник разгружен")
            }
        default:
            print("Действие недоступно")
        }
    }
    
    func printInfo() {
        print("Марка авто: \(self.carBrand)")
        print("Год выпуска: \(self.yearOfRelease)")
        print("Объем багажника: \(self.trunkVolume)")
        print("Состояние двигателя: \(self.engineRunning ? "Запущен" : "Заглушен")")
        print("Положение окон: \(self.windowsIsOpen ? "Открыты" : "Закрыты")")
        print("Загрузка багажника: \(self.trunkVolume)")
    }
}

class TrunkCar: Car {
    let axesCount: Int
    let bodyType: BodyType
    
    enum BodyType {
        case mixer
        case garbageTruck
        case trunk
    }
    
    init(carBrand: String, yearOfRelease: Int, trunkVolume: Double, engineRunning: Bool, windowsIsOpen: Bool, filledTrunkVolume: Double, axesCount: Int, bodyType: BodyType) {
        self.axesCount = axesCount
        self.bodyType = bodyType
        super.init(carBrand: carBrand,
                   yearOfRelease: yearOfRelease,
                   trunkVolume: trunkVolume,
                   engineRunning: engineRunning,
                   windowsIsOpen: windowsIsOpen,
                   filledTrunkVolume: filledTrunkVolume)
    }
    
    override func makeAction(action: Action) {
        switch action {
        case .raiseTheCab:
                print("Кабина поднята")
        case .lowerTheCab:
                print("Кабина опущена")
        default:
            super.makeAction(action: action)
        }
    }
}

var ford = TrunkCar(carBrand: "ford",
                    yearOfRelease: 2020,
                    trunkVolume: 3000,
                    engineRunning: true,
                    windowsIsOpen: true,
                    filledTrunkVolume: 0,
                    axesCount: 4,
                    bodyType: .trunk)

print("Грузовой автомобиль")
ford.printInfo()
ford.makeAction(action: .raiseTheSpoiler)
ford.makeAction(action: .raiseTheCab)
ford.makeAction(action: .lowerTheCab)

var volvo = TrunkCar(carBrand: "volvo",
                     yearOfRelease: 2021,
                     trunkVolume: 1200,
                     engineRunning: false,
                     windowsIsOpen: false,
                     filledTrunkVolume: 0,
                     axesCount: 3,
                     bodyType: .mixer)

print("______________________")
print("Грузовой автомобиль")
volvo.printInfo()
volvo.makeAction(action: .startEngine)
volvo.makeAction(action: .raiseTheCab)
volvo.makeAction(action: .lowerTheCab)

var iveco = TrunkCar(carBrand: "iveco",
                     yearOfRelease: 2019,
                     trunkVolume: 1300,
                     engineRunning: true,
                     windowsIsOpen: false,
                     filledTrunkVolume: 0,
                     axesCount: 2,
                     bodyType: .garbageTruck)

print("______________________")
print("Грузовой автомобиль")
iveco.printInfo()
iveco.makeAction(action: .stopEngine)
iveco.makeAction(action: .raiseTheCab)
iveco.makeAction(action: .lowerTheCab)

class SportCar: Car {
    let maxSpeed: Double
    let engineType: EngineType
    
    enum EngineType {
        case internalCombustion
        case electro
        case hybride
    }
    
    init(carBrand: String, yearOfRelease: Int, trunkVolume: Double, engineRunning: Bool, windowsIsOpen: Bool, filledTrunkVolume: Double, maxSpeed: Double, engineType: EngineType) {
        self.maxSpeed = maxSpeed
        self.engineType = engineType
        super.init(carBrand: carBrand,
                   yearOfRelease: yearOfRelease,
                   trunkVolume: trunkVolume,
                   engineRunning: engineRunning,
                   windowsIsOpen: windowsIsOpen,
                   filledTrunkVolume: filledTrunkVolume)
    }
    
    override func makeAction(action: Action) {
        switch action {
        case .raiseTheSpoiler:
            print("Спойлер поднят")
        case .lowerTheSpoiler:
            print("Спойлер опущен")
        default:
            super.makeAction(action: action)
        }
    }
}
    
var reno = SportCar(carBrand: "reno",
                    yearOfRelease: 2020,
                    trunkVolume: 300,
                    engineRunning: true,
                    windowsIsOpen: true,
                    filledTrunkVolume: 100,
                    maxSpeed: 250,
                    engineType: .hybride)

print("______________________")
print("Легковой автомобиль")
reno.printInfo()
reno.makeAction(action: .raiseTheSpoiler)
reno.makeAction(action: .lowerTheSpoiler)

var mazda = SportCar(carBrand: "mazda",
                         yearOfRelease: 2021,
                         trunkVolume: 500,
                         engineRunning: false,
                         windowsIsOpen: false,
                         filledTrunkVolume: 0,
                         maxSpeed: 320,
                         engineType: .internalCombustion)

print("______________________")
print("Легковой автомобиль")
mazda.printInfo()
mazda.makeAction(action: .raiseTheSpoiler)
mazda.makeAction(action: .lowerTheSpoiler)
mazda.makeAction(action: .lowerTheCab)
var nissan = SportCar(carBrand: "nissan",
                          yearOfRelease: 2019,
                          trunkVolume: 400,
                          engineRunning: true,
                          windowsIsOpen: false,
                          filledTrunkVolume: 0,
                          maxSpeed: 300,
                          engineType: .electro)

print("______________________")
print("Легковой автомобиль")
mazda.printInfo()
mazda.makeAction(action: .raiseTheSpoiler)
mazda.makeAction(action: .lowerTheSpoiler)














