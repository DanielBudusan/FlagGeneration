//
//  ContentView.swift
//  FlagGeneration
//
//  Created by Daniel Budusan on 16.04.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var rootStack: Stack?
    @State private var color = Color.blue
    @State private var currentStack = Stack(type: .VStack, isCurrent: false)
    @State private var renderedImage = Image(systemName: "photo")
    
    var body: some View {
        if let rootStack = rootStack {
            StackView(stack: rootStack)
                .frame(width: 350, height: 200)
        } else {
            Color.gray
                .frame(width: 350, height: 200)
        }
        
        HStack {
            Button("Add HStack") {
                if rootStack == nil {
                    rootStack = Stack(type: .HStack, isCurrent: true)
                    if let root = rootStack {
                        currentStack = root
                    }
                } else {
                    let newStack = Stack(type: .HStack, isCurrent: true, parent: currentStack)
                    currentStack.chds.append(newStack)
                    currentStack.isCurrent = false
                    currentStack = newStack
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button("Add VStack") {
                if rootStack == nil {
                    rootStack = Stack(type: .VStack, isCurrent: true)
                    if let root = rootStack {
                        currentStack = root
                    }
                } else {
                    let newStack = Stack(type: .VStack, isCurrent: true, parent: currentStack)
                    currentStack.chds.append(newStack)
                    currentStack.isCurrent = false
                    currentStack = newStack
                }
            }
            .buttonStyle(.borderedProminent)
            
            
            Button("Add Color") {
                currentStack.chds.append(Stack(color: color, type: .HStack, isCurrent: false))
            }
            .buttonStyle(.borderedProminent)
            .disabled(rootStack == nil)
        }
        
        Button("Back to previous container") {
            if let parent = currentStack.parent {
                currentStack.isCurrent = false
                currentStack = parent
                currentStack.isCurrent = true
            }
        }
        .padding()
        .buttonStyle(.borderedProminent)
        .disabled(currentStack.parent == nil)
        
        ColorPicker("Select color", selection: $color)
            .padding()
            .background(.blue.opacity(0.4))
            .frame(width: 200)
            .clipShape(.capsule)
        
        Spacer()
       
        Button("Restart") {
            rootStack = nil
            currentStack = Stack(type: .VStack, isCurrent: false)
        }
        .buttonStyle(.borderedProminent)
    }
    
    
}

#Preview {
    ContentView()
}
