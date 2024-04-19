//
//  StackView.swift
//  FlagGeneration
//
//  Created by Daniel Budusan on 16.04.2024.
//

import SwiftUI

struct StackView: View {
    var stack: Stack
    
    @ViewBuilder var stackContent: some View {
        if let color = stack.color {
            ZStack {
                color
                if let symbolName = stack.symbolName {
                    Image(systemName: symbolName).font(.largeTitle)
                }
            }
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
    
    var body: some View {
        switch stack.type {
        case .VStack:
            VStack(spacing: 0) {
                stackContent
            }
            .border(Color.red, width: stack.isCurrent ? 4 : 0)
        case .HStack:
            HStack(spacing: 0) {
                stackContent
            }
            .border(Color.red, width: stack.isCurrent ? 4 : 0)
        }
    }
}

#Preview {
    StackView(stack: Stack(color: .red, type: .VStack, isCurrent: false, symbolName: "star.fill"))
}
