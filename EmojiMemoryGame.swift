import SwiftUI


class EmojiMemoryGame: ObservableObject {

    //MARK: Emoji Arrays
    static let vehicles: Array<String> = ["✈️", "🚀", "🚁", "🛺", "🚖", "🚅", "🛩️", "⛵️", "🚠", "🚔", "🚛", "🏎️", "🚒", "🛻", "🛫", "⛴️", "🚲", "🚎", "🚜", "🏍️", "🚃", "🚆", "🛸", "🛶"]
    static let sports: Array<String> = ["⚽️", "🎾", "🏓", "🏀", "⚾️", "🏈", "🏒", "🏑", "🏂", "🏄", "🤺", "🏋️", "🥋"]
    static let animals: Array<String> = ["🐕", "🐈", "🐅", "🦍", "🦁", "🐒", "🐍", "🐢", "🦒", "🦉", "🐳", "🦈", "🐘", "🐝", "🐺", "🦘", "🦞", "🦇", "🦭", "🦌"]
    static let elements: Array<String> = ["🔥", "❄️", "⚡️", "💧", "🌪️", "🪨", "🌑", "✨"]
    
    static var currentThemeArray: Array<String> = []
    
    // MARK: Hook themed arrays up to their proper Theme structs to be displayed
    static let vehiclesTheme = Theme(name: "vehicles", emojis: vehicles.shuffled(), numberOfPairsOfCardsToShow: Int.random(in: 4..<vehicles.count), color: "red")
    static let sportsTheme = Theme(name: "sports", emojis: sports, numberOfPairsOfCardsToShow: Int.random(in: 4..<sports.count), color: "orange")
    static let animalsTheme = Theme(name: "animals", emojis: animals, numberOfPairsOfCardsToShow: Int.random(in: 4..<animals.count), color: "blue")
    static let elementsTheme = Theme(name: "elements", emojis: elements, numberOfPairsOfCardsToShow: Int.random(in: 4..<elements.count), color: "purple")
    

    static var randomTheme: Theme = randomThemeSelector()
    
    //Theme(name: "vehicles", emojis: vehicles, numberOfPairsOfCardsToShow: Int.random(in: 4..<8),color: "red")
    
    static func createMemoryGame() -> MemoryGame<String> {
        
        return MemoryGame<String>(numberOfPairsOfCards: randomTheme.numberOfPairsOfCardsToShow) { pairIndex in
            randomTheme.emojis[pairIndex] // return the set emojis assigned to randomTheme, and go through each pair

        }
    }
    
    static func chosenColorOfTheme() -> Color {
        switch randomTheme.color {
        case "red":
            return Color.red
        case "orange":
            return Color.orange
        case "blue":
            return Color.blue
        case "purple":
            return Color.purple
        default:
            return Color.teal
        }
    }
    
    // MARK: reset() function to reset game
//    static func resetMemoryGame() {
//        createMemoryGame()
//    }
    
    static func randomThemeSelector() -> Theme {
        let selector = Int.random(in: 1...4)
        
        switch selector {
        case 1:
            return vehiclesTheme
        case 2:
            return sportsTheme
        case 3:
            return animalsTheme
        default:
            return elementsTheme
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
     
}
