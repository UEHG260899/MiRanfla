//
//  CarDataSectionView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 02/09/24.
//

import SwiftUI

struct CarDataSectionView: View {

    @Binding var data: CarDataFormModel

    var body: some View {
        Section {
            TextField("Marca", text: $data.make)
                .keyboardType(.default)
                .font(.regular, size: .body)

            TextField("Modelo (ej. Corolla)", text: $data.model)
                .keyboardType(.default)
                .font(.regular, size: .body)

            TextField("Año", text: $data.year)
                .keyboardType(.numberPad)
                .font(.regular, size: .body)

            TextField("Terminación de la placa", text: $data.lastPlateNumber)
                .keyboardType(.numberPad)
                .font(.regular, size: .body)
        } header: {
            Text("Datos del vehículo")
                .font(.regular, size: .caption)
        }
    }
}

#if DEBUG
#Preview {
    Form {
        CarDataSectionView(data: .constant(.empty))
    }
}
#endif
