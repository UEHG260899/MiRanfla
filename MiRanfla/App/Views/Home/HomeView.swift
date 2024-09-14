//
//  HomeView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 03/09/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible(minimum: 120, maximum: .infinity), spacing: 10), GridItem(.flexible(minimum: 120, maximum: .infinity))], spacing: 10) {
                        NavigationLink(value: "") {
                            HomeCellView(size: (proxy.size.width / 2) - 10 - 12)
                        }
                        HomeCellView(size: (proxy.size.width / 2) - 10 - 12)
                        HomeCellView(size: (proxy.size.width / 2) - 10 - 12)
                        HomeCellView(size: (proxy.size.width / 2) - 10 - 12)
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
                        Button(action: {}) {
                            Image(systemName: "plus")
                        }
                        .foregroundStyle(.accent)
                    }
                    
                }
                .navigationDestination(for: String.self) { _ in
                    CarInfoView()
                }
            }
        }
    }
}

#if DEBUG
#Preview("Normal") {
    HomeView()
}


#Preview("With navigation") {
    NavigationStack {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            HomeView()
        }
    }
}
#endif