//
//  DropdownTexfieldViewDefault.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 11/12/20.
//

import Foundation

class AndesDropdownFormViewDefault: AndesDropdownAbstractView {

    @IBOutlet var textField: AndesTextField!

    override var text: String {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }

    override func loadNib() {
        let bundle = AndesDropdownBundle.bundle()
        bundle.loadNibNamed("AndesDropdownFormViewDefault", owner: self, options: nil)
    }

    override func setup() {
        super.setup()
        self.textField.delegate = self
    }

    override func updateView() {

        guard let config = self.config else { return }

        let rightComponent = AndesTextFieldComponentIcon(andesIconName: config.icon ?? "",
                                                         tintColor: config.iconColor)

        self.textField.label = config.title
        self.textField.placeholder = config.placeholderText
        self.textField.rightContent = rightComponent
        self.textField.helper = config.helperText
    }
}

extension AndesDropdownFormViewDefault: AndesTextFieldDelegate {
    func andesTextFieldShouldBeginEditing(_ textField: AndesTextField) -> Bool {
        delegate?.didSelectTrigger()
        return false
    }
}
