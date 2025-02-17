import SpriteKit

class EndScene: SKScene {
    
    var cameraNode: SKCameraNode!
    
    override func didMove(to view: SKView) {
        
        let background = SKSpriteNode(imageNamed: "TableEmpty")
        background.setScale(5.5)
        background.position = CGPoint(x: 0, y: 0)
        background.texture?.filteringMode = .nearest
        background.zPosition = -2
        background.name = "MesaBlur"
        addChild(background)
        
        let endLogo = SKSpriteNode(imageNamed: "EndLogo")
        endLogo.setScale(size.width / 200)
        endLogo.position = CGPoint(x: 0, y: size.height * 0.1)
        endLogo.texture?.filteringMode = .nearest
        endLogo.name = "logo"
        addChild(endLogo)
        
        let restartButton = SKSpriteNode(imageNamed: "PlayPianoButton1")
        restartButton.setScale(size.width / 200)
        restartButton.position = CGPoint(x: 0, y: -size.height * 0.3)
        restartButton.texture?.filteringMode = .nearest
        restartButton.name = "restartButton"
        addChild(restartButton)
        
        let keyboardLabel = SKLabelNode(fontNamed: "SarahsSongFont")
        keyboardLabel.text = "Keyboard only"
        keyboardLabel.fontSize = size.width / 29
        keyboardLabel.fontColor = .black
        keyboardLabel.position = CGPoint(x: restartButton.position.x+25, y: restartButton.position.y-12)
        keyboardLabel.zPosition = 1
        addChild(keyboardLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes {
                if node.name == "restartButton" {
                    
                    let scaleDown = SKAction.scale(to: node.xScale * 0.9, duration: 0.1)
                    let scaleUp = SKAction.scale(to: node.xScale, duration: 0.1)
                    let wait = SKAction.wait(forDuration: 0.01)
                    
                    let sequence = SKAction.sequence([scaleDown, scaleUp, wait])
                    
                    node.run(sequence) {
                        let transition = SKTransition.fade(withDuration: 1.0)
                        let gameScene = PianoScene(size: self.size)
                        gameScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                        self.view?.presentScene(gameScene, transition: transition)
                    }
                }
            }
        }
    }
}
