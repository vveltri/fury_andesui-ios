//
//  AndesDropdownConfigFactory.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 13/11/20.
//

import Foundation

internal class AndesDropdownViewConfigFactory {
    static func provide(from dropdown: AndesDropdown, isSelected: Bool) -> AndesDropdownViewConfig {

        let triggerType = dropdown.triggerType
        let formTrigger = dropdown.triggerType as? FormDropdownTrigger
        let standaloneTrigger = dropdown.triggerType as? StandaloneDropdownTrigger
        let standAloneSize = AndesStandaloneSizeFactory.provideSize(withSize: standaloneTrigger?.size ?? .medium)

        switch triggerType.type {
        case .formDropdown:
            return AndesDropdownViewConfig(placeholderText: formTrigger?.placeholder,
                                           icon: isSelected ? AndesIcons.chevronUp20 : AndesIcons.chevronDown20,
                                           title: formTrigger?.title,
                                           iconColor: UIColor.Andes.blueML500,
                                           helperText: formTrigger?.helperText)
        case .standalone:
            return AndesDropdownViewConfig(icon: isSelected ? AndesIcons.chevronUp20 : AndesIcons.chevronDown20,
                                           font: standAloneSize.font,
                                           heightChevron: standAloneSize.widthChevron,
                                           iconColor: UIColor.Andes.gray450)
        }
    }
}
