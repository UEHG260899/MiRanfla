//
//  EditGasLogView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 14/11/24.
//

import SwiftUI

struct EditGasLogView: View {

    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.carId)
    private var carId

    @State
    private var viewModel: EditGasLogViewModel

    init(viewModel: EditGasLogViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBackground
                    .ignoresSafeArea()

                Form {
                    Section {
                        DatePicker(selection: $viewModel.formData.date, in: ...Date(), displayedComponents: .date) {
                            Text("Fecha")
                                .font(.regular, size: .body)
                        }

                        TextField(text: $viewModel.formData.price) {
                            Text("Costo Total")
                                .font(.regular, size: .body)
                        }
                        .keyboardType(.decimalPad)

                        TextField(text: $viewModel.formData.liters) {
                            Text("Litros cargados")
                                .font(.regular, size: .body)
                        }
                        .keyboardType(.decimalPad)

                        TextField(text: $viewModel.formData.milage) {
                            Text("Kilometros recorridos")
                                .font(.regular, size: .body)
                        }
                        .keyboardType(.numberPad)
                    } header: {
                        Text("Ingresa los siguientes datos")
                            .font(.regular, size: .caption)
                    }

                }
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancelar")
                                .font(.regular, size: .body)
                        }
                        .tint(.accent)
                    }

                    ToolbarItem(placement: .principal) {
                        Text("Editar registro")
                            .font(.semibold, size: .body)
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.save(with: carId)
                            
                            if !viewModel.showError {
                                dismiss()
                            }
                        } label: {
                            Text("Guardar")
                                .font(.regular, size: .body)
                        }
                        .tint(.accent)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    @Previewable @State var isShown = true

    Text("Hola")
        .sheet(isPresented: $isShown) {
            EditGasLogView(viewModel: .init(log: .empty,
                                            adapter: PreviewCarAdapter()))
        }
}
