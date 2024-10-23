//
//  AddGasLogView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 18/10/24.
//

import SwiftUI

struct AddGasLogView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    @State private var date: Date = .now

    var body: some View {
        NavigationStack {
            ZStack {
                Color.customBackground
                    .ignoresSafeArea()

                Form {
                    Section {
                        DatePicker(selection: $date, displayedComponents: .date) {
                            Text("Fecha")
                                .font(.regular, size: .body)
                        }

                        TextField(text: $text) {
                            Text("Costo Total")
                                .font(.regular, size: .body)
                        }
                        .keyboardType(.decimalPad)

                        TextField(text: $text) {
                            Text("Litros cargados")
                                .font(.regular, size: .body)
                        }
                        .keyboardType(.decimalPad)
                        
                        TextField(text: $text) {
                            Text("Kilometros recorridos")
                                .font(.regular, size: .body)
                        }
                        .keyboardType(.numberPad)
                    } header: {
                        Text("Ingresa los siguientes datos")
                            .font(.regular, size: .caption)
                    }

                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                    .tint(.accent)
                }
                ToolbarItem(placement: .principal) {
                    Text("Agregar registro")
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Guardar") {
                    }
                    .tint(.accent)
                }
            }
            .navigationBarTitleDisplayMode(.inline)

        }

    }
}

#if DEBUG
#Preview {
    struct AddGasLogViewWrapper: View {

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
            AddGasLogView()
        }
    }

    return AddGasLogViewWrapper()
}
#endif
