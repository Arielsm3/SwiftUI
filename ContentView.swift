
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    var theme: Theme
    
    
    
    var body: some View {
        let cards = viewModel.cards
        
        let color: Color = EmojiMemoryGame.chosenColorOfTheme()
        
        let crimson = Color(red: 0.863, green: 0.078, blue: 0.235)
        
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                    }
                    
                        
                }
            }
            .foregroundColor(color) // MARK: Color displayed by cards
            .padding()
        }
    }
    
    
    
    // MARK: Button that initiates reset() fuction to reset game
//    var reset: some View {
//        Button( action: {
//            // MARK: function to reset game needed
//            EmojiMemoryGame.resetMemoryGame()
//        }, label: {
//            VStack {
//                Image(systemName: "arrowshape.turn.up.left.cicle")
//                Text("Reset")
//            }
//
//        })
//    }
    
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    let shape = RoundedRectangle(cornerRadius: 10)
    
    var body: some View {
        ZStack {
            //let shape = RoundedRectangle(cornerRadius: 10)
            
            if card.isFaceUp {
                faceUpCard
            }
            else if card.isMatched {
                faceUpCard.opacity(0.35)
                //shape.opacity(0.5)
            }
            else {
                shape.fill()
            }
        }
    }
    
    var faceUpCard: some View {
        ZStack {
            shape.fill().foregroundColor(.white)
            shape.strokeBorder(lineWidth: 3)
            Text(card.content).font(.largeTitle)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        let viewTheme = EmojiMemoryGame.randomTheme
        
        ContentView(viewModel: game, theme: viewTheme)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game, theme: viewTheme)
            .preferredColorScheme(.light)
    }
}
