//
//  AddCarViewModelTests.swift
//  MiRanflaTests
//
//  Created by Uriel Hernandez Gonzalez on 10/09/24.
//

@testable import MiRanfla
import XCTest

final class AddCarViewModelTests: XCTestCase {

    
    var sut: AddCarViewModel!
    var adapter: MockCarAdapter!
    
    override func setUp() {
        super.setUp()
        adapter = MockCarAdapter()
        sut = AddCarViewModel(adapter: adapter)
    }

    override func tearDown() {
        sut = nil
        adapter = nil
        super.tearDown()
    }
    
    func testInitialValues() {
        XCTAssertEqual(sut.carDataForm, .empty)
        XCTAssertEqual(sut.carSpecsForm, .empty)
        XCTAssertFalse(sut.showError)
        XCTAssertTrue(sut.showVerificationRow)
    }

    func testVerificationRowVisibility() {
        // Aguascalientes´s plates don´t need to verify
        sut.carSpecsForm.plateState = .aguascalientes
        XCTAssertFalse(sut.showVerificationRow)
        
        sut.carSpecsForm.plateState = .estadoDeMexico
        XCTAssertTrue(sut.showVerificationRow)
    }
    
    func testSaveWithSuccess() {
        // When
        sut.save()
        
        // Then
        XCTAssertFalse(sut.showError)
    }

    func testSaveWithError() {
        // Given
        adapter.saveResult = .failure(NSError(domain: "com.miranfla.tests", code: 10))
        
        // When
        sut.save()
        
        // Then
        XCTAssertTrue(sut.showError)
    }

}
