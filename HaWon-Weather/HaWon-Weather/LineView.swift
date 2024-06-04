import UIKit

class LineView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    private func setupView() {
        self.backgroundColor = .black
        self.layer.cornerRadius = 10
    }
    
    
}
