//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Shaun Heffernan on 1/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var rounds = 1
    @State private var showingGameOver = false
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack{
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 7)
                        }
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical,20)
                .background(.regularMaterial)
                .cornerRadius(15)
                
                Spacer()
                Spacer()
                Text(String("Score: \(userScore)"))
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Text("Round \(rounds)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Score: \(userScore)")
            
        }
        .alert("Game is Over", isPresented: $showingGameOver){
            Button("Continue", action: gameOver)
        } message: {
            Text("Score: \(userScore)")
            Text("Rounds played \(rounds)")
            
        }
        
        
    }
    func gameOver(){
        rounds = 0
        userScore = 0
        askQuestion()
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            userScore+=1
        }
        else{
            scoreTitle  = "Wrong, thats the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion() {
        if(rounds < 8){
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            rounds+=1
        }
        else{
            showingGameOver = true
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
