import SwiftUI
import SpriteKit

struct ContentView: View {
    
    var body: some View {
        SpriteView(scene: mainGameScene())
            .ignoresSafeArea()
            .onAppear {
                AudioManager.shared.playBackgroundMusic()
            }
            .onDisappear {
                AudioManager.shared.stopBackgroundMusic()
            }
    }
    
    private func mainGameScene() -> SKScene {
        let scene = MainMenuScene()
        scene.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        scene.scaleMode = .resizeFill
        return scene
    }
}
