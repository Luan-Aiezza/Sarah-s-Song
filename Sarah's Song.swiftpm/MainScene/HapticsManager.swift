import CoreHaptics

extension PianoScene {
    
    func setupHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Haptic engine Creation Error: \(error.localizedDescription)")
        }
    }
    
    func playHaptic(for note: String) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let noteIntensities: [String: Float] = [
            "Dó": 0.6, "Dó#": 0.7, "Ré": 0.8, "Ré#": 0.9, "Mi": 1.0,
            "Fá": 1.2, "Fá#": 1.3, "Sol": 1.4, "Sol#": 1.5, "Lá": 1.6,
            "Lá#": 1.7, "Si": 1.8, "Dó2": 2.0
        ]
        
        let intensity = noteIntensities[note] ?? 0.3
        let sharpness: Float = 0.5
        
        let hapticEvent = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [
                CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
                CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
            ],
            relativeTime: 0
        )
        events.append(hapticEvent)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Haptic Playback Error: \(error.localizedDescription)")
        }
    }
}
