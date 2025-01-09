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
    private let notificationPoster: NotificationsPosting

    var cars = [UICar]()
    var filteredCars = [UICar]()
    var searchQuery = "" {
        didSet {
            filterResults(query: searchQuery)
        }
    }
    var showError = false
    var showAddCarView = false

    init(adapter: any CarAdapting, notificationsPoster: any NotificationsPosting = NotificationCenter.default) {
        self.adapter = adapter
        self.notificationPoster = notificationsPoster
    }

    func fetchCars() {
        do {
            let descriptor = FetchDescriptor<Car>(sortBy: [SortDescriptor(\.make)])
            self.cars = try adapter.fetch(with: descriptor)

            if cars.count == 0 {
                notificationPoster.post(name: .allCarsDeletedNotification, object: nil)
                return
            }

            self.filteredCars = cars
        } catch {
            showError = true
        }
    }

    private func filterResults(query: String) {
        guard !query.isEmpty else {
            filteredCars = cars
            return
        }

        filteredCars = cars.filter { $0.make.lowercased().contains(searchQuery.lowercased()) }
    }
}
