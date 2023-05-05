//
//  CustomUITextField.swift
//  19.5 Practice task
//
//  Created by Alex Aytov on 5/4/23.
//

import UIKit

class CustomUITextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        borderStyle = .roundedRect
        clearButtonMode = .whileEditing
        returnKeyType = .done
        
//        self.addDoneCancelToolbar()
        
        autocapitalizationType = .none
        autocorrectionType = .no
        spellCheckingType = .no
        smartQuotesType = .no
        smartDashesType = .no
        smartInsertDeleteType = .no
        
        normalBorderStile()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func normalBorderStile() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth  = 1
        layer.cornerRadius = 4
    }
    
    func errorBorderStile() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth  = 1
        layer.cornerRadius = 4
    }
    
    func isValueExist() -> Bool {
        guard let textValue = self.text, !textValue.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        return true
    }
}


extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
    
}
