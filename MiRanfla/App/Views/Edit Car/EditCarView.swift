//
//  EditCarView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 27/09/24.
//

import SwiftUI

struct EditCarView: View {

    @Environment(\.dismiss) var dismiss
    @State private var viewModel: EditCarViewModel

    init(viewModel: EditCarViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBackground
                    .ignoresSafeArea()

                Form {
                    CarDataSectionView(data: $viewModel.carDataForm)
                    CarSpecsSectionView(data: $viewModel.carSpecsForm,
                                        showVerificationRow: false)
                }
                .scrollContentBackground(.hidden)
                .toolbar {

                    ToolbarItem(placement: .cancellationAction) {
                        Button {
                            dismiss()
                        } label: {
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
                        Button {
                            viewModel.save()
                            dismiss()
                        } label: {
                            Text("Guardar")
                                .font(.regular, size: .body)
                        }
                        .foregroundStyle(.accent)
                    }

                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert("Ocurrió un error al momento de agregar el auto", isPresented: $viewModel.showError) {
                Button("Ok", role: .none, action: {})
            }
        }
    }
}

#Preview {
    EditCarView(viewModel: .init(car: .previewCar,
                                 adapter: PreviewCarAdapter()))
}
