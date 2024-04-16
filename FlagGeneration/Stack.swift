//
//  Stack.swift
//  FlagGeneration
//
//  Created by Daniel Budusan on 16.04.2024.
//

import SwiftUI

@Observable
class Stack: Identifiable, Equatable {
    static func == (lhs: Stack, rhs: Stack) -> Bool {
        lhs.id == rhs.id
    }
    
    var id = UUID()
    var chds = [Stack]()
    var color: Color?
    var type: StackType
    var isCurrent: Bool
    var parent: Stack?
    
    enum StackType {
        case VStack, HStack
    }
    
    init(id: UUID = UUID(), chds: [Stack] = [Stack](), color: Color? = nil, type: StackType, isCurrent: Bool, parent: Stack? = nil) {
        self.id = id
        self.chds = chds
        self.color = color
        self.type = type
        self.isCurrent = isCurrent
        self.parent = parent
    }
}
