import SwiftUI
internal import Combine

struct ContentView: View {

    @State private var score = 0
    @State private var timeRemaining = 10
    @State private var gameOver = false
    @State private var highScore = 0

    @State private var buttonX: CGFloat = 200
    @State private var buttonY: CGFloat = 400

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var buttonSize: CGFloat {
        // Challenge: Shrinking Button
        let baseSize: CGFloat = 90
        let shrink = CGFloat(10 - timeRemaining) * 5
        return max(40, baseSize - shrink)
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
                        .padding(.top)

                    HStack {
                        Text("Score: \(score)")
                            .font(.title2)

                        Spacer()

                        Text("Time: \(timeRemaining)")
                            .font(.title2)
                    }
                    .padding()

                    Spacer()

                    Button(action: {
                        score += 1
                        moveButton()
                    }) {
                        Text("TAP")
                            .font(.title2)
                            .bold()
                            .frame(width: buttonSize, height: buttonSize)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .position(x: buttonX, y: buttonY)

                    Spacer()
                }

            } else {

                VStack(spacing: 30) {

                    Text("Game Over")
                        .font(.largeTitle)
                        .bold()

                    Text("Final Score: \(score)")
                        .font(.title2)

                    Text("High Score: \(highScore)")
                        .font(.title3)

                    Button("Play Again") {
                        restartGame()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
        .onAppear {
            moveButton()
        }
        .onReceive(timer) { _ in

            if gameOver { return }

            if timeRemaining > 0 {
                timeRemaining -= 1

                
                moveButton()

            } else {
                gameOver = true
                updateHighScore()
            }
        }
    }

    // MARK: - Move Button (safe bounds)
    func moveButton() {

        let screenWidth: CGFloat = 350
        let screenHeight: CGFloat = 600

        buttonX = CGFloat.random(in: 80...screenWidth)
        buttonY = CGFloat.random(in: 150...screenHeight)
    }

    // MARK: - Restart Game
    func restartGame() {

        updateHighScore()

        score = 0
        timeRemaining = 10
        gameOver = false

        moveButton()
    }

    
    func updateHighScore() {
        if score > highScore {
            highScore = score
        }
    }
}

#Preview {
    ContentView()
}
