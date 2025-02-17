import SpriteKit

extension PianoScene {
    func backgroudPiano() {
        let background = SKSpriteNode(imageNamed: "TablePiano")
        background.setScale(5.5)
        background.position = CGPoint(x: 0, y: 0)
        background.texture?.filteringMode = .nearest
        background.zPosition = -2
        addChild(background)
    }
    
    func endSceneButton() {
        endButton = SKSpriteNode(imageNamed: "ExitExpButton1")
        endButton.setScale(2.75)
        endButton.zPosition = 1
        endButton.texture?.filteringMode = .nearest
        endButton.position = CGPoint(x: size.width/size.width + 260, y: size.height/size.height + 148)
        endButton.name = "exitExperience"
        addChild(endButton)
    }
    
    func displayPosition(){
        displayNote = SKSpriteNode(imageNamed: "display")
        displayNote.setScale(5.5)
        displayNote.zPosition = 1
        displayNote.texture?.filteringMode = .nearest
        displayNote.position = CGPoint(x: size.width/size.width + 130, y: size.height/size.height + 148)
        displayNote.name = "display"
        addChild(displayNote)
    }
    
    func playSound(for note: String) {
        let soundAction = SKAction.playSoundFileNamed("\(note).m4a", waitForCompletion: false)
        run(soundAction)
    }
    
    func showExitConfirmation() {
        guard let viewController = self.view?.window?.rootViewController else { return }
        
        let alert = UIAlertController(title: "Exit Experience",
                                      message: "Are you sure you want to exit the experience?",
                                      preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Exit", style: .destructive) { [weak self] _ in
            self?.exitExperience()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
}
