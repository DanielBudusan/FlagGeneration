//
//  ContentView.swift
//  FlagGeneration
//
//  Created by Daniel Budusan on 16.04.2024.
//

import SwiftUI
import SFSymbolsPicker

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    @State private var isPresented = false
    
    var body: some View {
        if let rootStack = viewModel.rootStack {
            StackView(stack: rootStack)
                .frame(width: 350, height: 200)
        } else {
            Color.gray
                .frame(width: 350, height: 200)
        }
        
        HStack {
            Button("Add HStack") {
                viewModel.addStack(type: .HStack)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Add VStack") {
                viewModel.addStack(type: .VStack)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Add Stripe") {
                viewModel.addStripe()
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.rootStack == nil)
        }
        
        HStack {
            Button("Back to previous container") {
                viewModel.backToPreviousConainer()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.currentStack.parent == nil)
            
            ColorPicker("Select color", selection: $viewModel.color)
                .padding()
                .background(.blue.opacity(0.4))
                .frame(width: 180)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
        HStack {
            Button {
                isPresented.toggle()
            } label: {
                Text("Select a symbol")
                Image(systemName: viewModel.icon).font(.title3)
                    .sheet(isPresented: $isPresented, content: {
                        SymbolsPicker(selection: $viewModel.icon, title: "Pick a symbol", autoDismiss: true)
                    })
            }
            .padding()
            .foregroundStyle(.black)
        }
        .background(.blue.opacity(0.4))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        
        Spacer()
        
        Image(uiImage: viewModel.renderedImage)
            .resizable()
            .scaledToFit()
            .frame(width: 150)
        
        HStack {
            Button("Restart") {
                viewModel.restart()
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
            
            Button("Save Flag") {
                viewModel.saveFlag()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
