//
//  HomeView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 03/09/24.
//

import SwiftUI

struct HomeView: View {

    @State private var viewModel: HomeViewModel
    @State var text = ""

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
                        ForEach(viewModel.filteredCars, id: \.id) { car in
                            NavigationLink(value: car) {
                                HomeCellView(carMake: car.make,
                                             carModel: car.model,
                                             size: (proxy.size.width / 2) - 10 - 12)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .animation(.bouncy, value: viewModel.filteredCars)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Tus autos")
                            .font(.bold, size: .body)
                    }
                }
                .navigationDestination(for: UICar.self) { car in
                    CarInfoFactory.make(with: car)
                }
                .safeAreaInset(edge: .bottom) {
                    SearchFooterView(query: $viewModel.searchQuery) {
                        viewModel.showAddCarView = true
                    }
                }
            }
            .onAppear {
                viewModel.fetchCars()
            }
        }
        .sheet(isPresented: $viewModel.showAddCarView) {
            viewModel.fetchCars()
        } content: {
            AddCarFactory.make()
        }
    }
}

#if DEBUG
#Preview("Normal") {
    HomeView(viewModel: .init(adapter: PreviewCarAdapter()))
}

#Preview("With navigation") {
    NavigationStack {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()

            HomeView(viewModel: .init(adapter: PreviewCarAdapter()))
        }
    }
}
#endif
