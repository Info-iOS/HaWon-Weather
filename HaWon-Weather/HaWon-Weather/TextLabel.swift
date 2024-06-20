import UIKit

class TextLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.font = UIFont.systemFont(ofSize: 16)
        self.textAlignment = .center
    }
}


