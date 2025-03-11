//
//  Models.swift
//  flashly
//
//  Created by minhkhoi mac on 3/1/25.
//

import Foundation
import SwiftUI

/// Deck struct
/// Contains:
/// - id: unique identifier for deck
/// - name: name of deck
/// - cards: cards in deck
/// - colorHex: string of hex color to conform to Codable (Color does not)
class Deck: Codable, Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
    var cards: [Card] = []
    var colorHex: String // Store color as hex

    var color: Color {
        Color(hex: colorHex)
    }
    
    init(name: String, cards: [Card], color: Color = .blue) {
        self.name = name
        self.cards.append(contentsOf: cards)
        self.colorHex = color.toHex()
   }
    
    /// conform to Hashable
    static func == (lhs: Deck, rhs: Deck) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    /// sample deck
    static let example = Deck(name: "Example", cards: [
        Card(question: "to drink", answer: "tomar"),
        Card(question: "to eat", answer: "comer"),
        Card(question: "to sit", answer: "sentar")
    ],
                              color: Color(.red))
}

/// Card struct
/// Contains
/// - id: unique identifier for card
/// - question: what is shown to users
/// - answer: what users must recall
/// - ordering: spaced repetition metric
/// - timesShown: number of times card has been shown
/// - timesCorrect: number of times card has been correctly recalled
class Card: Codable, Identifiable {
    var id: UUID = UUID()
    var question: String
    var answer: String
    var ordering: Double
    var timesShown: Int
    var timesCorrect: Int
    var percentRight: Double {
        if timesShown > 0 {
            return Double(timesCorrect)/Double(timesShown)
        }
        return 100.0
    }
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
        self.ordering = 1.0
        self.timesShown = 0
        self.timesCorrect = 0
    }
    
    static let example = Card(question: "to mix", answer: "mezclar")
}

/// Extension ot color to convert Color to hex string
extension Color {
    func toHex() -> String {
        guard let components = UIColor(self).cgColor.components else { return "#000000" }
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        return String(format: "#%02X%02X%02X", r, g, b)
    }

    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >> 8) & 0xFF) / 255.0
        let b = Double(rgb & 0xFF) / 255.0

        self.init(red: r, green: g, blue: b)
    }
}

/// Data Manager for UserDefaults
class DataManager: ObservableObject {
    @Published var decks: [Deck] = []

    init() {
        loadDecks()
    }

    func loadDecks() {
        if let savedData = UserDefaults.standard.data(forKey: "decks"),
           let decodedDecks = try? JSONDecoder().decode([Deck].self, from: savedData) {
            decks = decodedDecks
        } else {
            createDefaultDeck()
        }
    }

    func saveDecks() {
        if let encoded = try? JSONEncoder().encode(decks) {
            UserDefaults.standard.set(encoded, forKey: "decks")
        }
    }

