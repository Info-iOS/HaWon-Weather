import Foundation

public struct Weathers_DTO: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List_DTO]
    let city: City_DTO
    
    func toModel() -> Weathers {
        return .init(cod: cod, message: message, cnt: cnt, list: list.map { $0.toModel() }, city: city.toModel())
    }
}

struct City_DTO: Decodable {
    let id: Int
    let name: String
    let coord: Coord_DTO
    let country: String
    let population, timezone, sunrise, sunset: Int
    
    func toModel() -> City {
        return .init(id: id, name: name, coord: coord.toModel(), country: country, population: population, timezone: timezone, sunrise: sunrise, sunset: sunset)
    }
}

struct Coord_DTO: Decodable {
    let lat, lon: Double
    
    func toModel() -> Coord{
        return .init(lat: lat, lon: lon)
    }
}

struct List_DTO: Decodable {
    let dt: Int
    let main: MainClass_DTO
    let weather: [Weather_DTO]
    let clouds: Clouds_DTO
    let wind: Wind_DTO
    let visibility: Int
    let pop: Double
    let sys: Sys_DTO
    let dtTxt: String
    let rain: Rain_DTO?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
    
    func toModel() -> List {
        return .init(
            dt: dt, main: main.toModel(), weather: weather.map { $0.toModel() }, clouds: clouds.toModel(), wind: wind.toModel(), visibility: visibility, pop: pop, sys: sys.toModel(), dtTxt: dtTxt, rain: rain?.toModel())
    }
}


struct Clouds_DTO: Decodable {
    let all: Int
    
    func toModel() -> Clouds {
        return .init(all: all)
    }
}

struct MainClass_DTO: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
    func toModel() -> MainClass {
        return  .init(temp: temp, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, pressure: pressure, seaLevel: seaLevel, grndLevel: grndLevel, humidity: humidity, tempKf: tempKf)
    }
}

struct Rain_DTO: Decodable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
    
    func toModel() -> Rain {
        return .init(the3H: the3H)
    }
}

struct Sys_DTO: Decodable {
    let pod: Pod
    
    func toModel() -> Sys {
        return .init(pod: pod)
    }
}

enum Pod: String, Decodable {
    case d = "d"
    case n = "n"
}

struct Weather_DTO: Decodable {
    let id: Int
    let main: MainEnum
    let description: Description
    let icon: String
    
    func toModel() -> Weather {
        return .init(id: id, main: main, description: description, icon: icon)
    }
}

enum Description: String, Decodable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case moderateRain = "moderate rain"
    case overcastClouds = "overcast clouds"
    case scatteredclouds = "scattered clouds"
}

enum MainEnum: String, Decodable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    
}

struct Wind_DTO: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
    
    func toModel() -> Wind {
        return .init(speed: speed, deg: deg, gust: gust)
    }
}
