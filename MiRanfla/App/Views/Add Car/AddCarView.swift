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
                    CarSpecsSectionView(data: $viewModel.carSpecsForm,
                                        showVerificationRow: viewModel.showVerificationRow)
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
                            Task {
                                await viewModel.save()
                                dismiss()
                            }
                        } label: {
                            Text("Guardar")
                                .font(.regular, size: .body)
                        }
                        .foregroundStyle(.accent)
                    }
                }
            }
            .alert("Ocurrió un error al momento de agregar el auto", isPresented: $viewModel.showError) {
                Button("Ok", role: .none, action: {})
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
                makeView()
            }
        }

        private func makeView() -> some View {
            let adapter = PreviewCarAdapter()
            let viewModel = AddCarViewModel(adapter: adapter, notificationsManager: NotificationsManager())
            return AddCarView(viewModel: viewModel)
        }
    }

    return AddCarViewWrapper()
}
#endif
