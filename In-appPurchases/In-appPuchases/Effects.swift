//
//  Effects.swift
//  In-appPuchases
//
//  Created by Diego Andrés Ramón Sanchís on 17/11/23.
//

import Foundation
import StoreKit

enum Effects: CaseIterable {
    case poker, numberOnWrittenCard, stopCard, guessing, cardOnNumber, doubleCardOnNumber


    var id: String {
        switch self {
        case .poker:
            return ".poker"
        case .numberOnWrittenCard:
            return ".numberOnWrittenCard"
        case .stopCard:
            return ".stopCard"
        case .guessing:
            return ".guessing"
        case .cardOnNumber:
            return ".cardOnNumber"
        case .doubleCardOnNumber:
            return ".doubleCardOnNumber"
        }
    }

    var title: String {
        switch self {
        case .poker:
            return "Poker"
        case .numberOnWrittenCard:
            return "NumberOnWrittenCard"
        case .stopCard:
            return "StopCard"
        case .guessing:
            return "Guessing"
        case .cardOnNumber:
            return "CardOnNumber"
        case .doubleCardOnNumber:
            return "DoubleCardOnNumber"
        }
    }
}
