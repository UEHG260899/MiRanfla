//
//  AddCarView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import SwiftUI

struct AddCarView: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBackground
                    .ignoresSafeArea()
                
                Form {
                    CarDataSectionView()
                    CarSpecsSectionView()
                }
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: { dismiss() }) {
                            Text("Cancelar")
                                .font(.regular, size: .body)
                        }
                        .foregroundStyle(.accent)
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text("Agregar auto")
                            .font(.semibold, size: .body)
                    }
                    
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: { dismiss() }) {
                            Text("Guardar")
                                .font(.regular, size: .body)
                        }
                        .foregroundStyle(.accent)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    struct AddCarViewWrapper: View {
        
        @State private var showSheet = true
        
        var body: some View {
            Button("Press me") {
                showSheet = true
            }
            .sheet(isPresented: $showSheet) {
                AddCarView()
            }
        }
    }
    
    return AddCarViewWrapper()
}
#endif
