//
//  TextToSpeechUseCase.swift
//  NYTimes
//
//  Created by Abrar on 02/06/2025.
//

import AVFAudio

class TextToSpeechUseCase {
    private var speechSynthesizer = AVSpeechSynthesizer()
    private var currentUtterance: AVSpeechUtterance?

    func readText(_ text: String) {
        if speechSynthesizer.isPaused {
            resumeSpeaking()
            return
        }
        
        if speechSynthesizer.isSpeaking {
            stopSpeaking()
            return
        }
        
        startSpeaking(text)
    }
    
    private func startSpeaking(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        currentUtterance = utterance
        
        speechSynthesizer.speak(utterance)
        print("Speech started.")
    }
    
    private func stopSpeaking() {
        speechSynthesizer.pauseSpeaking(at: .word)
        print("Speech paused.")
    }
    
    private func resumeSpeaking() {
        speechSynthesizer.continueSpeaking()
        print("Speech continued.")
    }
}
 
