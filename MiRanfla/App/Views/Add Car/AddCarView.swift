//
//  AddCarView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import SwiftUI

struct AddCarView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: AddCarViewModel
    
    init(viewModel: AddCarViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBackground
                    .ignoresSafeArea()
                
                Form {
                    CarDataSectionView(data: $viewModel.carDataForm)
                    CarSpecsSectionView(data: $viewModel.carSpecsForm)
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
                        Button(action:  viewModel.save) {
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
                // TODO: Create mock dependencies
                AddCarFactory.make()
            }
        }
    }
    
    return AddCarViewWrapper()
}
#endif
