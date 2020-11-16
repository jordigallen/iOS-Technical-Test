//
//  ResultTableViewCell.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 14/11/20.
//

import UIKit
import SDWebImage

class ResultTableViewCell: UITableViewCell {

    static let identifier = "ResultTableViewCell"
    static let nibName = "ResultTableViewCell"

    private enum ImageView {
        static let cornerRadius = 5.0
        static let transitionDuration: TimeInterval = 0.2
    }

    private enum CellLayer {
        static let cornerRadius = 10
        static let shadowOffsetWdth = 1.5
        static let shadowOffsetheight = 3.0
        static let shadowRadius = 1.0
        static let shadowOpacity = 0.75
    }

    @IBOutlet weak private var viewCell: UIView!

    @IBOutlet weak private var tvShowImage: UIImageView! 

    @IBOutlet private weak var nameLabel: UILabel! {
        didSet {
            self.nameLabel.font = FontFamily.GothamRounded.medium.font(size: 12.0)
            self.nameLabel.textColor = ColorName.strongGray.color
            self.nameLabel.adjustsFontSizeToFitWidth = true
            self.nameLabel.minimumScaleFactor = 0.2
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.tvShowImage.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.viewCell.layer.cornerRadius = CGFloat(CellLayer.cornerRadius)
        self.viewCell.layer.backgroundColor = UIColor.systemBackground.cgColor
        self.viewCell.layer.shadowColor = UIColor.systemGray.cgColor
        let shadowOffset  = CGSize(width: CellLayer.shadowOffsetWdth, height: CellLayer.shadowOffsetWdth)
        self.viewCell.layer.shadowOffset = shadowOffset
        self.viewCell.layer.shadowRadius = CGFloat(CellLayer.shadowRadius)
        self.viewCell.layer.shadowOpacity = Float(CellLayer.shadowOpacity)
        self.viewCell.layer.masksToBounds = false
        self.tvShowImage.layer.cornerRadius = CGFloat(ImageView.cornerRadius)
        self.tvShowImage.clipsToBounds = true
    }

    public func configureTVShow(with tvShow: TVShowModel) {
        self.backgroundColor = ColorName.whiteColor.color
        self.setupProfileImage(tvShow.image)
        self.setupNameLabel(tvShow.name)
    }

}

private extension ResultTableViewCell {
    private func setupProfileImage(_ image: ImageModel?) {
        guard let imagePath = image?.path else { return }
        self.tvShowImage.contentMode = .scaleAspectFit
        self.tvShowImage.sd_setImage(with: URL(string: imagePath), placeholderImage: Asset.placeholderTVShowIcon.image)
    }

    private func setupNameLabel(_ text: String?) {
        self.nameLabel.text = text
    }
}
