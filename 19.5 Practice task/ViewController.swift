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
            }
        )
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
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
        stackView.spacing = 5
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
    
// ----- buttons --------------------------------
    
    private lazy var buttonURLSession: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("buttonURLSession", for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.addTarget(self, action: #selector(buttonURLSessionPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonAlamofire: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("buttonAlamofire", for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.addTarget(self, action: #selector(buttonAlamofirePressed), for: .touchUpInside)
        return button
    }()
    
// ----- result ---------------------------------
    
    private lazy var resultStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .orange
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "resultLabel"
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
        
        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(lastnameStackView)
        stackView.addArrangedSubview(occupationStackView)
        stackView.addArrangedSubview(birthStackView)
        stackView.addArrangedSubview(countryStackView)
        
        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(nameTextField)
        
        lastnameStackView.addArrangedSubview(lastnameLabel)
        lastnameStackView.addArrangedSubview(lastnameTextField)
        
        occupationStackView.addArrangedSubview(occupationLabel)
        occupationStackView.addArrangedSubview(occupationTextField)
        
        birthStackView.addArrangedSubview(birthLabel)
        birthStackView.addArrangedSubview(birthTextField)
        
        countryStackView.addArrangedSubview(countryLabel)
        countryStackView.addArrangedSubview(countryTextField)
        
        view.addSubview(buttonURLSession)
        view.addSubview(buttonAlamofire)
        view.addSubview(activityIndicator)
        view.addSubview(resultLabel)
        
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
    }
    
    @objc func buttonURLSessionPressed() {
        hideKeyboard()
        print("buttonURLSessionPressed")
        
//        activityIndicator.startAnimating()
//        resultLabel.isHidden.toggle()
        emptyValidateTextFields()
    }
    
    @objc func buttonAlamofirePressed() {
        hideKeyboard()
        print("buttonURLSessionPressed")
//        activityIndicator.stopAnimating()
//        resultLabel.isHidden.toggle()
        print(dataForSending)
        
    }
    
    private func hideKeyboard() {
        nameTextField.resignFirstResponder()
        lastnameTextField.resignFirstResponder()
        occupationTextField.resignFirstResponder()
        birthTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
    }
    
    func emptyValidateTextFields() {
//        for title in ModelTitle.allCases {
//            if let textValue = dataForSending[title], !textValue.trimmingCharacters(in: .whitespaces).isEmpty {
//                print(textValue)
//            } else {
//                print("Error - \(title)")
//            }
//        }
        if !nameTextField.isValueExist() {       nameTextField.errorBorderStile() }
        if !lastnameTextField.isValueExist() {   lastnameTextField.errorBorderStile() }
        if !occupationTextField.isValueExist() { occupationTextField.errorBorderStile() }
        if !birthTextField.isValueExist() {      birthTextField.errorBorderStile() }
        if !countryTextField.isValueExist() {    countryTextField.errorBorderStile() }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        let textField = textField as! CustomUITextField
//
//        switch textField {
//        case nameTextField:
//            textField.normalBorderStile()
//        case lastnameTextField:
//            textField.normalBorderStile()
//        case occupationTextField:
//            textField.normalBorderStile()
//        case birthTextField:
//            textField.normalBorderStile()
//        case countryTextField:
//            textField.normalBorderStile()
//        default:
//            return
//        }
//    }
    
    // в данном методе производится валидация значений при вводе
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("range.location - \(range.location)")
        print("string - \(string)")
        print("------------")
        
        // запрет ввода первого симпола пробела
        if range.location == 0 && string == " " { return false }
        
        // если редактируются поля-Не-наследники CustomUITextField, то разрешаем изменения
        guard let textField = textField as? CustomUITextField else { return true }

        // switch для определения конкретного поля, в котором происходит изменение
        switch textField {
        case nameTextField:
            // при начале радактирования поля удаляем сообщение об ошибке
            if range.location == 0 { textField.normalBorderStile() }
            return true
        case lastnameTextField:
            if range.location == 0 { textField.normalBorderStile() }
            return true
        case occupationTextField:
            if range.location == 0 { textField.normalBorderStile() }
            return true
        case birthTextField:
            if range.location == 0 { textField.normalBorderStile() }
            
            // если вводимая строка пустая (т.е. было удаление символа), то разрешаем изменение
            if string.isEmpty { return true }
            // если вводимая строка не приводиться к типу Int, то запрещаем изменения
            guard let _ = Int(string) else { return false }
            // если введено более 4 символов, то запрещаем изменение
            if range.location >= 4 { return false }
            
            return true
        case countryTextField:
            if range.location == 0 { textField.normalBorderStile() }
            
            // если нет ни одного совпадения с counrtyRegex, то запрещаем изменение
            guard let _ = string.firstMatch(of: counrtyRegex) else { return false }
            
            return true
        default:
            // если редактируются поля, не указанные выше, то разрешаем изменения
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            dataForSending[.name] = textField.text
        case lastnameTextField:
            dataForSending[.lastname] = textField.text
        case occupationTextField:
            dataForSending[.occupation] = textField.text
        case birthTextField:
            dataForSending[.birth] = textField.text
        case countryTextField:
            dataForSending[.country] = textField.text
        default:
            return
        }
    }
}
