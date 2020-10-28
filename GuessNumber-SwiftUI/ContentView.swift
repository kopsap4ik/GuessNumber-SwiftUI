//
//  ContentView.swift
//  GuessNumber-SwiftUI
//
//  Created by Василий Петухов on 27.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var sliderValue = Double.random(in: 0...100)
    @State private var targetValue = Int.random(in: 0...100)
    @State private var alpha = 1.0
    @State private var showingAlert = false
    
    var body: some View {
        VStack{
            HStack{
                Text("Установи слайдер на значение:")
                Text("\(targetValue)")
            }
            
            HStack{
                Text("0")
                
                SliderUI(value: $sliderValue, alpha: alpha)
                    .onChange(of: sliderValue, perform: { _ in
                        setAlpha()
                    })

                Text("100")
            }.padding()
            
            Button("Проверить совпадение") {
                showingAlert = true
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Оценка: \(compareValues())"),
                      message: Text("Наивысшая оценка 100 баллов"),
                      dismissButton: .default(Text("OK")){
//                        newGame()
                      }
                )
            })
            
            Button("Начать заново") {
                newGame()
            }
                .offset(x: 0, y: 20.0)
        }
        .onAppear{ setAlpha() }
    }
    
    private func newGame(){
        targetValue = Int.random(in: 0...100)
        sliderValue = Double.random(in: 0...100)
        setAlpha()
    }

    private func setAlpha() {
        alpha = Double(compareValues()) * 0.01
    }
    
    private func compareValues() -> Int {
        let difference = abs(targetValue - lround(sliderValue))
        return 100 - difference
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
