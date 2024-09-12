//
//  RootView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 29/08/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var viewModel: RootViewModel
    
    init(viewModel: RootViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            switch viewModel.screenToShow {
            case .noCar:
                NoCarsView()
            case .home:
                HomeView()
            }
        }
    }
}

#if DEBUG
#Preview {
    RootView(viewModel: RootViewModel(adapter: CarAdapter()))
}
#endif
