import UIKit
import SnapKit

protocol ResetingDelegate {
    func didTapReset()
}

class CalculationViewController: UIViewController {
    let result = UITextView()
    let resetButton = UIButton()

    var resetDelegate: ResetingDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(result)
        view.addSubview(resetButton)
        resetButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        setAppearance()
        setConstraints()
    }
    
    @objc func buttonTapped() {
        resetDelegate.didTapReset()
        navigationController?.popViewController(animated: false)
    }
    
    func setAppearance() {
        view.backgroundColor = .systemYellow
        
        result.font = .systemFont(ofSize: 18)
        result.textAlignment = .center
        
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.black, for: .normal)
        resetButton.setBackgroundImage(UIImage(named: "Button"), for: .normal)
    }
    
    func setConstraints() {
        // Result view constraints
        result.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(200)
            make.width.equalTo(300)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()}
        
        // Reset button constraints
        resetButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-150)
        }
    }
}
