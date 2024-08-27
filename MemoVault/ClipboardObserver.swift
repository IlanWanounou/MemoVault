//
//  ClipboardObserver.swift
//  MemoVault
//
//  Created by Wanounou Ilan on 27/08/2024.
//

import SwiftUI
import Combine

class ClipboardObserver: ObservableObject {
    private var changeCount: Int = 0
    private var timer: Timer?
    
    private var clipboardPublisher = PassthroughSubject<String, Never>()
    var clipboardSubscription: AnyCancellable?
    
    var onClipboardChange: ((String) -> Void)?
    
    init() {
        self.changeCount = NSPasteboard.general.changeCount
        self.startObserving()
        
        clipboardSubscription = clipboardPublisher
            .sink(receiveValue: { clipboardContent in
                self.onClipboardChange?(clipboardContent)
            })
    }
    
    func startObserving() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            let pasteboard = NSPasteboard.general
            if pasteboard.changeCount != self.changeCount {
                self.changeCount = pasteboard.changeCount
                if let copiedString = pasteboard.string(forType: .string) {
                    self.clipboardPublisher.send(copiedString)
                }
            }
        }
    }
    func past(text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents();
        pasteboard.setString(text, forType: .string)
    }
    
    deinit {
        timer?.invalidate()
    }
}
