//
//  ViewController.swift
//  19.5 Practice task
//
//  Created by Alex Aytov on 5/2/23.
//

import SnapKit
import RegexBuilder

class ViewController: UIViewController {
    
    var dataForSending: [ModelTitle: String] = [:]
    
    let counrtyRegex = Regex {
        OneOrMore(
            ChoiceOf{
                CharacterClass(.word)
                CharacterClass(.whitespace)
                "-"
                "'"
                ""
            }
        )
    }
    
    let birthRegex = Regex {
        One(.anyOf("1,2"))
        Repeat(count: 3) {
            .digit
        }
    }
    
    private lazy var aboutInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "aboutInfoaboutInfoaboutInfoaboutInfoaboutInfoaboutInfoaboutInfo"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
// ----- name -----------------------------------
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "nameLabel"
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var nameTextField: CustomUITextField = {
        let textField = CustomUITextField(placeholder: "nameTextField")
        textField.delegate = self
        return textField
    }()
    
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 3
        return stackView
    }()
    
    lazy var nameErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var nameTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- lastname ---------------------------------
    
    private lazy var lastnameLabel: UILabel = {
        let label = UILabel()
        label.text = "lastnameLabel"
        return label
    }()
    
    private lazy var lastnameTextField: CustomUITextField = {
        let textField = CustomUITextField(placeholder: "lastnameTextField")
        textField.delegate = self
        return textField
    }()
    
    private lazy var lastnameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var lastnameErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var lastnameTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- occupation -----------------------------
    
    private lazy var occupationLabel: UILabel = {
        let label = UILabel()
        label.text = "occupationLabel"
        return label
    }()
    
    private lazy var occupationTextField: CustomUITextField = {
        let textField = CustomUITextField(placeholder: "occupationTextField")
        textField.delegate = self
        return textField
    }()
    
    private lazy var occupationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var occupationErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var occupationTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- birth ----------------------------------
    
    private lazy var birthLabel: UILabel = {
        let label = UILabel()
        label.text = "birthLabel"
        return label
    }()
    
    private lazy var birthTextField: CustomUITextField = {
        let textField = CustomUITextField(placeholder: "birthTextField")
        textField.delegate = self
        textField.keyboardType = .numberPad
        textField.textContentType = .dateTime
        return textField
    }()
    
    private lazy var birthStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var birthErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var birthTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- country --------------------------------
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "countryLabel"
        return label
    }()
    
    private lazy var countryTextField: CustomUITextField = {
        let textField = CustomUITextField(placeholder: "countryTextField")
        textField.delegate = self
        return textField
    }()
    
    private lazy var countryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    lazy var countryErrorLabel: UILabel = {
        let label = UILabel()
        label.text = "error"
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private lazy var countryTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
// ----- buttons --------------------------------
    
    private lazy var buttonURLSession: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("buttonURLSession", for: .normal)
        button.backgroundColor = UIColor(red: 0.95, green: 0.83, blue: 0.01, alpha: 1.00)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.87, green: 0.76, blue: 0.00, alpha: 1.00).cgColor
//        button.isEnabled = false
    
        button.addTarget(self, action: #selector(buttonURLSessionPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonAlamofire: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("buttonAlamofire", for: .normal)
        button.backgroundColor = UIColor(red: 0.95, green: 0.83, blue: 0.01, alpha: 1.00)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(red: 0.87, green: 0.76, blue: 0.00, alpha: 1.00).cgColor
//        button.isEnabled = false
        
        button.addTarget(self, action: #selector(buttonAlamofirePressed), for: .touchUpInside)
        return button
    }()
    
// ----- result ---------------------------------
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .orange
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "resultLabel"
        label.isHidden = true
        return label
    }()
    
