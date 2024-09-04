//
//  CarSpecsSectionView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import SwiftUI

struct CarSpecsSectionView: View {
    
    @State private var test = ""
    @State private var plateState: StateInMexico = .cdmx
    
    var body: some View {
        Section {
            TextField("Kilometraje", text: $test)
                .font(.regular, size: .body)
            
            TextField("Capacidad del tanque", text: $test)
                .font(.regular, size: .body)
            
            Picker(selection: $plateState) {
                ForEach(StateInMexico.allCases, id: \.self) { state in
                    Text(state.rawValue)
                        .font(.regular, size: .body)
                }
            } label: {
                Text("Estado de emplacado")
                    .font(.regular, size: .body)
            }
            .tint(.customPrimary)
            
            Toggle(isOn: .constant(true)) {
                Text("Recibir notificaciones sobre verificaciones.")
            }
            .tint(.customPrimary)

        } header: {
            Text("Características adicionales")
                .font(.regular, size: .caption)
        } footer: {
            Text("Estos datos serán usados para los cálculos de consumo de combustible y algunas notificaciones relacionadas.")
                .font(.regular, size: .caption)
        }
    }
}

#if DEBUG
#Preview {
    Form {
        CarSpecsSectionView()
    }
}
#endif
