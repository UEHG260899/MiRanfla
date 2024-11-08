//
//  GasLogsListView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 06/11/24.
//

import SwiftUI

struct GasLogsListView: View {

    @Environment(\.dismiss)
    private var dismiss

    let gasLogs: [UIGasLog] = [
        .init(date: .distantPast,
              price: 100,
              liters: 10,
              milage: 10),
        .init(date: Calendar.current.date(byAdding: .init(month: -1), to: .now) ?? .now,
              price: 10,
              liters: 10,
              milage: 200),
        .init(date: Calendar.current.date(byAdding: .init(month: -2), to: .now) ?? .now,
              price: 120,
              liters: 10,
              milage: 10)
    ]

    var body: some View {
        List {
            ForEach(gasLogs) { gasLog in
                GasLogCellView(gasLog: gasLog)
            }
        }
        .padding(.horizontal, 12)
        .listStyle(.plain)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .tint(.accent)
                }
            }

            ToolbarItem(placement: .principal) {
                Text("Registros")
                    .font(.semibold, size: .body)
            }
        }
    }
}

#if DEBUG
#Preview {
    GasLogsListView()
}

#Preview("Inside NavStack") {
    NavigationStack {
        GasLogsListView()
    }
}
#endif
