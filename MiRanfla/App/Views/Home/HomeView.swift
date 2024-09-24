//
//  HomeView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 03/09/24.
//

import SwiftUI

struct HomeView: View {

    @State private var viewModel: HomeViewModel

    private var columnItems: [GridItem] {
        [
            GridItem(.flexible(minimum: 120, maximum: .infinity), spacing: 10),
            GridItem(.flexible(minimum: 120, maximum: .infinity))
        ]
    }

    init(viewModel: HomeViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ScrollView {
                    LazyVGrid(columns: columnItems, spacing: 10) {
                        ForEach(viewModel.cars, id: \.id) { car in
                            NavigationLink(value: car) {
                                HomeCellView(carMake: car.make,
                                             carModel: car.model,
                                             size: (proxy.size.width / 2) - 10 - 12)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {

                    ToolbarItem(placement: .principal) {
                        Text("Tus autos")
                            .font(.bold, size: .body)
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                        } label: {
                            Image(systemName: "plus")
                        }
                        .foregroundStyle(.accent)
                    }

                }
                .navigationDestination(for: UICar.self) { car in
                    CarInfoFactory.make(with: car)
                }
            }
        }
        .onAppear {
            viewModel.fetchCars()
        }
    }
}

#if DEBUG
#Preview("Normal") {
    HomeView(viewModel: .init(adapter: CarAdapter()))
}

#Preview("With navigation") {
    NavigationStack {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()

            HomeView(viewModel: .init(adapter: CarAdapter()))
        }
    }
}
#endif
