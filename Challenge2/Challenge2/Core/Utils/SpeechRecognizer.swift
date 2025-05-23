//
//  SpeechRecognizer.swift
//  Challenge2
//
//  Created by mini on 4/19/25.
//

import Foundation
import Speech

final class SpeechRecognizer: ObservableObject {
    @Published var recognizedText: String = ""
    @Published var isRecognizedOsilwan: Bool = false
    
    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let validKeywords = [
        "오실완", "오실 완", "오실원", "오실 원", "오실환", "오실 환", "오 시환", "5시 완", "오 시원", "호 시환", "오지환", "호실만", "오실 반", "오실만"
    ]

    init() {
        Task {
            await requestAuthorization()
        }
    }

    func requestAuthorization() async {
        // Authorization Speech Recognizer
        let speechAuthStatus = await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                continuation.resume(returning: status)
            }
        }
        speechAuthStatus == .authorized
        ? print("음성 인식 권한이 허용되었습니다.")
        : print("음성 인식 권한이 허용되지 않았습니다.")
        
        // Authorization Audio Session
        let audioAuthStatus = await withCheckedContinuation { continuation in
            AVAudioSession.sharedInstance().requestRecordPermission { status in
                continuation.resume(returning: status)
            }
        }
        audioAuthStatus
        ? print("오디오 녹음 권한이 허용되었습니다.")
        : print("오디오 녹음 권한이 허용되지 않았습니다.")
    }
    
    func startTranscribing() async throws {
        guard let recognizer, recognizer.isAvailable else { return }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            throw error
        }
        
        let request = SFSpeechAudioBufferRecognitionRequest()
        request.shouldReportPartialResults = true
        request.addsPunctuation = true
        self.request = request
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            request.append(buffer)
        }
        self.audioEngine.prepare()
        try self.audioEngine.start()
        
        self.recognitionTask = recognizer.recognitionTask(with: request) { [weak self] result, error in
            guard let self else { return }

            if let result {
                let transcription = result.bestTranscription.formattedString
                Task { @MainActor in
                    self.recognizedText = transcription
                    self.isRecognizedOsilwan = self.validKeywords.contains { transcription.contains($0) }
                    print("transcription: \(transcription)")
                }
            }
        }
    }
    
    func stopTranscribing() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        request?.endAudio()
        recognitionTask?.cancel()
    }
}
