//
//  ContentView.swift
//  StackingUpButtons
//

/*
 * Based on the Hacking with Swift project GuessTheFlag by Paul Hudson
 * with some minor modifications.
 */

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var finalScoreTitle: String = ""
    @State private var showingFinalScore: Bool = false
    
    @State private var countries = ["Russia", "Nigeria", "Poland", "Spain", "Estonia", "France", "Germany", "Ireland", "Italy", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
        
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: .yellow, location: 0.5),
                .init(color: .black, location: 0.5),
            ], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 15) {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of:")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.primary)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.secondary)
                    }
                    .padding()
                    ScrollView {
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                                
                            } label: {
                                FlagImage(countries: countries, number: number)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    .padding()
                    
                    HStack {
                        Button("Reshuffle", action: {
                            reshuffle()
                        })
                        Button("New Game", action: {
                            newGame()
                        })
                        .foregroundColor(.red)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .background(.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(score)") // "Score ???"
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert(finalScoreTitle, isPresented: $showingFinalScore) {
            Button("New Game", action: newGame)
        }
        
    }
       
    func flagTapped(_ number: Int) {
        if score < 8 { // Score: 8 will be reached right after it marks 7
            if number == correctAnswer {
                scoreTitle = "Correct"
                score += 1
            }
            else {
                scoreTitle = "Wrong! That's the flag of \(countries[number])"
                score -= 1
            }
            
            showingScore = true
        }
        else {
            showingFinalScore = true
            finalScoreTitle = "Congratulations! Your score is \(score)"
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reshuffle() {
        countries.shuffle()
        if !countries.contains(correctAnswer.description) {
            countries.shuffle()
        }
    }
    
    func newGame() {
        score = 0 // Reset score to 0
        countries.shuffle()
    }
    
}

struct FlagImage: View {
    var countries: Array<String>
    var number: Int
    
    var body: some View {
        Image(countries[number])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
