import UIKit
import SnapKit
import Then

public class WeatherCell: UICollectionViewCell {
    
    static let identifier = "WeatherCell"
    
    
    let line1 = LineView()
    let line2 = LineView()
    
    let dayLabel = UILabel().then {
        
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textAlignment = .center
    }
    let dateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textAlignment = .center
    }
    
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
            line2
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
        
        line2.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(158)
            $0.width.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(3)
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
}
    
    public extension WeatherCell {
        func setup(day: String) {
            dayLabel.text = day
            updateDate()
        }
    }