    /// Sample decks
    private func createDefaultDeck() {
        let defaultDeck = Deck(name: "Spanish Verbs", cards: [
            Card(question: "to open", answer: "abrir"),
            Card(question: "to love", answer: "amar"),
            Card(question: "to walk", answer: "andar"),
            Card(question: "to learn", answer: "aprender"),
            Card(question: "to attend", answer: "asistir"),
            Card(question: "to help", answer: "ayudar"),
            Card(question: "to dance", answer: "bailar"),
            Card(question: "to drink", answer: "beber"),
            Card(question: "to erase", answer: "borrar"),
            Card(question: "to search", answer: "buscar"),
            Card(question: "to change", answer: "cambiar"),
            Card(question: "to sing", answer: "cantar"),
            Card(question: "to eat", answer: "comer"),
            Card(question: "to buy", answer: "comprar"),
            Card(question: "to understand", answer: "comprender"),
            Card(question: "to drive", answer: "conducir"),
            Card(question: "to know (someone)", answer: "conocer"),
            Card(question: "to run", answer: "correr"),
            Card(question: "to sew", answer: "coser"),
            Card(question: "to create", answer: "crear"),
            Card(question: "to grow", answer: "crecer"),
            Card(question: "to believe", answer: "creer"),
            Card(question: "to take care of", answer: "cuidar"),
            Card(question: "to give", answer: "dar"),
            Card(question: "to leave", answer: "dejar"),
            Card(question: "to rest", answer: "descansar"),
            Card(question: "to discover", answer: "descubrir"),
            Card(question: "to desire", answer: "desear"),
            Card(question: "to say", answer: "decir"),
            Card(question: "to wake up", answer: "despertarse"),
            Card(question: "to return", answer: "devolver"),
            Card(question: "to have fun", answer: "divertirse"),
            Card(question: "to sleep", answer: "dormir"),
            Card(question: "to shower", answer: "ducharse"),
            Card(question: "to teach", answer: "enseñar"),
            Card(question: "to understand", answer: "entender"),
            Card(question: "to write", answer: "escribir"),
            Card(question: "to listen", answer: "escuchar"),
            Card(question: "to wait", answer: "esperar"),
            Card(question: "to be (temporary)", answer: "estar"),
            Card(question: "to study", answer: "estudiar"),
            Card(question: "to explain", answer: "explicar"),
            Card(question: "to win", answer: "ganar"),
            Card(question: "to spend (money)", answer: "gastar"),
            Card(question: "to like", answer: "gustar"),
            Card(question: "to speak", answer: "hablar"),
            Card(question: "to do", answer: "hacer"),
            Card(question: "to go", answer: "ir"),
            Card(question: "to play (an instrument)", answer: "tocar"),
            Card(question: "to play (a sport)", answer: "jugar"),
            Card(question: "to wash", answer: "lavar"),
            Card(question: "to get up", answer: "levantarse"),
            Card(question: "to call", answer: "llamar"),
            Card(question: "to arrive", answer: "llegar"),
            Card(question: "to carry", answer: "llevar"),
            Card(question: "to rain", answer: "llover"),
            Card(question: "to look at", answer: "mirar"),
            Card(question: "to send", answer: "mandar"),
            Card(question: "to drive", answer: "manejar"),
            Card(question: "to be born", answer: "nacer"),
            Card(question: "to swim", answer: "nadar"),
            Card(question: "to need", answer: "necesitar"),
            Card(question: "to forget", answer: "olvidar"),
            Card(question: "to hear", answer: "oír"),
            Card(question: "to pay", answer: "pagar"),
            Card(question: "to stop", answer: "parar"),
            Card(question: "to skate", answer: "patinar"),
            Card(question: "to ask for", answer: "pedir"),
            Card(question: "to think", answer: "pensar"),
            Card(question: "to lose", answer: "perder"),
            Card(question: "to forgive", answer: "perdonar"),
            Card(question: "to put", answer: "poner"),
            Card(question: "to practice", answer: "practicar"),
            Card(question: "to prefer", answer: "preferir"),
            Card(question: "to prepare", answer: "preparar"),
            Card(question: "to stay", answer: "quedarse"),
            Card(question: "to want", answer: "querer"),
            Card(question: "to take off", answer: "quitarse"),
            Card(question: "to receive", answer: "recibir"),
            Card(question: "to remember", answer: "recordar"),
            Card(question: "to reduce", answer: "reducir"),
            Card(question: "to laugh", answer: "reír"),
            Card(question: "to repeat", answer: "repetir"),
            Card(question: "to respond", answer: "responder"),
            Card(question: "to break", answer: "romper"),
            Card(question: "to know (something)", answer: "saber"),
            Card(question: "to take out", answer: "sacar"),
            Card(question: "to go out", answer: "salir"),
            Card(question: "to jump", answer: "saltar"),
            Card(question: "to sit down", answer: "sentarse"),
            Card(question: "to feel", answer: "sentir"),
            Card(question: "to be (permanent)", answer: "ser"),
            Card(question: "to serve", answer: "servir"),
            Card(question: "to go up", answer: "subir"),
            Card(question: "to have", answer: "tener"),
            Card(question: "to finish", answer: "terminar"),
            Card(question: "to touch", answer: "tocar"),
            Card(question: "to work", answer: "trabajar"),
            Card(question: "to bring", answer: "traer"),
            Card(question: "to use", answer: "usar"),
            Card(question: "to see", answer: "ver"),
            Card(question: "to travel", answer: "viajar"),
            Card(question: "to live", answer: "vivir"),
            Card(question: "to return", answer: "volver")
        ])
        let defaultDeck2 = Deck(name: "German verbs", cards: [
            Card(question: "to work", answer: "arbeiten"),
            Card(question: "to breathe", answer: "atmen"),
            Card(question: "to bake", answer: "backen"),
            Card(question: "to begin", answer: "beginnen"),
            Card(question: "to get, receive", answer: "bekommen"),
            Card(question: "to order", answer: "bestellen"),
            Card(question: "to visit", answer: "besuchen"),
            Card(question: "to pay", answer: "bezahlen"),
            Card(question: "to stay", answer: "bleiben"),
            Card(question: "to need", answer: "brauchen"),
            Card(question: "to bring", answer: "bringen"),
            Card(question: "to think", answer: "denken"),
            Card(question: "to discuss", answer: "diskutieren"),
            Card(question: "to press", answer: "drücken"),
            Card(question: "to allow", answer: "erlauben"),
            Card(question: "to tell, narrate", answer: "erzählen"),
            Card(question: "to eat", answer: "essen"),
            Card(question: "to drive", answer: "fahren"),
            Card(question: "to fall", answer: "fallen"),
            Card(question: "to catch", answer: "fangen"),
            Card(question: "to find", answer: "finden"),
            Card(question: "to fly", answer: "fliegen"),
            Card(question: "to ask", answer: "fragen"),
            Card(question: "to freeze", answer: "frieren"),
            Card(question: "to give", answer: "geben"),
            Card(question: "to go", answer: "gehen"),
            Card(question: "to belong", answer: "gehören"),
            Card(question: "to win", answer: "gewinnen"),
            Card(question: "to believe", answer: "glauben"),
            Card(question: "to have", answer: "haben"),
            Card(question: "to hold", answer: "halten"),
            Card(question: "to hang", answer: "hängen"),
            Card(question: "to be called", answer: "heißen"),
            Card(question: "to help", answer: "helfen"),
            Card(question: "to hope", answer: "hoffen"),
            Card(question: "to hear", answer: "hören"),
            Card(question: "to buy", answer: "kaufen"),
            Card(question: "to know (a fact)", answer: "wissen"),
            Card(question: "to know (a person)", answer: "kennen"),
            Card(question: "to come", answer: "kommen"),
            Card(question: "to be able to", answer: "können"),
            Card(question: "to cost", answer: "kosten"),
            Card(question: "to laugh", answer: "lachen"),
            Card(question: "to let, allow", answer: "lassen"),
            Card(question: "to run", answer: "laufen"),
            Card(question: "to live", answer: "leben"),
            Card(question: "to learn", answer: "lernen"),
            Card(question: "to love", answer: "lieben"),
            Card(question: "to do, make", answer: "machen"),
            Card(question: "to mean", answer: "meinen"),
            Card(question: "to take", answer: "nehmen"),
            Card(question: "to name", answer: "nennen"),
            Card(question: "to open", answer: "öffnen"),
            Card(question: "to pack", answer: "packen"),
            Card(question: "to happen", answer: "passieren"),
            Card(question: "to plan", answer: "planen"),
            Card(question: "to try", answer: "probieren"),
            Card(question: "to clean", answer: "putzen"),
            Card(question: "to rain", answer: "regnen"),
            Card(question: "to travel", answer: "reisen"),
            Card(question: "to run", answer: "rennen"),
            Card(question: "to smell", answer: "riechen"),
            Card(question: "to call", answer: "rufen"),
            Card(question: "to say", answer: "sagen"),
            Card(question: "to collect", answer: "sammeln"),
            Card(question: "to create", answer: "schaffen"),
            Card(question: "to seem", answer: "scheinen"),
            Card(question: "to shoot", answer: "schießen"),
            Card(question: "to sleep", answer: "schlafen"),
            Card(question: "to beat, hit", answer: "schlagen"),
            Card(question: "to close", answer: "schließen"),
            Card(question: "to cut", answer: "schneiden"),
            Card(question: "to write", answer: "schreiben"),
            Card(question: "to swim", answer: "schwimmen"),
            Card(question: "to see", answer: "sehen"),
            Card(question: "to be", answer: "sein"),
            Card(question: "to sit", answer: "sitzen"),
            Card(question: "to play", answer: "spielen"),
            Card(question: "to speak", answer: "sprechen"),
            Card(question: "to stand", answer: "stehen"),
            Card(question: "to steal", answer: "stehlen"),
            Card(question: "to climb", answer: "steigen"),
            Card(question: "to die", answer: "sterben"),
            Card(question: "to push", answer: "stoßen"),
            Card(question: "to search", answer: "suchen"),
            Card(question: "to dance", answer: "tanzen"),
            Card(question: "to participate", answer: "teilnehmen"),
            Card(question: "to carry, wear", answer: "tragen"),
            Card(question: "to dream", answer: "träumen"),
            Card(question: "to drink", answer: "trinken"),
            Card(question: "to do", answer: "tun"),
            Card(question: "to forget", answer: "vergessen"),
            Card(question: "to compare", answer: "vergleichen"),
            Card(question: "to lose", answer: "verlieren"),
            Card(question: "to understand", answer: "verstehen"),
            Card(question: "to wait", answer: "warten"),
            Card(question: "to become", answer: "werden"),
            Card(question: "to throw", answer: "werfen"),
            Card(question: "to repeat", answer: "wiederholen"),
            Card(question: "to live (somewhere)", answer: "wohnen"),
            Card(question: "to wish", answer: "wünschen"),
            Card(question: "to pull", answer: "ziehen"),
            Card(question: "to force", answer: "zwingen"),
        ])
        decks = [defaultDeck, defaultDeck2]
        saveDecks()
    }
}