// ----------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(aboutInfo)
        
        stackView.addArrangedSubview(nameStackView)
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextFieldStackView)
        nameTextFieldStackView.addArrangedSubview(nameTextField)
        nameTextFieldStackView.addArrangedSubview(nameErrorLabel)

        stackView.addArrangedSubview(lastnameStackView)
        lastnameStackView.addArrangedSubview(lastnameLabel)
        lastnameStackView.addArrangedSubview(lastnameTextFieldStackView)
        lastnameTextFieldStackView.addArrangedSubview(lastnameTextField)
        lastnameTextFieldStackView.addArrangedSubview(lastnameErrorLabel)

        stackView.addArrangedSubview(occupationStackView)
        occupationStackView.addArrangedSubview(occupationLabel)
        occupationStackView.addArrangedSubview(occupationTextFieldStackView)
        occupationTextFieldStackView.addArrangedSubview(occupationTextField)
        occupationTextFieldStackView.addArrangedSubview(occupationErrorLabel)

        stackView.addArrangedSubview(birthStackView)
        birthStackView.addArrangedSubview(birthLabel)
        birthStackView.addArrangedSubview(birthTextFieldStackView)
        birthTextFieldStackView.addArrangedSubview(birthTextField)
        birthTextFieldStackView.addArrangedSubview(birthErrorLabel)
        
        stackView.addArrangedSubview(countryStackView)
        countryStackView.addArrangedSubview(countryLabel)
        countryStackView.addArrangedSubview(countryTextFieldStackView)
        countryTextFieldStackView.addArrangedSubview(countryTextField)
        countryTextFieldStackView.addArrangedSubview(countryErrorLabel)

        view.addSubview(buttonURLSession)
        view.addSubview(buttonAlamofire)
        view.addSubview(activityIndicator)
        view.addSubview(resultLabel)
        
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        buttonAlamofire.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.centerX.equalToSuperview().offset(-100)
            make.top.equalTo(stackView.snp.bottom).offset(30)
        }
        
        buttonURLSession.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.centerX.equalToSuperview().offset(100)
            make.top.equalTo(stackView.snp.bottom).offset(30)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(stackView.snp.bottom).offset(100)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(stackView.snp.bottom).offset(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        lastnameLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        occupationLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
        countryLabel.snp.makeConstraints { make in
            make.width.equalTo(120)
        }
        
    }
    
    @objc func buttonURLSessionPressed() {
        hideKeyboard()
        guard !nameTextField.errorFlag, !lastnameTextField.errorFlag, !occupationTextField.errorFlag, !birthTextField.errorFlag, !countryTextField.errorFlag else { return }
        
        resultLabel.isHidden = true
        activityIndicator.startAnimating()
        buttonAlamofire.isEnabled = false
        buttonURLSession.isEnabled = false
        
        Service.shared.sendURLSession(networkModel: NetworkModel(data: dataForSending)) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print ("error: \(error.localizedDescription)")
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.resultLabel.isHidden = false
                    self.resultLabel.text = "error"
                    self.resultLabel.textColor = .red
                    
                    self.buttonAlamofire.isEnabled = true
                    self.buttonURLSession.isEnabled = true
                }
            }
            
            if let data = data {
                print("success - \(data)")
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.resultLabel.isHidden = false
                    self.resultLabel.text = "success"
                    self.resultLabel.textColor = .green
                    
                    self.buttonAlamofire.isEnabled = true
                    self.buttonURLSession.isEnabled = true
                }
            }
        }
        
//        Service.shared.sendURLSessionWithResult(networkModel: NetworkModel(data: dataForSending)) { [weak self] result in
//            guard let self = self else { return }
//
//            switch result {
//            case .failure(let error):
//                print("error - \(error.localizedDescription)")
//
//                DispatchQueue.main.async {
//                    self.activityIndicator.stopAnimating()
//                    self.resultLabel.isHidden = false
//                    self.resultLabel.text = "error"
//                    self.resultLabel.textColor = .red
//
//                    self.buttonAlamofire.isEnabled = true
//                    self.buttonURLSession.isEnabled = true
//                }
//            case .success(let data):
//                print("success - \(data)")
//
//                DispatchQueue.main.async {
//                    self.activityIndicator.stopAnimating()
//                    self.resultLabel.isHidden = false
//                    self.resultLabel.text = "success"
//                    self.resultLabel.textColor = .green
//
//                    self.buttonAlamofire.isEnabled = true
//                    self.buttonURLSession.isEnabled = true
//                }
//            }
//        }
    }
    
    @objc func buttonAlamofirePressed() {
        hideKeyboard()
        guard !nameTextField.errorFlag, !lastnameTextField.errorFlag, !occupationTextField.errorFlag, !birthTextField.errorFlag, !countryTextField.errorFlag else { return }
        
        resultLabel.isHidden = true
        activityIndicator.startAnimating()
        buttonAlamofire.isEnabled = false
        buttonURLSession.isEnabled = false
        
        Service.shared.sendAlamofire(networkModel: NetworkModel(data: dataForSending)) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .failure(let error):
                print("error - \(error.localizedDescription)")

                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.resultLabel.isHidden = false
                    self.resultLabel.text = "error"
                    self.resultLabel.textColor = .red

                    self.buttonAlamofire.isEnabled = true
                    self.buttonURLSession.isEnabled = true
                }
            case .success(let data):
                print("success - \(data)")

                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.resultLabel.isHidden = false
                    self.resultLabel.text = "success"
                    self.resultLabel.textColor = .green

                    self.buttonAlamofire.isEnabled = true
                    self.buttonURLSession.isEnabled = true
                }
            }
        }
    }
    
    private func hideKeyboard() {
        nameTextField.resignFirstResponder()
        lastnameTextField.resignFirstResponder()
        occupationTextField.resignFirstResponder()
        birthTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // в данном методе производится валидация значений при вводе
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("------------")
        print("range.location - \(range.location)")
        print("string - \(string)")
        
        
        // запрет ввода первого симпола пробела
        if range.location == 0, string == " " { return false }
        
        // если редактируются поля-Не-наследники CustomUITextField, то разрешаем изменения
        guard let textField = textField as? CustomUITextField else { return true }

        // switch для определения конкретного поля, в котором происходит изменение
        switch textField {
        case nameTextField:
            if nameTextField.errorFlag {
                nameErrorLabel.isHidden = true
            }
            
//            попытка сделать валидацию и присвоение значения во время ввода
//            var temp = (nameTextField.text ?? "") + string
//            if string == "" {
//                temp.remove(at: temp.index(before: temp.endIndex))
//            }
//            if let errorMessage = nameValueValidate(value: temp) {
//                nameTextField.errorFlag = true
//                nameErrorLabel.isHidden = false
//                nameErrorLabel.text = errorMessage
//            } else {
//                dataForSending[.name] = temp
//                nameTextField.errorFlag = false
//            }
            
            return true
        case lastnameTextField:
            if lastnameTextField.errorFlag {
                lastnameErrorLabel.isHidden = true
            }
            return true
        case occupationTextField:
            if occupationTextField.errorFlag {
                occupationErrorLabel.isHidden = true
            }
            return true
        case birthTextField:
            if birthTextField.errorFlag {
                birthErrorLabel.isHidden = true
            }
            
            // если вводимая строка пустая, то разрешаем изменение
            if string.isEmpty { return true }
            // если вводимая строка не приводиться к типу Int, то запрещаем изменения
            guard let _ = Int(string) else { return false }
            // если в поле более 4 символов, то запрещаем изменение
            if range.location >= 4 { return false }
            
            return true
        case countryTextField:
            if countryTextField.errorFlag {
                countryErrorLabel.isHidden = true
            }
            
            // если нет ни одного совпадения с counrtyRegex, то запрещаем изменение
            guard let _ = string.firstMatch(of: counrtyRegex) else { return false }
            
            return true
        default:
            // если редактируются поля, не указанные выше, то разрешаем изменения
            return true
        }
    }
    
