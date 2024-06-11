//
//  Haptic.swift
//
//
//  Created by Lex on 6/11/24.
//

import Foundation

#if canImport(UIKit)
import UIKit

public final class Haptic {
    
    public static let shared = Haptic()
    private init() {}
    
    
    private var selectionFeedbackGenerator: UISelectionFeedbackGenerator? = nil
    private let notificationFeedbackGenerator: UINotificationFeedbackGenerator = UINotificationFeedbackGenerator()
}


//MARK: - Selection Feedback

public extension Haptic {
    
    func notify(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        self.notificationFeedbackGenerator.notificationOccurred(type)
    }

    func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    
    func startSelection() {
        selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator?.prepare()
    }

    func selectionChanged() {
        
        if selectionFeedbackGenerator == nil {
            selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        }
        
        selectionFeedbackGenerator?.prepare()
        selectionFeedbackGenerator?.selectionChanged()
        selectionFeedbackGenerator?.prepare()
    }
    
    func stopSelection() {
        selectionFeedbackGenerator = nil
    }
}



#endif
