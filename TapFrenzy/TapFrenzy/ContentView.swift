import SwiftUI

struct ContentView: View {
    
    @State private var score = 0
    @State private var timeRemaining = 10
    @State private var gameOver = false
    
    @State private var highScore = 0
    
    @State private var buttonX: CGFloat = 0
    @State private var buttonY: CGFloat = 0
    
    
    
    var buttonSize: CGFloat {
        return CGFloat(60 + (timeRemaining * 10))
    }
    
    var body: some View {
        
        ZStack {
            
            Color(.systemBackground)
                .ignoresSafeArea()
            
            if !gameOver {
                
                VStack {
                    
                    Text("Tap Frenzy")
                        .font(.largeTitle)
                        .bold()
                    
                    HStack {
                        Text("Score: \(score)")
                            .font(.title2)
                        
                        Spacer()
                        
                        Text("Time: \(timeRemaining)")
                            .font(.title2)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            Button(action: {
                score += 1
            }) {
                Text("TAP")
                    .font(.title)
                    .bold()
                    .frame(width: buttonSize,
                           height: buttonSize)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            }
            .position(x: buttonX, y: buttonY)
            
        }}}
