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
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.register(WeatherCell.self, forCellWithReuseIdentifier: WeatherCell.identifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        makeGetCall()
    }
    
    func attribute() {
        view.backgroundColor = UIColor(named: "weatherViewColor")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func timeCheck() -> [Int] {
        
        let time = Date()
        let calendar = Calendar.current
        
        let dateComponent = Calendar.current.dateComponents([.hour], from: time)
        
        var indexTime = 0
        for i in stride(from: 0, to: 22, by: 3) {
            if dateComponent.hour == i {
                indexTime = i
            } else if dateComponent.hour! < i {
                if dateComponent.hour! <= (i*2+3)/2 {
                    indexTime = i-3
                } else {
                    indexTime = i
                }
            }
        }
        
        switch indexTime {
        case 0:
            return [0, 8, 16, 24, 32, 40]
        case 3:
            return [1, 9, 17, 25, 33, 41]
        case 6:
            return [2, 10, 18, 26, 34, 42]
        case 9:
            return [3, 11, 19, 27, 35, 43]
        case 12:
            return [4, 12, 20, 28, 36, 44]
        case 15:
            return [5, 13, 21, 29, 37, 45]
        case 18:
            return [6, 14, 22, 30, 38, 46]
        case 21:
            return [7, 15, 23, 31, 39, 47]
        default:
            return [0, 8, 16, 24, 32, 40]
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCell.identifier,
            for: indexPath) as? WeatherCell
        
        let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        
        let arrray = timeCheck()
        
        print("array == \(arrray)")
        
        print("index :: \(indexPath.row) arrayIndex :: \(arrray[indexPath.row])")
        
//        if indexPath.item < model.list.count {
//            let weatherItem = model.list[arrray[indexPath.row]]
//            let description = weatherItem.weather.first?.description.rawValue ?? "No Description"
//            let wind =  weatherItem.wind.speed
//            
//            cell?.setup(day: daysOfWeek[indexPath.item], temperature: Double(weatherItem.main.temp), description: description, temperatureMax: Double(weatherItem.main.tempMax), humidity: Int(weatherItem.main.humidity),temperatureMin: Double(weatherItem.main.tempMin), windSpeed: Double(wind), FeelsLike: Double(weatherItem.main.feelsLike), Pop: Double(weatherItem.pop))
//        } else {
            cell?.setup(day: "No Data", temperature: 0.0, description: "No Description", temperatureMax: 0.0, humidity: 0,temperatureMin: 0.0, windSpeed: 0.0, FeelsLike: 0.0, Pop: 0.0)
//        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
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
