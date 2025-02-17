import SpriteKit

class DialogueScene2: SKScene {
    
    var dialogueBox: SKSpriteNode!
    var character: SKSpriteNode!
    var dialogueLabel: SKLabelNode!
    var nextButton: SKSpriteNode!
    var dialogueTexts: [String] = []
    var currentDialogueIndex: Int = 0
    
    
    
    override func didMove(to view: SKView) {
        
        AudioManager.shared.playBackgroundMusic()
        
        let background = SKSpriteNode(imageNamed: "TableEmpty")
        background.setScale(5.5)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.texture?.filteringMode = .nearest
        background.name = "MesaBlur"
        addChild(background)
        
        setupDialogueBox()
        
        setupCharacter()
        
        setupDialogueLabel()

        setupNextButton()
        
        dialogueTexts = [
            "So?! What did you think?",
            
            "Pretty cool, right?!",
            
            "According to the World Health Organization, around 800 million people suffer from some degree of hearing loss.",
            
            "With Haptics and Music Haptics, we can help those people!",
            
            "This project is just one of many ways to use it...",
            
            "Thank you so much for sticking with me until now!",
            
            "See you later!"
        ]

        showNextDialogue()
    }
    
    func setupDialogueBox() {
        dialogueBox = SKSpriteNode(imageNamed: "DialogueBox")
        dialogueBox.setScale(size.width / 210)
        dialogueBox.texture?.filteringMode = .nearest
        dialogueBox.position = CGPoint(x: size.width / 2, y: size.height * 0.21)
        dialogueBox.zPosition = 1
        addChild(dialogueBox)
    }
    
    func setupCharacter() {
        character = SKSpriteNode(imageNamed: "Sarah1")
        character.setScale(size.width / 250)
        character.texture?.filteringMode = .nearest
        character.position = CGPoint(x: size.width * 0.8, y: dialogueBox.position.y + dialogueBox.size.height / 2 + character.size.height / 2)
        character.zPosition = 2
        addChild(character)
    }
    
    func setupDialogueLabel() {
        dialogueLabel = SKLabelNode(text: "")
        dialogueLabel.fontName = "SarahsSongFont"
        dialogueLabel.fontSize = size.width / 40
        dialogueLabel.fontColor = .black
        dialogueLabel.position = CGPoint(x: dialogueBox.position.x - dialogueBox.size.width * 0.45, y: dialogueBox.position.y)
        dialogueLabel.preferredMaxLayoutWidth = dialogueBox.size.width * 0.85
        dialogueLabel.numberOfLines = 3
        dialogueLabel.zPosition = 3
        dialogueLabel.horizontalAlignmentMode = .left
        dialogueLabel.verticalAlignmentMode = .center
        addChild(dialogueLabel)
    }
    
    func setupNextButton() {
        nextButton = SKSpriteNode(imageNamed: "NextButton1")
        nextButton.texture?.filteringMode = .nearest
        nextButton.setScale(size.width / 250)
        nextButton.position = CGPoint(x: size.width * 0.85, y: dialogueBox.size.height * 0.32)
        nextButton.zPosition = 4
        nextButton.name = "nextButton"
        addChild(nextButton)
    }
    
    func showNextDialogue() {

        if currentDialogueIndex < dialogueTexts.count {
            dialogueLabel.text = dialogueTexts[currentDialogueIndex]
            
            switch currentDialogueIndex {
            case 2:
                character.texture = SKTexture(imageNamed: "Sarah4")
                character.texture?.filteringMode = .nearest
            case 0, 4:
                character.texture = SKTexture(imageNamed: "Sarah1")
                character.texture?.filteringMode = .nearest
            case 6, 7:
                character.texture = SKTexture(imageNamed: "Sarah2")
                character.texture?.filteringMode = .nearest
            case 1, 3, 5:
                character.texture = SKTexture(imageNamed: "Sarah3")
                character.texture?.filteringMode = .nearest
            default:
                character.texture = SKTexture(imageNamed: "Sarah1")
                character.texture?.filteringMode = .nearest
            }
            
            currentDialogueIndex += 1
        } else {
            
            let transition = SKTransition.fade(withDuration: 1.0)
            let pianoScene = EndScene(size: self.size)
            pianoScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.view?.presentScene(pianoScene, transition: transition)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let nodes = self.nodes(at: location)
            
            for node in nodes {
                if node.name == "nextButton" {
                    
                    let scaleDown = SKAction.scale(to: node.xScale * 0.8, duration: 0.1)
                    let scaleUp = SKAction.scale(to: node.xScale, duration: 0.1)
                    let wait = SKAction.wait(forDuration: 0.01)
                    AudioManager.shared.playSoundClick()
                    let sequence = SKAction.sequence([scaleDown, scaleUp, wait])
                    
                    nextButton.run(sequence)

                    showNextDialogue()
                }
            }
        }
    }
}
