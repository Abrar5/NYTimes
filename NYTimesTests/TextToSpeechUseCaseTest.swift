//
//  TextToSpeechUseCaseTest.swift
//  NYTimes
//
//  Created by Abrar on 02/06/2025.
//

import XCTest
@testable import NYTimes

final class TextToSpeechUseCaseTest: XCTestCase {
    var sut: TextToSpeechUseCase!
    var mockSynth: MockSpeechSynthesizer!

    override func setUp() {
        super.setUp()
        sut = TextToSpeechUseCase()
        mockSynth = MockSpeechSynthesizer()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockSynth = nil
    }
    
    func testReadText_ReadText() {
        sut.readText("Hello world")
        let readText = mockSynth.readText("Hello world")
        
        XCTAssertEqual(readText, "Speech started.")
    }
    
    func testReadText_startSpeaking() {
        sut.readText("Hello world")
        let readText = mockSynth.readText("Hello world")

        XCTAssertEqual(readText, "Speech started.")
    }
    
    func testReadText_stopSpeaking() {
        let readText = mockSynth.stopSpeaking()
        XCTAssertEqual(readText, "Speech paused.")
    }
    
    func testReadText_resumeSpeaking() {
        let readText = mockSynth.resumeSpeaking()
        XCTAssertEqual(readText, "Speech continued.")
    }
}
