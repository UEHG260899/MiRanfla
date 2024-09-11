//
//  CarSpecsSectionView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import SwiftUI

struct CarSpecsSectionView: View {
    
    @Binding var data: CarSpecsFormModel
    let showVerificationRow: Bool
    
    var body: some View {
        Section {
            TextField("Kilometraje", text: $data.milage)
                .font(.regular, size: .body)
            
            TextField("Capacidad del tanque", text: $data.tankCapacity)
                .font(.regular, size: .body)
            
            Picker(selection: $data.plateState) {
                ForEach(UIStateInMexico.allCases, id: \.self) { state in
                    Text(state.rawValue)
                        .font(.regular, size: .body)
                }
            } label: {
                Text("Estado de emplacado")
                    .font(.regular, size: .body)
            }
            .tint(.customPrimary)
            
            if showVerificationRow {
                Toggle(isOn: $data.verificationNotifications) {
                    Text("Recibir notificaciones sobre verificaciones.")
                }
                .tint(.customPrimary)
            }

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
        CarSpecsSectionView(data: .constant(.empty), showVerificationRow: true)
    }
}
#endif
