import SpriteKit

extension PianoScene {
    
    func showPopover() {
        popOver = SKSpriteNode(imageNamed: "InformationBox")
        popOver.setScale(4.75)
        popOver.position = CGPoint(x: size.width/size.width, y: size.height/size.height)
        popOver.zPosition = 4
        popOver.texture?.filteringMode = .nearest
        setupDialogueLabel()
        setupCloseButton()
        setupHoldingImage()
        addChild(popOver)
    }
    
    func setupBackgroundPopOver() {
        bgPopOver = SKSpriteNode(imageNamed: "TableEmpty")
        bgPopOver.setScale(5.5)
        bgPopOver.zPosition = 3
        bgPopOver.texture?.filteringMode = .nearest
        bgPopOver.position = CGPoint(x: 0, y: 0)
        bgPopOver.name = "bgPopover"
        addChild(bgPopOver)
    }
    
    func setupHoldingImage() {
        holdingImage = SKSpriteNode(imageNamed: "HoldingPhone")
        holdingImage.setScale(0.30)
        holdingImage.zPosition = 5
        holdingImage.texture?.filteringMode = .nearest
        holdingImage.position = CGPoint(x: dialogueLabel.position.x/dialogueLabel.position.x, y: dialogueLabel.position.y - 15)
        popOver.addChild(holdingImage)
    }
    
    func setupDialogueLabel() {
        dialogueLabel = SKLabelNode(text: "")
        dialogueLabel.fontName = "SarahsSongFont"
        dialogueLabel.fontSize = 26
        dialogueLabel.setScale(0.21)
        dialogueLabel.fontColor = .black
        dialogueLabel.position = CGPoint(x: popOver.position.x, y: popOver.position.y-5)
        dialogueLabel.preferredMaxLayoutWidth = 300
        dialogueLabel.numberOfLines = 4
        dialogueLabel.zPosition = 5
        dialogueLabel.horizontalAlignmentMode = .center
        dialogueLabel.verticalAlignmentMode = .bottom
        dialogueLabel.text = "For a better experience, set your iPhone's volume to zero and hold it as follows:"
        popOver.addChild(dialogueLabel)
    }
    
    func setupCloseButton() {
        closeButton = SKSpriteNode(imageNamed: "ExitButton1")
        closeButton.setScale(1)
        closeButton.zPosition = 5
        closeButton.texture?.filteringMode = .nearest
        closeButton.position = CGPoint(x: 40, y: 37)
        closeButton.name = "closePopover"
        popOver.addChild(closeButton)
    }
    
    func closePopover(node: SKSpriteNode) {
        let scaleDown = SKAction.scale(to: node.xScale * 0.8, duration: 0.1)
        let scaleUp = SKAction.scale(to: node.xScale, duration: 0.1)
        let wait = SKAction.wait(forDuration: 0.01)
        let sequence = SKAction.sequence([scaleDown, scaleUp, wait])
        
        node.run(sequence) {
            self.bgPopOver.run(.wait(forDuration: 0.1)) {
                self.bgPopOver.removeFromParent()
            }
            self.popOver.run(.wait(forDuration: 0.1)) {
                self.popOver.removeFromParent()
            }
        }
    }
}
