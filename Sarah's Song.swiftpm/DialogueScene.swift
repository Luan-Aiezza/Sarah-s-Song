import SpriteKit

class DialogueScene: SKScene {
    
    var dialogueBox: SKSpriteNode!
    var character: SKSpriteNode!
    var dialogueLabel: SKLabelNode!
    var nextButton: SKSpriteNode!
    var dialogueTexts: [String] = []
    var currentDialogueIndex: Int = 0
    var nextButtonOriginalScale: CGFloat = 1.0
    
    override func didMove(to view: SKView) {

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
            "Hey there! I'm Sarah! Nice to meet you!",
            
            "So, tell me... do you have something you're really passionate about?",
            
            "Since I was little, I've always loved games and music.",
            
            "I loved them so much that when I turned 12 yers old, my parents gave me a keyboard so I could write my own songs.",
            
            "From that moment on, I decided that one day I’d create a game with my own soundtrack.",
            
            "But then, as I got older, I found out I had an ear infection... and that I’d slowly lose my hearing.",
            
            "For me, it felt like the end... my dream was slipping away.",
            
            "That was until 2024, when I discovered Music Haptics! A tool Apple released for iPhone.",
            
            "It was made so people like me could enjoy music again, but through vibrations.",
            
            "Crazy, right?! I was so happy, even if I still couldn’t make music again right away...",
            
            "But then I thought of Beethoven! Even without hearing, he kept playing, feeling the piano’s vibrations.",
            
            "This project is about doing the same thing with Haptics! Creating vibration patterns for each musical note.",
            
            "On the next screen, feel free to play my keyboard for as long as you like. Try to feel the different intensities between the keys",
            
            "Oh, and if this is your first time playing a keyboard, try the demo button!",
            
            "Ready?! Give it a try!"
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
        nextButtonOriginalScale = nextButton.xScale
        nextButton.position = CGPoint(x: size.width * 0.85, y: dialogueBox.size.height * 0.32)
        nextButton.zPosition = 4
        nextButton.name = "nextButton"
        addChild(nextButton)
    }
    
    func showNextDialogue() {
        if currentDialogueIndex < dialogueTexts.count {
            dialogueLabel.text = dialogueTexts[currentDialogueIndex]
            
            switch currentDialogueIndex {
            case 5, 6:
                character.texture = SKTexture(imageNamed: "Sarah4")
                character.texture?.filteringMode = .nearest
            case 0, 3, 10:
                character.texture = SKTexture(imageNamed: "Sarah1")
                character.texture?.filteringMode = .nearest
            case 1, 12, 8:
                character.texture = SKTexture(imageNamed: "Sarah2")
                character.texture?.filteringMode = .nearest
            case 2, 4, 9, 11, 13:
                character.texture = SKTexture(imageNamed: "Sarah3")
                character.texture?.filteringMode = .nearest
            default:
                character.texture = SKTexture(imageNamed: "Sarah1")
                character.texture?.filteringMode = .nearest
            }
            
            currentDialogueIndex += 1
        } else {
            let transition = SKTransition.fade(withDuration: 1.0)
            let pianoScene = PianoScene(size: self.size)
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
                    nextButton.setScale(nextButtonOriginalScale)
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
