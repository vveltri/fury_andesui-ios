//
//  DropdownViewController.swift
//  AndesUI-demoapp
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class DropdownViewController: UIViewController {

    @IBOutlet var andesDropdown: AndesDropdown!
    @IBOutlet var radioButtonForm: AndesRadioButton!
    @IBOutlet var radioButtonStandAlone: AndesRadioButton!
    @IBOutlet var textField: AndesTextField!
    @IBOutlet var placelholderField: AndesTextField!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var helperTextField: AndesTextField!
    
    var cell: [AndesDropDownMenuCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        helperTextField.delegate = self
        textField.delegate = self
        placelholderField.delegate = self
        segmentedControl.isEnabled = false

        let mastercard = AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size80, state: .enabled, image: UIImage(named: "mastercard") ?? UIImage(), accentColor: UIColor.systemBlue)
        let visa = AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size80, state: .enabled, image: UIImage(named: "visa") ?? UIImage(), accentColor: UIColor.clear)
        let american = AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size80, state: .enabled, image: UIImage(named: "american") ?? UIImage(), accentColor: UIColor.clear)
        let mercadocredito = AndesThumbnail(hierarchy: .defaultHierarchy, type: .imageCircle, size: .size80, state: .enabled, image: UIImage(named: "mercadocredito") ?? UIImage(), accentColor: UIColor.clear)

        cell =
            [AndesDropDownMenuCell(title: "Dinero en cuenta", thumbnail: mastercard),
             AndesDropDownMenuCell(title: "Visa debito **** 0899", thumbnail: visa),
             AndesDropDownMenuCell(title: "BBVA **** 7788", thumbnail: american),
             AndesDropDownMenuCell(title: "BBVA **** 4545", thumbnail: american),
             AndesDropDownMenuCell(title: "Mercado Créditos", thumbnail: mercadocredito)]

        andesDropdown.delegate = self
        self.updateFormDropdownView()
        andesDropdown.menuType = DropdownBottomSheetMenu(separatorStyle: .none,
                                                         numberOfLines: 1,
                                                         rows: cell,
                                                         selectionStyle: .defaultStyle)

        radioButtonForm.setRadioButtonTapped(callback: didTapIdle(radiobutton:))
        radioButtonStandAlone.setRadioButtonTapped(callback: didTapIdle(radiobutton:))

    }

    func didTapIdle(radiobutton: AndesRadioButton) {
        if radiobutton == radioButtonForm {
            radioButtonForm.status = .selected
            radioButtonStandAlone.status = .unselected
            self.updateFormDropdownView()
            textField.state = .idle
            placelholderField.state = .idle
            segmentedControl.isEnabled = false
        } else if radiobutton == radioButtonStandAlone {
            radioButtonForm.status = .unselected
            radioButtonStandAlone.status = .selected
            self.updateStandaloneDropdownView()
            textField.state = .disabled
            placelholderField.state = .disabled
            segmentedControl.isEnabled = true
        }
        textField.text = ""
        placelholderField.text = ""
        segmentedControl.selectedSegmentIndex = 1
    }

    func updateFormDropdownView(title: String = "", placeholder: String = "Placeholder para Dropdown", helperText: String = "") {
        andesDropdown.triggerType = FormDropdownTrigger(title: title, placeholder: placeholder, helperText: helperText)
    }

    func updateStandaloneDropdownView(size: AndesStandaloneSize = .medium) {
        andesDropdown.triggerType = StandaloneDropdownTrigger(size: size)
    }

    @IBAction func valueChangeSegmented() {
        if segmentedControl.selectedSegmentIndex == 0 {
            updateStandaloneDropdownView(size: .small)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            updateStandaloneDropdownView(size: .medium)
        } else {
            updateStandaloneDropdownView(size: .large)
        }
    }
}

extension DropdownViewController: AndesDropdownDelegate {
    func didSelectRowAt(indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension DropdownViewController: AndesTextFieldDelegate {
    func andesTextFieldDidEndEditing(_ textField: AndesTextField) {
        if andesDropdown.triggerType.isKind(of: FormDropdownTrigger.self) {
            self.updateFormDropdownView(title: self.textField.text, placeholder: self.placelholderField.text, helperText: self.helperTextField.text)
        } else {
            self.updateStandaloneDropdownView()
        }
    }
}
