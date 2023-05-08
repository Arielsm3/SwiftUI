//
//  ContentView.swift
//  Edutainment
//
//  Created by Ariel David Suarez on 5/6/23.
//

/*
 * This Project is Based on the Challenge from Hacking with SwiftUI - Milestone: Projects 4-6 (Day 35)
 */

import SwiftUI

struct ContentView: View {
    @State private var multiplier = 0
    @State private var multiplicant = Int.random(in: 0...12)
    
    @State private var product = 0
    @State private var productTitle = ""
    
    @State private var answer = ""
    @State private var showingAnswer = false
    
    @State private var numberOfQuestions = 5
    @State private var remainingQuestions = 5
    
    @State private var score = 0
    
    @State private var hasStarted: Bool = false
    
    var body: some View {
        VStack {
            Stepper(value: $numberOfQuestions, in: 5...20, step: 5) {
                Text("\(numberOfQuestions) questions.")
                    .foregroundColor(.red)
                    .font(Font.largeTitle.weight(.bold))
                
            }
            .padding()
            
            Text("Remaining Questions: \(remainingQuestions)")
                .foregroundColor(.red)
                .font(.largeTitle)

            Button {
                remainingQuestions = numberOfQuestions
                hasStarted = true
            } label: {
                Text("Start")
            }
            .alert("Start!", isPresented: $hasStarted) {
                Button("OK", action:{})
            }
            .padding()
            .background(.white)
            
            Spacer()
            VStack {
                VStack {
                    Text("Choose Multiplication Table:")
                        .multilineTextAlignment(.center)
                    Stepper(value: $multiplier, in: 0...12) {
                        Text("Multiplication table: \(multiplier)")
                            .font(.title)
                    }
                    .padding(.horizontal, 30)
                }
                .font(.largeTitle.weight(Font.Weight.bold))
                
                Section {
                    Text("Multiplicant: \(multiplicant)")
                }
                .font(.largeTitle.weight(Font.Weight.bold))
                .multilineTextAlignment(.leading)
                
                HStack {
                    Text("Product:")
                    TextField("Product:", value: $product, format: .number)
                }
                .padding(.horizontal, 30)
                .font(.largeTitle.weight(.bold))
            }
            .multilineTextAlignment(.leading)
            .padding(.vertical)
            .background(.regularMaterial)
            
            
            Spacer()
            
            Button {
                checkAnswer()
            } label: {
                ZStack {
                    Text("Done")
                }
                .frame(width: 1000, height: 100)
                .foregroundColor(.white)
                .background(Color(red: 0.75, green: 0.2, blue: 0.35))
                .border(.gray)
            }
            .alert(productTitle, isPresented: $showingAnswer) {
                if  remainingQuestions > 1 {
                    Button("Next!", action: {
                        tryAgain()
                        remainingQuestions -= 1
                    })
                } else {
                    HStack {
                        //Text("\(productTitle)")
                        Button("Start Again?", action: {
                            restart()
                        })
                    }
                }
            }
            .padding()
        }
        .background(Color(red: 0, green: 0.95, blue: 0.95))
        
    }
    
    func adjustNumberOfRemainingQuestions() {
        remainingQuestions = numberOfQuestions
    }
    
    func checkAnswer() {
            if multiplier * multiplicant == product {
                score += 1
                productTitle = "Correct! Score: \(score)."
            }
            else {
                productTitle = "Wrong! The Answer is \(multiplier * multiplicant)!"
            }
        
        showingAnswer = true
    }
    
    func tryAgain() {
        multiplier = 0
        multiplicant = Int.random(in: 0...9)
    }
    
    func restart() {
        remainingQuestions = numberOfQuestions
        hasStarted = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.dark)
    }
}
