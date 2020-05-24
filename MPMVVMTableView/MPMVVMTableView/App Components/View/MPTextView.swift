//
//  MPTextView.swift
//  MPMVVMTableView
//
//  Created by Manish on 3/5/20.
//  Copyright © 2020 MANHYA. All rights reserved.
//

import UIKit

class MPTextView: UITextView, Jitterable, Flashable {
    
    private weak var externalDelegate: UITextViewDelegate?

    override var delegate: UITextViewDelegate? {
        set {
            self.externalDelegate = newValue
        }
        get {
            return self.externalDelegate
        }
    }

    fileprivate func applyStyles() {
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 5
        self.clipsToBounds = true
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        super.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.delegate = self
    }
}

extension MPTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("aaaa")
        self.externalDelegate?.textViewDidBeginEditing?(textView)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        print("bbbb")
        self.externalDelegate?.textViewDidEndEditing?(textView)
    }

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return self.externalDelegate?.textViewShouldEndEditing?(textView) ?? true
    }

    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return self.externalDelegate?.textViewShouldEndEditing?(textView) ?? true
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return (self.externalDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text)) ?? true
    }

    func textViewDidChange(_ textView: UITextView) {
        self.externalDelegate?.textViewDidChange?(textView)
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
            self.externalDelegate?.textViewDidChangeSelection?(textView)
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return self.externalDelegate?.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? true
    }

    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return self.externalDelegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? true
    }

}
