//
//  WanakaTextField.swift
//  Wanaka Tracker Manager
//
//  Created by Marcos Tirao on 20/11/2024.
//

import SwiftUI

struct WanakaTextField: View {
    
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @State private var errorText: String = ""
    let placeholder: String
    let title: String
    
    let validate: ((String) -> Bool)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(title)
                Spacer()
            }
            TextField(placeholder, text: $text)
                .frame(height:20)
                .padding()
                .background {
                    RoundedRectangle(cornerSize: CGSize(width: 8, height: 8))
                        .fill(Color.accentColor.opacity(0.2))
                }
                .focused($isFocused)
                .onChange(of: isFocused) {value, newValue in
                    if value {
                        let val = validate?(text) ?? false
                        errorText = val ? "" : "Invalid input"
                    }
                }
            Text(errorText)
                .font(.subheadline).foregroundColor(Color.red)
        }
    }
}
