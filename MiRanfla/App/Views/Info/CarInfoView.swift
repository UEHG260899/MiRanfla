//
//  CarInfoView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 05/09/24.
//

import SwiftUI
import Charts

struct CarInfoView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: CarInfoViewModel

    init(viewModel: CarInfoViewModel) {
        self._viewModel = State(wrappedValue: viewModel)
    }

    private var gradient: some View {
        RadialGradient(gradient: Gradient(colors: [.customSecondary, .customPrimary]),
                       center: .top,
                       startRadius: 250,
                       endRadius: 500)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .ignoresSafeArea(edges: .bottom)
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
                                Toggle(isOn: $viewModel.uiCar.verificationNotificationsEnabled) {
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

                    GroupBox("Consumo de Gasolina") {
                        VStack(spacing: 16) {
                            Chart(viewModel.uiCar.gasLogs) {
                                LineMark(
                                    x: .value("Month", $0.date),
                                    y: .value("Price", $0.consumption)
                                )
                                .symbol {
                                    Circle()
                                        .fill(Color.text)
                                        .frame(width: 8)
                                }
                                .interpolationMethod(.catmullRom)
                            }
                            .chartYAxisLabel(position: .trailing, alignment: .center, spacing: 0) {
                                Text("Km/Litro")
                                    .font(.medium, size: .footnote)
                            }
                            .padding(.trailing, 4)
                            .animation(.easeOut, value: viewModel.uiCar.gasLogs)

                            Button {
                                viewModel.presentedScreen = .addGasLog
                            } label: {
                                Text("Agregar registro")
                                    .font(.medium, size: .body)
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity)
                            }
                            .background(.customPrimary, in: RoundedRectangle(cornerRadius: 8))
                            .padding(.trailing)
                            .foregroundStyle(Color.text)

                            NavigationLink(value: "") {
                                Text("Ver registros")
                                    .font(.medium, size: .body)
                                    .padding(.vertical, 8)
                                    .frame(maxWidth: .infinity)
                                    .background(.customPrimary, in: RoundedRectangle(cornerRadius: 8))
                                    .padding(.trailing)
                                    .foregroundStyle(Color.text)
                            }
                        }
                    }
                    .groupBoxStyle(.materialized)
                    .padding([.top, .horizontal])
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(gradient)
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

            ToolbarItemGroup(placement: .topBarTrailing) {
                Button {
                    viewModel.showDeletePrompt = true
                } label: {
                    Image(systemName: "trash")
                        .tint(.accent)
                }

                Button {
                    viewModel.presentedScreen = .editCar
                } label: {
                    Image(systemName: "pencil")
                        .tint(.accent)
                }
            }
        }
        .alert("Ocurrió un error al momento de agendar las notificaciones", isPresented: $viewModel.showError) {
            Button("Ok", role: .none, action: {})
        }
        .alert("¿Estas seguro de querer eliminar este auto?", isPresented: $viewModel.showDeletePrompt) {
            Button("Si", role: .destructive) {
                viewModel.deleteCar()

                if !viewModel.showError {
                    dismiss()
                }
            }
            Button("No", role: .cancel, action: {})
        }
        .sheet(item: $viewModel.presentedScreen) {
            viewModel.refreshData()
        } content: { screen in
            switch screen {
            case .editCar:
                EditCarFactory.make(with: viewModel.uiCar)
            case .addGasLog:
                AddGasLogFactory.make(carId: viewModel.uiCar.id)
            }
        }
        .navigationDestination(for: String.self) { _ in
            GasLogsListView()
        }
    }
}

#if DEBUG
#Preview("Normal") {
    CarInfoView(viewModel: .init(uiCar: .previewCar,
                                 adapter: CarAdapter(),
                                 notificationsManager: NotificationsManager()))
}

#Preview("Inside NavStack") {
    NavigationStack {
        ZStack {
            Color.customBackground
                .ignoresSafeArea()

            CarInfoView(viewModel: .init(uiCar: .previewCar,
                                         adapter: CarAdapter(),
                                         notificationsManager: NotificationsManager()))
        }
    }
}
#endif
