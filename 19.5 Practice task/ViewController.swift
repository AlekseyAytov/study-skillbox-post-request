//
//  ViewController.swift
//  19.5 Practice task
//
//  Created by Alex Aytov on 5/2/23.
//

import SnapKit

class ViewController: UIViewController {
    
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
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "nameTextField"
        textField.borderStyle = .roundedRect
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
    
    private lazy var lastnameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "lastnameTextField"
        textField.borderStyle = .roundedRect
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
    
    private lazy var occupationTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "occupationTextField"
        textField.borderStyle = .roundedRect
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
    
    private lazy var birthTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "birthTextField"
        textField.borderStyle = .roundedRect
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
    
    private lazy var countryTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.placeholder = "countryTextField"
        textField.borderStyle = .roundedRect
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
        print("buttonURLSessionPressed")
        activityIndicator.startAnimating()
        resultLabel.isHidden.toggle()
    }
    
    @objc func buttonAlamofirePressed() {
        print("buttonURLSessionPressed")
        activityIndicator.stopAnimating()
        resultLabel.isHidden.toggle()
    }
}

extension ViewController: UITextFieldDelegate {
    
}

