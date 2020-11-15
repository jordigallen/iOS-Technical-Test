//
//  BaseEmptyView.swift
//  ios-Technical-TestTests
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import UIKit

public class BaseEmptyView: UIView, Nib {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var captionLabel: UILabel! {
        didSet {
            self.captionLabel.font = FontFamily.GothamRounded.medium.font(size: 18)
            self.captionLabel.textColor = ColorName.strongGray.color
        }
    }

    public static let nibName: String = "BaseEmptyView"
    private static let imageCornerRadius: CGFloat = 5.0

    public func configure(withImage image: UIImage?, caption: String?, attributedCaption: NSAttributedString?) {
        self.setupImageView(with: image)
        if let attributedCaption = attributedCaption {
            self.setupCaptionLabel(with: attributedCaption)
        } else {
            self.setupCaptionLabel(with: caption)
        }
    }

    public func show() {
        self.isHidden = false
    }

    public func hide() {
        self.isHidden = true
    }

    private func setupImageView(with image: UIImage?) {
        if let image = image {
            self.imageView.image = image
            self.imageView.layer.cornerRadius = CGFloat(BaseEmptyView.imageCornerRadius)
            self.imageView.clipsToBounds = true
        } else {
            self.imageView.isHidden = true
        }
    }

    private func setupCaptionLabel(with text: String?) {
        self.captionLabel.attributedText = nil
        self.captionLabel.text = text
    }

    private func setupCaptionLabel(with attributedText: NSAttributedString) {
        self.captionLabel.text = nil
        self.captionLabel.attributedText = attributedText
    }
}

