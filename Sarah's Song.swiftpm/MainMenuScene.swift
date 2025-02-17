import SpriteKit

class MainMenuScene: SKScene {
    
    var cameraNode: SKCameraNode!
    var background: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        
        UserDefaults.standard.removeObject(forKey: "hasVisitedDialogueScene2")
        
        AudioManager.shared.playBackgroundMusic()
        
        MyFont.registerFonts()
        
        background = SKSpriteNode(imageNamed: "LongTableBlur")
        background.setScale(max(size.width / background.size.width, size.height / background.size.height) * 1.1)
        background.position = CGPoint(x: 0, y: size.height / 2)
        background.anchorPoint = CGPoint(x: 0, y: 0.5)
        background.texture?.filteringMode = .nearest
        addChild(background)
        
        cameraNode = SKCameraNode()
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(cameraNode)
        
        let logo = SKSpriteNode(imageNamed: "Logo")
        logo.position = CGPoint(x: 0, y: size.height * 0.1)
        logo.setScale(size.width / 150)
        logo.texture?.filteringMode = .nearest
        cameraNode.addChild(logo)
        
        let touchToContinueLabel = SKLabelNode(text: "Tap to play!")
        touchToContinueLabel.fontName = "SarahsSongFont"
        touchToContinueLabel.fontSize = size.width / 30
        touchToContinueLabel.position = CGPoint(x: 15, y: -size.height * 0.35)
        touchToContinueLabel.fontColor = .black
        touchToContinueLabel.alpha = 0
        cameraNode.addChild(touchToContinueLabel)
        
        let fadeIn = SKAction.fadeIn(withDuration: 0.75)
        let fadeOut = SKAction.fadeOut(withDuration: 0.75)
        let blink = SKAction.sequence([fadeIn, fadeOut])
        touchToContinueLabel.run(SKAction.repeatForever(blink))
        
        moveBackground()
    }
    
    func moveBackground() {
        let moveRight = SKAction.moveBy(x: -background.size.width / 4, y: 0, duration: 20.0)
        let moveLeft = SKAction.moveBy(x: background.size.width / 4, y: 0, duration: 20.0)
        let sequence = SKAction.sequence([moveRight, moveLeft])
        let repeatAction = SKAction.repeatForever(sequence)
        background.run(repeatAction)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(withDuration: 1.0)
        let gameScene = DialogueScene(size: self.size)
        gameScene.anchorPoint = CGPoint(x: 0.0, y: 0.0)
        self.view?.presentScene(gameScene, transition: transition)
    }
}
