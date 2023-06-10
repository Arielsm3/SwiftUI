//
//  ContentView.swift
//  Edutainment
//
//  Created by Ariel David Suarez on 5/6/23.
//

/*
 * This Project is Based on the Challenge from Hacking with SwiftUI - Milestone: Projects 4-6 (Day 35) by Paul Hudson
 */

import SwiftUI

struct ContentView: View {
    
    @State private var multiplier = 2 // Initial value of 2, it is bound to Stepper
    @State private var multiplicant = 1 // Value of multiplicant will be 1 at the beginning of game
    
    @State private var numberOfQuestions = 5
    @State private var remainingQuestions = 5
    @State private var score = 0
    
    @State private var hasStarted: Bool = false // Indicates if game has started or not
    @State private var gameStops: Bool = false // Track whether game has started and trigger stop game alert
        
    @State private var answer: Int = 0 // Represents answer of multiplication
    @State private var answerTitle: String = ""
    @State private var showingAnswer: Bool = false
    
    @State private var correctMessage = ""
    
    @State private var gameLevel = 1
    
    @State private var messageOfQuestion: String = ""
    
    func startGame() {
        hasStarted = true
        gameStops = false
    }
    
    func stopGame() { // Stop game and prompt user for confirmation
        gameStops = true
        hasStarted = false
    }
    
    // struct 'Question' to create variable type with which to populate Array 'questions'
    struct Question {
        let text: String
        var answer: Int
    }
    
    // MARK: Populate questions array with values for its properties, this fuction may need to be turned into a variable
    var assignQuestions: Question {
        
        let level: Int = gameLevel
        var questions: Array<Question> = []
        
        // Level 1: Three different types of questions so far, range: 2...12
        if level < 2 {
            questions.append(Question(text: "What is \(multiplicant) x \(multiplier)?", answer: multiplicant * multiplier))
            
            //questions.append(Question(text: "What is the product of \(multiplierNumber) x \(multiplierNumber)?", answer: multiplierNumber * multiplierNumber))
        }
        
        // Level 2: Consider using 3 variables instead of 2, range: perhaps, extend to higher numbers (e.g. 5...15)?
        if level >= 2 {
            questions.append(Question(text: "How much is \(multiplier) x \(multiplicant)?", answer: multiplier * multiplicant))
        }
        
        // Level 3: Consider using an extra Int variable in order to ask the product of three different numbers
        
        return questions[Int.random(in: 0..<questions.count)] // Return a random element in the array of Questions
    }
    
    
    var body: some View {
        let colorRadient = LinearGradient(gradient: Gradient(colors: [
            Color(red: 0.7, green: 0.7, blue:0.9),
            Color(red: 0, green: 0.7, blue: 0.7),
            Color(red: 0.3, green: 0.5, blue: 0.7),
            Color(red: 0.9, green: 0.3, blue: 0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
        
        VStack {
            Text(hasStarted ? "Stop Game?" : "Start Game?")
                .font(.title.weight(.bold))
                .foregroundColor(.purple)
            
            Spacer()
            
            Text("Remaining questions: \(remainingQuestions)")
                .foregroundColor(.red)
                .font(.largeTitle)
                .opacity(hasStarted ? 1 : 1)
            
            Spacer()
            
            VStack {
                // MARK: Start Game Button
                Button {
                    if !hasStarted {
                        remainingQuestions = numberOfQuestions
                        hasStarted = true
                    }
                    else if hasStarted {
                        stopGame()
                    }
                    
                } label: {
                    Text(hasStarted ? "Stop" : "Start") // if true, game has not started yet
                        .foregroundColor(hasStarted ? .red : .blue)
                }
                .alert("Do you want to stop the game?", isPresented: $gameStops) {
                    // MARK: Ask for confirmation to stop game
                    Button("Yes", action: {
                         // Restart game -> Reset questions to zero
                    })
                    Button("No", action: {
                        // Resume game from where player left off
                        hasStarted = true
                    })
                }
                
                Text(hasStarted ? "Game Started!" : "Press Start!")
                    .font(.largeTitle)
                
                Spacer()
                
                Text(assignQuestions.text)
                    .font(.largeTitle.bold())
                    .foregroundColor(.purple)
                
                Spacer()
                
                // MARK: Promting user for input answer
                HStack {
                    Text("Enter Answer: ")
                        .multilineTextAlignment(.center)
                    TextField("Answer", value: $answer, format: .number)
                        .disabled(!hasStarted) // Disable if game has not started
                }
                .foregroundColor(.white)
                    .font(.largeTitle.weight(Font.Weight.bold))
                    .multilineTextAlignment(.center)
                
                // MARK: Check Answer Button
                Button {
                    checkAnswer()
                } label: {
                    Text("Check")
                        .padding()
                        .font(.largeTitle)
                        .foregroundColor(.red)
                        .background(Color(red:0.85, green: 0.85, blue: 0.85))
                        .opacity(hasStarted ? 1 : 0)
                        
                }
                .disabled(!hasStarted) // Disable check button until game starts
                .alert(answerTitle, isPresented: $showingAnswer) {
                    // Continue, randomly change value of multiplicant according to level
                    if remainingQuestions > 1 {
                        Button("Ok") {
                            
                            if gameLevel == 1 {
                                multiplicant = Int.random(in: 0...12)
                            } else if gameLevel >= 2 {
                                multiplicant = Int.random(in: 5...15)
                            }
                        }
                    } else {
                        HStack {
                            Text("\(answerTitle)")
                            Button("Start again?", action: {
                                restart()
                            })
                        }
                    }
                    
                }
                .padding()
            }
            
            VStack {
                Text("Settings:")
                    .font(.largeTitle)
                Stepper(value: $multiplier, in: 2...12) {
                    Text("Multiply table of: \(multiplier)")
                }
                
                Stepper(value: $numberOfQuestions, in: 5...20, step: 5) {
                    Text("Number of questions: \(numberOfQuestions)")
                }
                
                Stepper(value: $gameLevel, in: 1...3) {
                    Text("Game level: \(gameLevel)")
                }
            }
            .foregroundColor(.white)
            .font(.title)
            .disabled(hasStarted) // Disable Stepper once game starts
            .opacity(hasStarted ? 0 : 1) // Render invisible once game starts

            Spacer()
        }
        .padding()
        .background(colorRadient)
    }
    
    // MARK: Modify so questions.text matches questions.answer from populateQuestions func
    func checkAnswer() {
        if remainingQuestions > 1 {
            // If user input answer is equal to answer of multiplication question
            if answer == assignQuestions.answer {
                score += 1
                answerTitle = "Correct!"
            } else {
                answerTitle = "Wrong! The Answer is \(multiplier * multiplicant)."
            }
            remainingQuestions -= 1
        } else {
            // Last question for this game
            restart()
        }
        showingAnswer = true // Trigger alert
        //multiplicant = Int.random(in: 2...12)
    }
    
    
    
    func restart() {
        // MARK: Function to handle game resets after last question is answered
        remainingQuestions = numberOfQuestions
    }
}

struct Content_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
