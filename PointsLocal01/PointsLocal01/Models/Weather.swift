import UIKit

struct Weather:Decodable {
    let city:City?
    let currentConditions:CurrentConditions?
    let daily : Daily
    let hourly : Hourly
    
    private enum CodingKeys:String, CodingKey {
        case currentConditions, daily, hourly
        case city = "City"
    }
    
    static func downloadDailyWeather(feedUrl:String, completion: @escaping ([Day]) -> Void) {
        let urlString = feedUrl
        let url = URL(string: urlString)

        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(Weather.self, from: data)
                    
                    let daily = feed.daily
                    
                    var dailyConditions = [Day]()
                    dailyConditions.append(daily.zero)
                    dailyConditions.append(daily.one)
                    dailyConditions.append(daily.two)
                    dailyConditions.append(daily.three)
                    dailyConditions.append(daily.four)
                    dailyConditions.append(daily.five)
                    dailyConditions.append(daily.six)
                    dailyConditions.append(daily.seven)
                    dailyConditions.append(daily.eight)
                    dailyConditions.append(daily.nine)
                    
                    DispatchQueue.main.async {
                        completion(dailyConditions)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                }.resume()
        }
    }
    
    static func downloadHourlyWeather(feedUrl:String, completion: @escaping ([Hour]) -> Void) {
        let urlString = feedUrl
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(Weather.self, from: data)
                    
                    let hourly = feed.hourly
                    
                    var hourlyConditions = [Hour]()
                    hourlyConditions.append(hourly.zero)
                    hourlyConditions.append(hourly.one)
                    hourlyConditions.append(hourly.two)
                    hourlyConditions.append(hourly.three)
                    hourlyConditions.append(hourly.four)
                    hourlyConditions.append(hourly.five)
                    hourlyConditions.append(hourly.six)
                    hourlyConditions.append(hourly.seven)
                    hourlyConditions.append(hourly.eight)
                    hourlyConditions.append(hourly.nine)
                    hourlyConditions.append(hourly.ten)
                    hourlyConditions.append(hourly.eleven)
                    hourlyConditions.append(hourly.twelve)
                    hourlyConditions.append(hourly.thirteen)
                    hourlyConditions.append(hourly.fourteen)
                    hourlyConditions.append(hourly.fifteen)
                    hourlyConditions.append(hourly.sixteen)
                    hourlyConditions.append(hourly.seventeen)
                    hourlyConditions.append(hourly.eighteen)
                    hourlyConditions.append(hourly.nineteen)
                    hourlyConditions.append(hourly.twenty)
                    hourlyConditions.append(hourly.twentyone)
                    hourlyConditions.append(hourly.twentytwo)
                    hourlyConditions.append(hourly.twentythree)
                    hourlyConditions.append(hourly.twentyfour)
                    
                    DispatchQueue.main.async {
                        completion(hourlyConditions)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                }.resume()
        }
    }
    
    static func downloadData(feedUrl:String, completion: @escaping (City, CurrentConditions) -> Void) {
        let urlString = feedUrl
        let url = URL(string: urlString)
        
        if let urlObject = url {
            URLSession.shared.dataTask(with: urlObject) { (data, ressponse, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let feed = try decoder.decode(Weather.self, from: data)
                    let city = feed.city
                    let currentConditions = feed.currentConditions
                    
                    DispatchQueue.main.async {
                        guard let city = city else { return }
                        guard let currentConditions = currentConditions else { return }

                        completion(city, currentConditions)
                    }
                    
                } catch let jsonErr {
                    print("we got an error \(jsonErr)")
                }
                }.resume()
        }
    }
}

struct City:Decodable {
    let name:String?
    let stateAbbreviation:String?
    let latitude:String?
    let longitude:String?
    
    private enum CodingKeys:String, CodingKey {
        case name = "Name"
        case stateAbbreviation = "StateAbbreviation"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }
}

struct CurrentConditions:Decodable {
    let tempF:Int?
    let sky:String?
    let feelsLikeF:Int?
    let iconCode:Int?
    //    let gust:Int?
    let visibility:Int?
    let humidity:Int?
    
    private enum CodingKeys:String, CodingKey {
        case visibility, humidity
        case tempF = "TempF"
        case sky = "Sky"
        case feelsLikeF = "FeelsLikeF"
        case iconCode = "IconCode"
        //        case gust = "Gust"
    }
}

struct Daily:Decodable {
    private enum CodingKeys : String, CodingKey {
        case zero = "0"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
    }
    let zero:Day
    let one:Day
    let two:Day
    let three:Day
    let four:Day
    let five:Day
    let six:Day
    let seven:Day
    let eight:Day
    let nine:Day
}

struct Day:Decodable {
    let skyCode:Int?
    let skyText:String?
    let validDateLocal:String?
    let dayText:String?
    let iconCode:Int?
    let windSpeedMph:Int?
    let hiTempF:Int?
    let loTempF:Int?
    let sunset:String?
    let sunrise:String?
    let precipChance:Int?
    
    private enum CodingKeys:String, CodingKey {
        case skyCode = "SkyCode"
        case skyText = "SkyText"
        case validDateLocal = "ValidDateLocal"
        case dayText = "dayText"
        case iconCode = "IconCode"
        case windSpeedMph = "WindSpeedMph"
        case hiTempF = "HiTempF"
        case loTempF = "LoTempF"
        case sunset = "Sunset"
        case sunrise = "Sunrise"
        case precipChance = "PrecipChance"
    }
}

struct Hourly:Decodable {
    private enum CodingKeys : String, CodingKey {
        case zero = "0"
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case ten = "10"
        case eleven = "11"
        case twelve = "12"
        case thirteen = "13"
        case fourteen = "14"
        case fifteen = "15"
        case sixteen = "16"
        case seventeen = "17"
        case eighteen = "18"
        case nineteen = "19"
        case twenty = "20"
        case twentyone = "21"
        case twentytwo = "22"
        case twentythree = "23"
        case twentyfour = "24"
    }
    let zero:Hour
    let one:Hour
    let two:Hour
    let three:Hour
    let four:Hour
    let five:Hour
    let six:Hour
    let seven:Hour
    let eight:Hour
    let nine:Hour
    let ten:Hour
    let eleven:Hour
    let twelve:Hour
    let thirteen:Hour
    let fourteen:Hour
    let fifteen:Hour
    let sixteen:Hour
    let seventeen:Hour
    let eighteen:Hour
    let nineteen:Hour
    let twenty:Hour
    let twentyone:Hour
    let twentytwo:Hour
    let twentythree:Hour
    let twentyfour:Hour
}

struct Hour:Decodable {
    let skyCode:Int?
    let skyLong:String?
    let validDateLocal:String?
    let iconCode:Int?
    let windSpeedMph:Int?
    let tempF:Int?
    let precipChance:Int?

    private enum CodingKeys:String, CodingKey {
        case skyCode = "SkyCode"
        case skyLong = "SkyLong"
        case validDateLocal = "ValidDateLocal"
        case iconCode = "IconCode"
        case windSpeedMph = "WindSpeedMph"
        case tempF = "TempF"
        case precipChance = "PrecipChance"
    }
}
