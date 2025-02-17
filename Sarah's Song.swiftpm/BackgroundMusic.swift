import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    public var backgroundMusicPlayer: AVAudioPlayer?
    public var soundClick: AVAudioPlayer?
    public var fadeTimer: Timer?

    public init() {}
    
    func playBackgroundMusic() {
        if let url = Bundle.main.url(forResource: "Memories", withExtension: "mp3") {
            backgroundMusicPlayer = try? AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.prepareToPlay()
            backgroundMusicPlayer?.volume = 1.0  // Volume inicial no máximo
            backgroundMusicPlayer?.play()
        }
    }
    
    func playSoundClick() {
        if let url2 = Bundle.main.url(forResource: "ClickSound", withExtension: "mp3") {
            soundClick = try? AVAudioPlayer(contentsOf: url2)
            soundClick?.numberOfLoops = 1
            soundClick?.prepareToPlay()
            soundClick?.volume = 0.25  // Volume inicial no máximo
            soundClick?.play()
        }
    }
    
    func setVolume(_ volume: Float) {
        backgroundMusicPlayer?.volume = max(0.0, min(volume, 1.0))
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
        fadeTimer?.invalidate()
    }

}
