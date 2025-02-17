import SpriteKit

extension PianoScene {
    
    func setupPianoSkeleton() {
        let pianoSkeleton = SKSpriteNode(imageNamed: "PianoEsqueleto")
        pianoSkeleton.setScale(5.35)
        pianoSkeleton.position = CGPoint(x: 0, y: 0)
        pianoSkeleton.texture?.filteringMode = .nearest
        pianoSkeleton.zPosition = -1
        addChild(pianoSkeleton)
    }
    
    func createKeys() {
        let pianoSkeleton = SKSpriteNode(imageNamed: "PianoEsqueleto")
        pianoSkeleton.setScale(5.35)
        
        for (index, note) in whiteNotes.enumerated() {
            let key = SKSpriteNode(imageNamed: "TeclaBranca")
            key.setScale(10.7)
            key.texture?.filteringMode = .nearest
            key.position = CGPoint(
                x: CGFloat(index) * (key.size.width) + key.size.width - (pianoSkeleton.size.width/1.6155 - key.size.width),
                y: -key.size.height / 12)
            key.name = note
            key.zPosition = 0
            key.texture?.filteringMode = .nearest
            addChild(key)
            keys[note] = key
        }
        
        for (index, note) in blackNotes.enumerated() {
            if note.isEmpty { continue }
            let key = SKSpriteNode(imageNamed: "TeclaPreta")
            key.setScale(10.7)
            key.texture?.filteringMode = .nearest
            key.position = CGPoint(
                x: CGFloat(index) * (key.size.width+21) + (key.size.width) - (pianoSkeleton.size.width/2.04 - key.size.width),
                y: +key.size.width/2)
            
            key.name = note
            key.zPosition = 2
            key.texture?.filteringMode = .nearest
            addChild(key)
            keys[note] = key
        }
    }
    
    func animateKeyPress(key: SKSpriteNode, isPressed: Bool) {
        if isPressed {
            key.texture = SKTexture(imageNamed: key.name!.contains("#") ? "TeclaPretaPress" : "TeclaBrancaPress")
            key.texture?.filteringMode = .nearest
        } else {
            key.texture = SKTexture(imageNamed: key.name!.contains("#") ? "TeclaPreta" : "TeclaBranca")
            key.texture?.filteringMode = .nearest
        }
    }
}
