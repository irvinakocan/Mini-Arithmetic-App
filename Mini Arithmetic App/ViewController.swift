import UIKit
import SnapKit

class ViewController: UIViewController {
    let calculateButton = UIButton()
    let firstLabel = UILabel()
    let firstTextField = UITextField()
    let secondLabel = UILabel()
    let secondTextField = UITextField()
    
    var input1: Double?
    var input2: Double?
    var result: String {
        if let x = input1,
           let y = input2 {
            let r = """
            x + y = \(x + y)
            x - y = \(x - y)
            x * y = \(x * y)
            x / y = \(x / y)
            """
            return r
        }
        return ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(calculateButton)
        calculateButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(firstLabel)
        view.addSubview(firstTextField)
        view.addSubview(secondLabel)
        view.addSubview(secondTextField)
        
        firstTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        setApperiance()
        setConstraints()
    }
    
    func clearBorder(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0
    }
    
    func redBorder(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 2
    }
    
    func validate(_ textField: UITextField) {
        if let unwrappedText = textField.text {
            if let doubleValue = Double(unwrappedText) {
                clearBorder(textField)
                
                if textField == firstTextField {
                    input1 = doubleValue
                }
                else if textField == secondTextField {
                    input2 = doubleValue
                }
            }
            else {
                redBorder(textField)
                if textField.text == "" {
                    clearBorder(textField)
                }
            }
        }
    }
    
    @objc func textFieldChanged(_ textField: UITextField) {
        validate(textField)
    }
    
    @objc func buttonTapped() {
        let calculationVC = CalculationViewController()
        calculationVC.result.text = result
        calculationVC.resetDelegate = self
        navigationController?.pushViewController(calculationVC, animated: false)
    }
    
    func setApperiance() {
        view.backgroundColor = .systemPurple
        
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(.black, for: .normal)
        calculateButton.setBackgroundImage(UIImage(named: "Button"), for: .normal)
        calculateButton.titleLabel?.font = .systemFont(ofSize: 18)
        
        firstLabel.text = "Input 1:"
        firstLabel.textColor = .black
        firstLabel.font = .systemFont(ofSize: 18)

        secondLabel.text = "Input 2:"
        secondLabel.textColor = .black
        secondLabel.font = .systemFont(ofSize: 18)
        
        firstTextField.backgroundColor = .white
        secondTextField.backgroundColor = .white
        firstTextField.font = .systemFont(ofSize: 18)
        secondTextField.font = .systemFont(ofSize: 18)
    }
    
    func setConstraints() {
        // Calculate button constraints
        calculateButton.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-150)}
        
        // First label constraints
        firstLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(25)}
        
        // First Text field constraints
        firstTextField.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(firstLabel.snp.bottom).offset(8)
            make.height.equalTo(30)}
        
        // Second label constraints
        secondLabel.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(firstTextField.snp.bottom).offset(8)
            make.height.equalTo(25)}
        
        // Second Text field constraints
        secondTextField.snp.makeConstraints{ make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(secondLabel.snp.bottom).offset(8)
            make.height.equalTo(30)}
    }
}

extension ViewController: ResetingDelegate {
    func didTapReset() {
        firstTextField.text = nil
        secondTextField.text = nil
    }
}
