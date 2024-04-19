//
//  ContentVIew-ViewModel.swift
//  FlagGeneration
//
//  Created by Daniel Budusan on 19.04.2024.
//

import Foundation
import SwiftUI

@Observable
class ContentViewModel {
    var rootStack: Stack?
    var color = Color.yellow
    var currentStack = Stack(type: .VStack, isCurrent: false)
    var renderedImage = UIImage()
    var icon = ""
    
    let displayScale: CGFloat = UIScreen.main.scale
    
    func addStack(type: Stack.StackType) {
        if rootStack == nil {
            rootStack = Stack(type: type, isCurrent: true)
            if let root = rootStack {
                currentStack = root
            }
        } else {
            let newStack = Stack(type: type, isCurrent: true, parent: currentStack)
            currentStack.chds.append(newStack)
            currentStack.isCurrent = false
            currentStack = newStack
        }
    }
    
    func addStripe() {
        currentStack.chds.append(Stack(color: color, type: .HStack, isCurrent: false, symbolName: icon))
        icon = ""
    }
    
    func backToPreviousConainer() {
        if let parent = currentStack.parent {
            currentStack.isCurrent = false
            currentStack = parent
            currentStack.isCurrent = true
        }
    }
    
    func restart() {
        rootStack = nil
        currentStack = Stack(type: .VStack, isCurrent: false)
        renderedImage = UIImage()
        icon = ""
    }
    
    @MainActor func saveFlag() {
        render()
        UIImageWriteToSavedPhotosAlbum(renderedImage, nil, nil, nil)
    }
    
    @MainActor func render() {
        if let root = rootStack {
            let renderer = ImageRenderer(content: StackView(stack: root).frame(width: 350, height: 200))
            
            renderer.scale = displayScale
            
            if let uiImage = renderer.uiImage {
                renderedImage = uiImage
            }
        }
    }
}
