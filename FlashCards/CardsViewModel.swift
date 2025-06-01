//
//  CardsViewModel.swift
//  FlashCards
//
//  Created by ialbuquerque on 12/05/2025.
//

import Foundation
import NetworkLayerSPM

enum CardsURLS: String, NetworkLayerURLBuilder {
    case cards = "https://raw.githubusercontent.com/intiMRA/FlashCards/refs/heads/main/FlashCards/cards.json"
    func url() -> URL? {
        URL(string: self.rawValue)
    }
}

@Observable
class CardsViewModel {
    var cards: [FlashCardModel] = []
    var currentIndex: Int = 0
    
    var isValidIndex: Bool {
        cards.count > 0
    }
    
    func next() {
        guard currentIndex + 1 < cards.count else {
            return
        }
        
        currentIndex += 1
    }
    
    func perv() {
        guard currentIndex - 1 >= 0 else {
            return
        }
        
        currentIndex -= 1
    }
    
    func fetch() async {
        cards = (try? await NetworkLayer.defaultNetworkLayer.request(.init(urlBuilder: CardsURLS.cards, httpMethod: .GET))) ?? []
    }
}
