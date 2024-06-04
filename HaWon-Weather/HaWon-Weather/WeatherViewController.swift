import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WeatherCell.identifier ,
            for: indexPath) as? WeatherCell
        
        let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        
        
        cell?.setup(day: daysOfWeek[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    
    
    func makeGetCall() {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=36.391479&lon=127.363355&appid=43473bacbc7cf623956124feb09d6aa4") else {
            print("URL is not correct")
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session: URLSession = URLSession(configuration: .default)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            let successRange: Range = (200..<300)
            
            // 통신 성공
            guard let data: Data = data,
                  error == nil
                    
            else { return }
            
            if let response: HTTPURLResponse = response as? HTTPURLResponse{
                debugPrint("status code: \(response.statusCode)")
                
                // 요청 성공
                if successRange.contains(response.statusCode){
                    
                    // decode
//                    guard let Info: Weathers = try? JSONDecoder().decode(Weathers.self, from: data) else {
//                        debugPrint("error1")
//                        return
//                    }
                    
                    let result = try? JSONDecoder().decode(Weathers.self, from: data)
                    print(result ?? "시발")
                    
                    debugPrint("hthffh")
                    
                } else {
                    debugPrint("error2")
                }
            }
        }
        .resume()
    }
    
}
