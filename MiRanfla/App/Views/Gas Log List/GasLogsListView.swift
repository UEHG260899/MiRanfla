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

    @State
    private var viewModel: GasLogListViewModel

    init(viewModel: GasLogListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.logs) { gasLog in
                GasLogCellView(presentedScreen: $viewModel.presentedScreen,
                               gasLog: gasLog,
                               onDelete: viewModel.delete(_:))
            }
        }
        .animation(.easeOut, value: viewModel.logs)
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
        .sheet(item: $viewModel.presentedScreen) { screen in
            if case let .edit(log) = screen {
                ViewFactory.make(.editGasLog(log))
            }
        }
    }
}

#if DEBUG
#Preview {
    GasLogsListView(viewModel: .init(logs: UIGasLog.mockLogs,
                                     adapter: PreviewCarAdapter()))
}

#Preview("Inside NavStack") {
    NavigationStack {
        GasLogsListView(viewModel: .init(logs: UIGasLog.mockLogs,
                                         adapter: PreviewCarAdapter()))
    }
}
#endif
