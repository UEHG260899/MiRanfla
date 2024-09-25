//
//  HomeViewModel.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 17/09/24.
//

import Foundation
import SwiftData
import Observation

@Observable
final class HomeViewModel {

    private let adapter: CarAdapting

    var cars = [UICar]()
    var showError = false
    var showAddCarView = false

    init(adapter: any CarAdapting) {
        self.adapter = adapter
    }

    func fetchCars() {
        do {
            let descriptor = FetchDescriptor<Car>(sortBy: [SortDescriptor(\.make)])
            self.cars = try adapter.fetch(with: descriptor)
        } catch {
            showError = true
        }
    }
}
