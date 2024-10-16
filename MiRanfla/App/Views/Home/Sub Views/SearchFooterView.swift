//
//  SearchFooterView.swift
//  MiRanfla
//
//  Created by Uriel Hernandez Gonzalez on 14/10/24.
//

import SwiftUI

struct SearchFooterView: View {

    @Binding var query: String
    let action: () -> Void

    var body: some View {
        Group {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")

                    TextField("Buscar", text: $query)
                        .keyboardType(.default)
                        .autocorrectionDisabled()
                        .font(.regular, size: .body)
                }
                .padding(8)
                .background(.cardBackground, in: RoundedRectangle(cornerRadius: 12))

                Button(action: action) {
                    Image(systemName: "plus")
                }
            }
            .padding([.horizontal, .top])
        }
        .background(.ultraThinMaterial)
    }
}

#Preview {
    SearchFooterView(query: .constant(""), action: {})
}
