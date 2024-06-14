import UIKit
import SnapKit
import Then

public class WeatherCell: UICollectionViewCell {
    
    static let identifier = "WeatherCell"
    
    
    let line1 = LineView()
    let line2 = LineView()
    
    let dayLabel = UILabel().then {
        
        $0.font = UIFont.boldSystemFont(ofSize: 24)
//        $0.textAlignment = .center
    }
    
    let dateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
//        $0.textAlignment = .center
    }
    
    let temperatureLabel = UILabel().then {
        $0.font = UIFont(name: "Arial Black", size: 110)
//        $0.textAlignment = .center
    }
    
    let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
//        $0.textAlignment = .center
    }
    
    let temperatureMaxImage = UIImageView().then {
        $0.image = UIImage(named: "temperature-high")
    }
    
    let temperatureMaxLabel = TextLable()
    
    let humidityImage = UIImageView().then {
        $0.image = UIImage(named: "rainy")
    }
    
    let humidityLable = TextLable()
    
    let temperatureMinImage = UIImageView().then {
        $0.image = UIImage(named: "temperature-low")
    }
    
    let temperatureMinLabel = TextLable()
    
    let windSpeedImage = UIImageView().then {
        $0.image = UIImage(named: "windy")
    }
    
    let windSpeedLable = TextLable()
    
    let feelsLikeImage = UIImageView().then {
        $0.image = UIImage(named: "temperature-lines")
    }
    
    let feelsLikeLable = TextLable()
    
    let rainyPercentageImage = UIImageView().then {
        $0.image = UIImage(named: "humidity-percentage")
    }
    
    let rainyPercentageLable = TextLable()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func attribute() {
        backgroundColor = UIColor(named: "weatherViewColor")
    }
    
    func layout() {
        [
            dayLabel,
            dateLabel,
            line1,
            line2,
            temperatureLabel,
            descriptionLabel,
            temperatureMaxImage,
            temperatureMaxLabel,
            humidityImage,
            humidityLable,
            temperatureMinImage,
            temperatureMinLabel,
            windSpeedImage,
            windSpeedLable,
            feelsLikeImage,
            feelsLikeLable,
            rainyPercentageImage,
            rainyPercentageLable
        ].forEach { addSubview($0) }
        
        dateLabel.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(96)
            $0.leading.equalToSuperview().offset(20)
        }
        
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(62)
            $0.leading.equalToSuperview().offset(20)
        }
        
        line1.snp.makeConstraints {
            $0.top.equalToSuperview().offset(166)
            $0.width.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(23)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(23)
        }
        
        line2.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(158)
            $0.width.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(3)
        }
        
        temperatureMaxImage.snp.makeConstraints {
            $0.top.equalTo(line2.snp.bottom).offset(15)
            $0.width.height.equalTo(15)
            $0.leading.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().inset(125)
        }
        
        temperatureMaxLabel.snp.makeConstraints {
            $0.top.equalTo(line2.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(30)
        }
        
        humidityImage.snp.makeConstraints {
            $0.top.equalTo(line2.snp.bottom).offset(15)
            $0.width.height.equalTo(15)
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(125)
        }
        
        humidityLable.snp.makeConstraints {
            $0.top.equalTo(line2.snp.bottom).offset(30)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        temperatureMinImage.snp.makeConstraints {
            $0.top.equalTo(humidityImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.width.height.equalTo(15)
            $0.bottom.equalToSuperview().inset(88)
        }
        
        temperatureMinLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureMaxLabel.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(30)
        }
        
        windSpeedImage.snp.makeConstraints {
            $0.top.equalTo(humidityImage.snp.bottom).offset(20)
            $0.width.height.equalTo(15)
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(88)
        }
        
        windSpeedLable.snp.makeConstraints {
            $0.top.equalTo(temperatureMaxLabel.snp.bottom).offset(21)
            $0.trailing.equalToSuperview().inset(30)
        }
        
        feelsLikeImage.snp.makeConstraints {
            $0.top.equalTo(windSpeedImage.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.width.height.equalTo(15)
            $0.bottom.equalToSuperview().inset(48)
        }
        
        feelsLikeLable.snp.makeConstraints {
            $0.top.equalTo(windSpeedLable.snp.bottom).offset(21)
            $0.leading.equalToSuperview().offset(30)
        }
        
        rainyPercentageImage.snp.makeConstraints {
            $0.top.equalTo(windSpeedImage.snp.bottom).offset(20)
            $0.width.height.equalTo(15)
            $0.trailing.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(48)
        }
        
        rainyPercentageLable.snp.makeConstraints {
            $0.top.equalTo(windSpeedLable.snp.bottom).offset(21)
            $0.trailing.equalToSuperview().inset(30)
        }
    }
    
    func updateDate() {
        dateLabel.text = weatherDateFormatter()
    }
    
    func weatherDateFormatter() -> String {
        
        let currentDate = Date()
        
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "MMM dd  h:mma"
        }
        
        let dateString = dateFormatter.string(from: currentDate)
        return dateString
    }
    
    func temperatureText(text: Double) {
        let a = text - 273.15
        temperatureLabel.text = String(format: "%.1f°", a)
    }
    
    func descriptionText(text: String) {
        descriptionLabel.text = text
    }
    
    func temperatureMaxText(text: Double) {
        let a = text - 273.15
        temperatureMaxLabel.text = String(format: "%.1f°", a)
    }
    
    func humidityText(text: Int) {
        humidityLable.text = "\(text) Precipitation"
    }
    
    func temperatureMinText(text: Double) {
        let a = text - 273.15
        temperatureMinLabel.text = String(format: "%.1f°", a)
    }
    
    func windSpeedText(text: Double) {
        windSpeedLable.text = "\(text)km/h"
    }
    
    func FeelsLikeLable(text: Double) {
        let a = text - 273.15
        feelsLikeLable.text = String(format: "%.1f°", a)
    }
    
    func pop(text: Double) {
        rainyPercentageLable.text = "\(text * 100)%"
    }
}

public extension WeatherCell {
    func setup(day: String, temperature: Double, description: String, temperatureMax: Double, humidity: Int ,temperatureMin: Double, windSpeed: Double, FeelsLike: Double, Pop: Double) {
        dayLabel.text = day
        updateDate()
        temperatureText(text: temperature)
        descriptionText(text: description)
        temperatureMaxText(text: temperatureMax)
        humidityText(text: humidity)
        temperatureMinText(text: temperatureMin)
        windSpeedText(text: windSpeed)
        FeelsLikeLable(text: FeelsLike)
        pop(text: Pop)
    }
}
