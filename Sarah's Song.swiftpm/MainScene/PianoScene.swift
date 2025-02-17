import SpriteKit
import AVFoundation
import CoreHaptics

class PianoScene: SKScene {
    
    let guidedMelody: [(note: String, duration: TimeInterval)] = [
        ("Dó", 0.5), ("Dó", 0.5), ("Ré", 0.5), ("Dó", 0.5), ("Fá", 0.5), ("Mi", 1.0),
        ("Dó", 0.5), ("Dó", 0.5), ("Ré", 0.5), ("Dó", 0.5), ("Sol", 0.5), ("Fá", 1.0),
        ("Dó", 0.5), ("Dó", 0.5), ("Dó2", 0.5), ("Lá", 0.5), ("Fá", 0.5), ("Mi", 0.5), ("Ré", 1.0)
    ]
    
    var isPlayingMelody = false
    var hapticEngine: CHHapticEngine?
    let whiteNotes = ["Dó", "Ré", "Mi", "Fá", "Sol", "Lá", "Si", "Dó2"]
    let blackNotes = ["Dó#", "Ré#", "", "Fá#", "Sol#", "Lá#"]
    var keys: [String: SKSpriteNode] = [:]
    var playingKeys: Set<UITouch> = []
    var popOver: SKSpriteNode!
    var closeButton: SKSpriteNode!
    var endButton: SKSpriteNode!
    var displayNote: SKSpriteNode!
    var holdingImage: SKSpriteNode!
    var bgPopOver: SKSpriteNode!
    var dialogueLabel: SKLabelNode!
    var nextButton: SKSpriteNode!
    var currentStep = 1
    
    override func didMove(to view: SKView) {
        setupBackgroundPopOver()
        showPopover()
        backgroudPiano()
        endSceneButton()
        setupHaptics()
        setupPianoSkeleton()
        createKeys()
        setupPlayMelodyButton()
        displayPosition()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if let key = atPoint(location) as? SKSpriteNode, let note = key.name, keys[note] != nil, !playingKeys.contains(touch) {
                playSound(for: note)
                playHaptic(for: note)
                animateKeyPress(key: key, isPressed: true)
                display(note: convertNoteToInternational(note))
                playingKeys.insert(touch)
            }
            
            let nodes = self.nodes(at: location)
            for node in nodes {
                switch node.name {
                case "closePopover":
                    closePopover(node: node as! SKSpriteNode)
                    AudioManager.shared.stopBackgroundMusic()
                case "exitExperience":
                    showExitConfirmation()
                case "playMelody":
                    playGuidedMelody()
                default:
                    break
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            
            if let previousKey = atPoint(previousLocation) as? SKSpriteNode, let currentKey = atPoint(location) as? SKSpriteNode,
               previousKey != currentKey {
                
                if previousKey.name != nil {
                    animateKeyPress(key: previousKey, isPressed: false)
                }
                
                if let note = currentKey.name {
                    playSound(for: note)
                    playHaptic(for: note)
                    animateKeyPress(key: currentKey, isPressed: true)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            playingKeys.remove(touch)
            let location = touch.location(in: self)
            
            if let key = atPoint(location) as? SKSpriteNode, let keyName = key.name, keys[keyName] != nil {
                animateKeyPress(key: key, isPressed: false)
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    func exitExperience() {
        let transition = SKTransition.fade(withDuration: 1.0)
        
        if UserDefaults.standard.bool(forKey: "hasVisitedDialogueScene2") {
            let endScene = EndScene(size: self.size)
            endScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            self.view?.presentScene(endScene, transition: transition)
            AudioManager.shared.playBackgroundMusic()
        } else {
            UserDefaults.standard.set(true, forKey: "hasVisitedDialogueScene2")
            let dialogueScene2 = DialogueScene2(size: self.size)
            dialogueScene2.anchorPoint = CGPoint(x: 0.0, y: 0.0)
            self.view?.presentScene(dialogueScene2, transition: transition)
        }
    }
    
    func playGuidedMelody() {
        guard !isPlayingMelody else { return }
        isPlayingMelody = true

        var delay: TimeInterval = 0
        for (note, duration) in guidedMelody {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if let key = self.keys[note] {
                    self.display(note: self.convertNoteToInternational(note))
                    self.animateKeyPress(key: key, isPressed: true)
                    self.playSound(for: note)
                    self.playHaptic(for: note)

                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        self.animateKeyPress(key: key, isPressed: false)
                    }
                }
            }
            delay += duration
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.isPlayingMelody = false
        }
    }
    
    func setupPlayMelodyButton() {
        let playMelodyButton = SKSpriteNode(imageNamed: "DemoButton")
        playMelodyButton.name = "playMelody"
        playMelodyButton.position = CGPoint(x: size.width/size.width - 260, y: size.height/size.height + 148)
        playMelodyButton.zPosition = 1
        playMelodyButton.setScale(2.75)
        addChild(playMelodyButton)
    }
    
    func display(note: String) {
        self.childNode(withName: "noteDisplay")?.removeFromParent()
        
        let noteLabel = SKLabelNode(fontNamed: "SarahsSongFont")
        noteLabel.name = "noteDisplay"
        noteLabel.text = note
        noteLabel.fontSize = 24
        noteLabel.fontColor = .black
        noteLabel.position = CGPoint(x: displayNote.position.x, y: displayNote.position.y-13)
        noteLabel.zPosition = 10
        
        addChild(noteLabel)
        
        noteLabel.run(SKAction.sequence([
            SKAction.wait(forDuration: 1.0),
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.removeFromParent()
        ]))
        
    }
    
    func convertNoteToInternational(_ note: String) -> String {
        let noteMap = [
            "Dó": "C3", "Dó#": "C#3",
            "Ré": "D3", "Ré#": "D#3",
            "Mi": "E3",
            "Fá": "F3", "Fá#": "F#3",
            "Sol": "G3", "Sol#": "G#3",
            "Lá": "A3", "Lá#": "A#3",
            "Si": "B3",
            "Dó2": "C4"
        ]
        return noteMap[note] ?? note
    }
    
}
