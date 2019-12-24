//
//  ContentView.swift
//  FlagGuessingGame
//
//  Created by Alexander Römer on 21.12.19.
//  Copyright © 2019 Alexander Römer. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries                   = ["Germany", "Russia", "USA", "China", "Switzerland"].shuffled()
    @State private var correctAnswer               = Int.random(in: 0...2)
    @State private var score                       = 0
    @State private var alertTitle                  = ""
    @State private var showingAlert                = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                ForEach(0...2, id: \.self) { number in
                    Image(self.countries[number]).resizable().scaledToFit().frame(width: 200, height: 200).onTapGesture {
                        self.flagTapped(number)
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text(countries[correctAnswer].uppercased()))
            .alert(isPresented: $showingAlert ) {
                Alert(title: Text(alertTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("OK")) {
                    self.askQuestion()
                    })
            }
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ tag: Int) {
        if tag == correctAnswer {
            score += 1
            alertTitle = "Correct"
        } else {
            score -= 1
            alertTitle = "Wrong"
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
