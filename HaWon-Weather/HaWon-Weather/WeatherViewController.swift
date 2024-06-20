import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var model = Weathers_DTO(cod: "", message: 0, cnt: 0, list: [], city: City_DTO(id: 0, name: "", coord: Coord_DTO(lat: 0.0, lon: 0.0), country: "", population: 0, timezone: 0, sunrise: 0, sunset: 0))
    
    let collectionView:  UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(named: "weatherViewColor")
        cv.isPagingEnabled = true
        return cv
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        attribute()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        makeGetCall()
    }
    
    func attribute() {
        view.backgroundColor = UIColor(named: "weatherViewColor")
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func timeCheck() -> [Int] {
        
        let today = model.list[0].dtTxt.components(separatedBy: " ")
        
        var todayIndex: Int = 0
        for i in 0..<9 {
            if model.list[i].dtTxt.components(separatedBy: " ")[0] == today[0] {
                todayIndex += 1
            } else {
                break
            }
        }
        print(todayIndex)
        
        let time = Date()
        _ = Calendar.current.dateComponents([.hour], from: time)
        
        let timeHour = Calendar.current.dateComponents([.hour], from: time)
        
        let timeHour1: Int = timeHour.hour!
        print(timeHour1)
        
        var hourIndex = -1
        for i in 0..<todayIndex {
            let apiHour = Int(model.list[i].dtTxt.components(separatedBy: " ")[1].components(separatedBy: ":")[0])!
            if apiHour <= timeHour1 {
                //                hourIndex += 1
            } else {
                break
            }
        }
        
        var lastDay: Int = 39-todayIndex
        if Int(model.list[39].dtTxt.components(separatedBy: " ")[1].components(separatedBy: ":")[0])! <= timeHour1 {
            lastDay = 39
        } else {
            for i in stride(from: 39, to: 39-todayIndex, by: -1) {
                let apiHour = Int(model.list[i].dtTxt.components(separatedBy: " ")[1].components(separatedBy: ":")[0])!
                if apiHour <= timeHour1 {
                    lastDay += 1
                } else {
                    break
                }
                print(apiHour)
            }
        }
        
        print([hourIndex, hourIndex+8, hourIndex+16, hourIndex+24, hourIndex+32, lastDay])
        
        return [hourIndex, hourIndex+8, hourIndex+16, hourIndex+24, hourIndex+32, lastDay]
    }
    
    var currentIndex: Int = 0
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        print("Current Page Index: \(pageIndex)")
        currentIndex = pageIndex+1
        collectionView.reloadData()
    }
    
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        print("인덱스 제발제발 \(indexPath.row)")
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCell.identifier, for: indexPath) as? WeatherCell
    //
    //        switch indexPath.row {
    //        case 0:
    //            cell?.backgroundColor = .red
    //        case 1:
    //            cell?.backgroundColor = .blue
    //        case 2:
    //            cell?.backgroundColor = .yellow
    //        default:
    //            break
    //        }
    //
    //        cell?.setup(day: "day", temperature: 0.0, description: "", temperatureMax: 0.0, humidity: 0, temperatureMin: 0.0, windSpeed: 0.0, FeelsLike: 0.0, Pop: 0.0)
    //
    //        return cell ?? UICollectionViewCell()
    //    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCell.identifier,
            for: indexPath) as? WeatherCell
        
        var daysOfWeek: [String] = []
        
        let time = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        let currentWeekday = dateFormatter.string(from: time)
        
        print("요일 : \(currentWeekday)")
        
        
        switch currentWeekday {
        case "Monday":
            daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            break
        case "Tuesday":
            daysOfWeek = ["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday","Sunday"]
            break
        case "Wednesday":
            daysOfWeek = ["Wednesday", "Thursday", "Friday", "Saturday","Sunday", "Monday"]
            break
        case "Thursday":
            daysOfWeek = ["Thursday", "Friday", "Saturday","Sunday", "Monday", "Tuesday"]
            break
        case "Friday":
            daysOfWeek = ["Friday", "Saturday","Sunday", "Monday", "Tuesday", "Wednesday"]
            break
        case "Saturday":
            daysOfWeek  = ["Saturday","Sunday", "Monday", "Tuesday", "Wednesday", "Thursday"]
            break
        case "Sunday":
            daysOfWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
            break
        default:
            daysOfWeek = ["No Date"]
        }
        
        print("인덱스 : \(currentIndex)")
        
//                let arrray = timeCheck()
//        
//                print("array == \(arrray)")
//        
        //        print("index :: \(indexPath.row) arrayIndex :: \(arrray[indexPath.row])")
        
        
        if !model.list.isEmpty {
            let array = timeCheck()
            
            let weatherItem = model.list[array[currentIndex]]
            let description = weatherItem.weather.first?.description.rawValue ?? "No Description"
            let wind =  weatherItem.wind.speed
            
            print("인덱스 : \(indexPath.row) dt : \(weatherItem.dt)")
            //            cell?.backgroundColor = .red
            
            cell?.setup(day: daysOfWeek[currentIndex], temperature: Double(weatherItem.main.temp), description: description, temperatureMax: Double(weatherItem.main.tempMax), humidity: Int(weatherItem.main.humidity),temperatureMin: Double(weatherItem.main.tempMin), windSpeed: Double(wind), FeelsLike: Double(weatherItem.main.feelsLike), Pop: Double(weatherItem.pop))
        } else {
            cell?.setup(day: "No Data", temperature: 0.0, description: "No Description", temperatureMax: 0.0, humidity: 0,temperatureMin: 0.0, windSpeed: 0.0, FeelsLike: 0.0, Pop: 0.0)
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row) 번째 인덱스 cell 클릭 됨")
    }
    
    func makeGetCall() {
        guard let url = URL(string: "\(Bundle.main.API_KEY)") else {
            print("URL is not correct")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session: URLSession = URLSession(configuration: .default)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            let successRange: Range = (200..<300)
            if let response: HTTPURLResponse = response as? HTTPURLResponse {
                debugPrint("status code: \(response.statusCode)")
                if successRange.contains(response.statusCode) {
                    if let data = data {
                        do {
                            let decodedResponse = try JSONDecoder().decode(Weathers_DTO.self, from: data)
                                                                                    print(decodedResponse)
                            
                            DispatchQueue.main.async {
                                self.model = decodedResponse
                                self.collectionView.reloadData()
                            }
                        } catch {
                            print("Decoding error : \(error)")
                        }
                    }
                }
            }
        }
        .resume()
    }
    
}

extension Bundle {
    
    var API_KEY: String {
        guard let file = self.path(forResource: "WeatherInfo", ofType: "plist") else {return ""}
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        
        // 딕셔너리에서 값 찾기
        guard let key = resource["API_KEY"] as? String else {
            fatalError("API_KEY error")
        }
        return key
    }
}
