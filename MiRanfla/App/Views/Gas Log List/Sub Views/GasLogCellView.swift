//
//  GasLogCellView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 07/11/24.
//

import SwiftUI

struct GasLogCellView: View {

    private let gradient: RadialGradient = RadialGradient(gradient: Gradient(colors: [.customSecondary, .customPrimary]),
                                                          center: .topLeading,
                                                          startRadius: 50,
                                                          endRadius: 100)
    private let cellInsets = EdgeInsets(top: 10,
                                        leading: 0,
                                        bottom: 0,
                                        trailing: 0)

    @Binding var presentedScreen: GasLogListViewModel.PresentedScreen?
    let gasLog: UIGasLog
    let onDelete: (UIGasLog) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(gasLog.formatedDate)
                .font(.regular, size: .body)
                .frame(maxWidth: .infinity, alignment: .trailing)

            HStack {
                leftDataView

                Spacer()

                rightDataView
            }
        }
        .listRowSeparator(.hidden)
        .listRowInsets(cellInsets)
        .padding()
        .background(gradient, in: RoundedRectangle(cornerRadius: 12))
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button {
                onDelete(gasLog)
            } label: {
                Image(systemName: "trash")
            }
            .tint(.red)

            Button {
                presentedScreen = .edit(gasLog)
            } label: {
                Image(systemName: "pencil")
            }
            .tint(.customSecondary)
        }
    }

    private var leftDataView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Precio:")
                    .font(.bold, size: .body)

                Text(gasLog.price, format: .currency(code: "mxn"))
                    .font(.regular, size: .body)
            }

            HStack {
                Text("Litros:")
                    .font(.bold, size: .body)

                Text(gasLog.liters, format: .number)
                    .font(.regular, size: .body)
            }
        }
    }

    private var rightDataView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Kilometros:")
                    .font(.bold, size: .body)

                Text(gasLog.milage, format: .number)
                    .font(.regular, size: .body)
            }

            HStack {
                Text("Consumo:")
                    .font(.bold, size: .body)
                Text(gasLog.consumption, format: .number)
                    .font(.regular, size: .body)
            }
        }
    }
}

#if DEBUG
#Preview {
    GasLogCellView(presentedScreen: .constant(nil),
                   gasLog: .init(date: .distantPast,
                                 price: 100,
                                 liters: 10,
                                 milage: 10)) { _ in }
    .padding(.horizontal)
}
#endif
