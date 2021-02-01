//
//  AndesDatePickerHeaderViewTests.swift
//  AndesUI_Tests
//
//  Created by Ândriu Felipe Coelho on 26/01/21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Quick
import Nimble

@testable import AndesUI

class AndesDatePickerHeaderViewTests: QuickSpec {

    var internalView: AndesDatePickerHeaderView!

    override func spec() {

        beforeEach {
            self.internalView = AndesDatePickerHeaderView()
        }

        afterEach {
            self.internalView = AndesDatePickerHeaderView()
        }

        describe("Test: checks if the collection view is set up correctly") {
            context("verify class") {

                it("collectionview data source should not be nil") {
                    expect(self.internalView).toNot(beNil())
                }

                it("passing a due date, the back button must be disabled (for the current month)") {
                    let andesPicker = AndesDatePickerDefaultView()
                    andesPicker.setDates(maxDate: Calendar.current.date(from: DateComponents(year: 2021, month: 2, day: 07)))

                    guard let currentDate = Calendar.current.date(from: DateComponents(year: 2021, month: 1, day: 27)) else {
                        fatalError("error to create date")
                    }

                    let daysToRender = andesPicker.dayCalendar.getDaysInMonth(currentDate, Date())

                    self.internalView.togglePreviousButton(days: daysToRender)

                    expect(self.internalView.previousButton.isEnabled).to(beFalse())
                }
            }
        }
    }

}
