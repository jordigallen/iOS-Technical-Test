//
//  DetailViewController.swift
//  ios-Technical-Test
//
//  Created by JORDI GALLEN RENAU on 15/11/20.
//

import UIKit
import SDWebImage

public class DetailListViewController: UIViewController {

    @IBOutlet var closeDetail: UIButton! {
        didSet {
            self.closeDetail.setImage(Asset.closeGray.image, for: .normal)
        }
    }

    @IBOutlet weak var imageTVShow: UIImageView! {
        didSet {
            self.imageTVShow.image = imageDetail?.image
            self.imageTVShow.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.50).cgColor
            self.imageTVShow.layer.shadowOffset = CGSize(width: 0, height: 3)
            self.imageTVShow.layer.shadowOpacity = 8.0
            self.imageTVShow.layer.shadowRadius = 10.0
            self.imageTVShow.layer.masksToBounds = false
            self.imageTVShow.layer.cornerRadius = 8.0
            self.imageTVShow.clipsToBounds = true
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.text = titleDetail
            self.titleLabel.font = FontFamily.GothamRounded.bold.font(size: 22)
            self.titleLabel.textColor = ColorName.strongGray.color
        }
    }

    @IBOutlet weak var genderLabel: UILabel! {
        didSet {
            self.genderLabel.text = genderDetail
            self.genderLabel.font = FontFamily.GothamRounded.light.font(size: 20)
            self.genderLabel.textColor = ColorName.strongGray.color
        }
    }


    @IBOutlet weak var summaryUITextView: UITextView! {
        didSet {
            let data = Data(sinopsisDetail!.utf8)
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                self.summaryUITextView.attributedText = attributedString
            }
            self.summaryUITextView.font = FontFamily.GothamRounded.light.font(size: 17)
            self.summaryUITextView.textColor = ColorName.strongGray.color
        }
    }

    @IBOutlet weak var puntuationLabel: UILabel! {
        didSet {
            self.puntuationLabel.text = String(puntuation ?? 0)
            self.puntuationLabel.font = FontFamily.GothamRounded.bold.font(size: 22)
            self.puntuationLabel.textColor = ColorName.strongGray.color
        }
    }

    var imageDetail: UIImageView?
    var titleDetail: String?
    var genderDetail: String?
    var sinopsisDetail: String?
    var puntuation: Double?

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
