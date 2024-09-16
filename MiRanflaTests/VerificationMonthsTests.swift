//
//  VerificationMonthsTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 16/09/24.
//

@testable import MiRanfla
import XCTest

final class VerificationMonthsTests: XCTestCase {

    func testForZeroAndNine() {
        for number in ["0", "9"] {
            let months = VerificationMonths(forPlate: number)
            
            XCTAssertEqual(months.first, .may)
            XCTAssertEqual(months.second, .december)
        }
    }

    func testForOneAndTwo() {
        for number in ["1", "2"] {
            let months = VerificationMonths(forPlate: number)
            
            XCTAssertEqual(months.first, .april)
            XCTAssertEqual(months.second, .october)
        }
    }

    func testForThreeAndFour() {
        for number in ["3", "4"] {
            let months = VerificationMonths(forPlate: number)
            
            XCTAssertEqual(months.first, .march)
            XCTAssertEqual(months.second, .september)
        }
    }

    func testForFiveAndNSix() {
        for number in ["5", "6"] {
            let months = VerificationMonths(forPlate: number)
            
            XCTAssertEqual(months.first, .january)
            XCTAssertEqual(months.second, .july)
        }
    }

    func testForSevenAndEight() {
        for number in ["7", "8"] {
            let months = VerificationMonths(forPlate: number)
            
            XCTAssertEqual(months.first, .february)
            XCTAssertEqual(months.second, .august)
        }
    }

}
