//
//  CarInfoView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 05/09/24.
//

import SwiftUI

struct CarInfoView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: CarInfoViewModel
    
    init(viewModel: CarInfoViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.uiCar.make)
                Text(viewModel.uiCar.model)
            }
            .font(.bold, size: .title)
            
            Text(viewModel.uiCar.year)
                .font(.regular, size: .body)
            
            VStack {
                ScrollView(showsIndicators: false) {
                    GroupBox("Datos del vehículo.") {
                        HStack {
                            Text("Terminación de la placa:")
                                .font(.semibold, size: .body)
                            Text(viewModel.uiCar.lastPlateNumber)
                                .font(.regular, size: .body)
                        }
                    }
                    .groupBoxStyle(.materialized)
                    .padding([.top, .horizontal])
                    
                    GroupBox("Características adicionales.") {
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Kilometraje:")
                                    .font(.semibold, size: .body)
                                Text(viewModel.uiCar.formatedMilage)
                                    .font(.regular, size: .body)
                            }
                            
                            Divider()
                                .padding(.trailing)
                            HStack {
                                Text("Capacidad del tanque:")
                                    .font(.semibold, size: .body)
                                Text("\(viewModel.uiCar.tankCapacity) lt")
                                    .font(.regular, size: .body)
                            }
                            Divider()
                                .padding(.trailing)
                            HStack {
                                Text("Estado de emplacado:")
                                    .font(.semibold, size: .body)
                                Text(viewModel.uiCar.plateState.rawValue.capitalized)
                                    .font(.regular, size: .body)
                            }
                            
                            if viewModel.shouldShowNotificationsRow {
                                Divider()
                                    .padding(.trailing)
                                Toggle(isOn: $viewModel.uiCar.verificationNotificationsEnabled){
                                    Text("Recibir notificaciones sobre verificaciones.")
                                        .font(.semibold, size: .body)
                                }
                                .padding(.trailing)
                                .tint(.customPrimary)
                            }
                        }
                    }
                    .groupBoxStyle(.materialized)
                    .padding([.top, .horizontal])
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                RadialGradient(gradient: Gradient(colors: [.customSecondary, .customPrimary]), center: .top, startRadius: 250, endRadius: 500)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .ignoresSafeArea(edges: .bottom)
            }
            .shadow(radius: 10, y: 10)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: dismiss.callAsFunction) {
                    Image(systemName: "arrow.left")
                        .tint(.accent)
                }
            }
        }
        .alert("Ocurrió un error al momento de agendar las notificaciones", isPresented: $viewModel.showError) {
            Button("Ok", role: .none, action: {})
        }
    }
}

#if DEBUG
#Preview("Normal") {
    CarInfoView(viewModel: .init(uiCar: .previewCar, adapter: CarAdapter(), notificationsManager: NotificationsManager()))
}

#Preview("Inside NavStack") {
    NavigationStack {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()
            
            CarInfoView(viewModel: .init(uiCar: .previewCar, adapter: CarAdapter(), notificationsManager: NotificationsManager()))
        }
    }
}
#endif
