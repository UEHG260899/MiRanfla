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
            ScrollView {
                VStack {
                    HStack {
                        Text("VW")
                        Text("Vento")
                    }
                    .font(.bold, size: .title)
                    
                    Text("2015")
                        .font(.regular, size: .body)
                    
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Button(action: {}) {
                        Text("Seleccionar otro")
                            .font(.semibold, size: .body)
                    }
                    .foregroundStyle(.accent)
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "pencil")
                    }
                    .foregroundStyle(.accent)
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                    .foregroundStyle(.accent)
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
