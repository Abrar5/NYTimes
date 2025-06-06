//
//  MockSpeechSynthesizer.swift
//  NYTimes
//
//  Created by Abrar on 06/06/2025.
//

import AVFAudio

class MockSpeechSynthesizer {
    private var speechSynthesizer = AVSpeechSynthesizer()
    private var currentUtterance: AVSpeechUtterance?
    
    func readText(_ text: String) -> String {
        if speechSynthesizer.isPaused {
            return resumeSpeaking()
        }
        
        if speechSynthesizer.isSpeaking {
            return stopSpeaking()
        }
        
        return startSpeaking(text)
    }
    
    func startSpeaking(_ text: String) -> String {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        currentUtterance = utterance
        
        speechSynthesizer.speak(utterance)
        return "Speech started."
    }
    
    func stopSpeaking() -> String {
        speechSynthesizer.pauseSpeaking(at: .word)
        return "Speech paused."
    }
    
    func resumeSpeaking() -> String {
        speechSynthesizer.continueSpeaking()
        return "Speech continued."
    }
}
