//
//  AndesStandaloneSmall.swift
//  AndesUI
//
//  Created by Jonathan Alonso Pinto on 11/12/20.
//

import Foundation

struct AndesStandaloneSmall: AndesStandaloneSizeProtocol {
    var font = AndesFontStyle(textColor: UIColor.Andes.gray800,
                              font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: AndesFontSize.bodyS),
                              lineSpacing: 5)
    var widthChevron: CGFloat = 12
}