//    попытка сделать валидацию и присвоение значения во время ввода
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//        switch textField {
//        case nameTextField:
//            dataForSending[.name] = nil
//            return true
//        default:
//            return true
//        }
//    }
    
    // в методе производится валидация введенных в поля значений и присвоение этих значений локальной модели
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldEndEditing")
        
        switch textField {
        case nameTextField:
            if let errorMessage = nameValueValidate(value: nameTextField.text) {
                nameTextField.errorFlag = true
                nameErrorLabel.isHidden = false
                nameErrorLabel.text = errorMessage
            } else {
                nameTextField.errorFlag = false
                dataForSending[.name] = nameTextField.text
            }
        case lastnameTextField:
            if let errorMessage = lastnameValueValidate(value: lastnameTextField.text) {
                lastnameTextField.errorFlag = true
                lastnameErrorLabel.isHidden = false
                lastnameErrorLabel.text = errorMessage
            } else {
                lastnameTextField.errorFlag = false
                dataForSending[.lastname] = lastnameTextField.text
            }
        case occupationTextField:
            if let errorMessage = occupationValueValidate(value: occupationTextField.text) {
                occupationTextField.errorFlag = true
                occupationErrorLabel.isHidden = false
                occupationErrorLabel.text = errorMessage
            } else {
                occupationTextField.errorFlag = false
                dataForSending[.occupation] = occupationTextField.text
            }
        case birthTextField:
            if let errorMessage = birthValueValidate(value: birthTextField.text) {
                birthTextField.errorFlag = true
                birthErrorLabel.isHidden = false
                birthErrorLabel.text = errorMessage
            } else {
                birthTextField.errorFlag = false
                dataForSending[.birth] = birthTextField.text
            }
        case countryTextField:
            if let errorMessage = countryValueValidate(value: countryTextField.text) {
                countryTextField.errorFlag = true
                countryErrorLabel.isHidden = false
                countryErrorLabel.text = errorMessage
            } else {
                countryTextField.errorFlag = false
                dataForSending[.country] = countryTextField.text
            }
        default:
            return true
        }


//        // для упрощения сделал проверку только на count
//        if dataForSending.count >= 5 {
//            print("all good")
//            buttonAlamofire.isEnabled = true
//            buttonURLSession.isEnabled = true
//        }
        
        return true
    }
    
    func nameValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            return nil
        } else {
            return "Заполните поле"
        }
    }
    
    func lastnameValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            return nil
        } else {
            return "Заполните поле"
        }
    }
    
    func occupationValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            return nil
        } else {
            return "Заполните поле"
        }
    }
    
    func birthValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            if let _ = value.wholeMatch(of: birthRegex) {
                return nil
            } else {
                return "Введите год"
            }
        } else {
            return "Заполните поле"
        }
    }
    
    func countryValueValidate(value: String?) -> String? {
        if let value = value, !value.trimmingCharacters(in: .whitespaces).isEmpty {
            if let _ = value.wholeMatch(of: counrtyRegex) {
                return nil
            } else {
                return "Не может содержать символов"
            }
        } else {
            return "Заполните поле"
        }
    }
}
