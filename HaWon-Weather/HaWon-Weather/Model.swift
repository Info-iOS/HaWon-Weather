import Foundation

struct Weathers {
    var cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

struct City {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

struct Coord {
    let lat, lon: Double
}

struct List {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let sys: Sys
    let dtTxt: String
    let rain: Rain?
}

struct Clouds {
    let all: Int
}

struct MainClass {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double
}

struct Rain {
    let the3H: Double
}

struct Sys {
    let pod: Pod
}

struct Weather {
    let id: Int
    let main: MainEnum
    let description: Description
    let icon: String
}

struct Wind {
    let speed: Double
    let deg: Int
    let gust: Double
}
