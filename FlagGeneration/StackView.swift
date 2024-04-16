//
//  StackView.swift
//  FlagGeneration
//
//  Created by Daniel Budusan on 16.04.2024.
//

import SwiftUI

struct StackView: View {
    var stack: Stack
    
    var body: some View {
        switch stack.type {
        case .VStack:
            VStack(spacing: 0) {
                if let color = stack.color {
                    color
                } else if  !stack.chds.isEmpty {
                    ForEach(stack.chds) { chd in
                        StackView(stack: chd)
                    }
                } else {
                    Color.gray.opacity(0.3)
                    Color.gray
                    Color.gray.opacity(0.3)
                }
            }
            .border(Color.red, width: stack.isCurrent ? 4 : 0)
        case .HStack:
            HStack(spacing: 0) {
                if let color = stack.color {
                    color
                } else if  !stack.chds.isEmpty {
                    ForEach(stack.chds) { chd in
                        StackView(stack: chd)
                    }
                } else {
                    Color.gray.opacity(0.3)
                    Color.gray
                    Color.gray.opacity(0.3)
                }
            }
            .border(Color.red, width: stack.isCurrent ? 4 : 0)
        }
    }
}

#Preview {
    StackView(stack: Stack(type: .HStack, isCurrent: false))
}
