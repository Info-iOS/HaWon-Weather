import UIKit

class TestViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func dayCheck() -> [Int] {
        
        guard !model.list.isEmpty else {
                print("model.list is empty")
                return [0]
            }
        
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
                hourIndex += 1
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCell.identifier,
            for: indexPath) as? WeatherCell
        
        if let array: [Int]? = dayCheck() {
            print("Array: \(array)")
        } else {
            print("Array is nil")
        }
        return cell ?? UICollectionViewCell()
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
                //                debugPrint("status code: \(response.statusCode)")
                if successRange.contains(response.statusCode) {
                    if let data = data {
                        do {
                            let decodedResponse = try JSONDecoder().decode(Weathers_DTO.self, from: data)
                            //                            print(decodedResponse)
                            
                            DispatchQueue.main.async {
                                self.model = decodedResponse
                                self.collectionView.reloadData()
                                self.dayCheck()
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

