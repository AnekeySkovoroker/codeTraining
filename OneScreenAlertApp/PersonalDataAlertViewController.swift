//
//  ViewController.swift
//  codeTraining
//
//  Created by Никита Комов on 02.03.2023.
//

import UIKit
import SnapKit

class PersonalDataAlertViewController: UIViewController {
    
    //MARK: Interface
    private lazy var alertView = UIView()
    
    private lazy var alertTitle = UILabel()

    private lazy var checkBoxImage = UIImageView()
    private lazy var checkBoxLabel = UILabel()
    
    private lazy var alertOkButton = UIButton()

    private lazy var bImageView = UIImageView()

    //MARK: Additional
    private var isChecked = false

    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.setupHierarchy()
        self.setupConstraint()
    }
}

extension PersonalDataAlertViewController {

    //MARK: View style
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.alertTitle = createTitleLabel()
        self.alertOkButton = createAlertOkBtn()
        self.checkBoxImage = createCheckBoxImage()
        self.checkBoxLabel = createCheckBoxLabel()
        self.bImageView = createImageView()
        self.alertView = createAlertView()
    }
    
    private func createTitleLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = Constants.Color.alertTitleBackgroundColor
        label.textColor = .black
        label.numberOfLines = 0
        label.text = Constants.Text.alertTitle
        label.font = Constants.Font.titleLabelFont
        return label
    }
    
    private func createCheckBoxImage() -> UIImageView {
        let imageView = UIImageView(image: Constants.Image.rectImageWith(backgroundColor: Constants.Color.checkBoxImageBackGroundColor))
        imageView.backgroundColor = Constants.Color.checkBoxImageBackGroundColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(boxTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = Constants.Size.checkBoxBorderRadius
        imageView.layer.borderWidth = Constants.Size.checkBoxBorderWidth
        imageView.layer.masksToBounds = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
        return imageView
    }
    
    private func createCheckBoxLabel() -> UILabel {
        let label = UILabel()
        label.backgroundColor = Constants.Color.checkBoxLabelBackgroundColor
        label.numberOfLines = 0
        label.attributedText = Constants.Text.agreevmentAttributed
        label.font = Constants.Font.checkboxLabelFont
        label.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnLink(tapGestureRecognizer:)))
        label.addGestureRecognizer(tapGesture)
        return label
    }
    
    
    private func createAlertOkBtn() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(Constants.Text.okButton, for: [])
        button.titleLabel?.font = Constants.Font.okButtonFont
        button.backgroundColor = Constants.Color.alertOkButtonDisabledBackgroundColor
        button.setTitleColor(Constants.Color.alertOkButtonEnabledTextColor, for: .normal)
        button.setTitleColor(Constants.Color.alertOkButtonDisabledTextColor, for: .disabled)
        button.layer.cornerRadius = Constants.Size.okButtonCornerRadius
        button.isEnabled = false
        return button
    }
    
    private func setBackgroundColor() {
        
    }
    
    private func createImageView() -> UIImageView {
        let imageView = UIImageView(image: Constants.Image.coinImage())
        return imageView
    }
    
    private func createAlertView() -> UIView {
        let view = UIView()
        view.backgroundColor = Constants.Color.alertViewBackgroundColor
        view.layer.cornerRadius = Constants.Size.alertViewCornerRadius
        
        return view
    }
    
    //MARK: Views location
    private func setupConstraint() {
        alertView.snp.makeConstraints{ make in
            make.centerY.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.Size.defaulHorizontalOffsetForPositiveSide)
            make.trailing.equalToSuperview().offset(Constants.Size.defaultHorizontalOffsetForNegativeSide)
        }
        
        alertTitle.snp.makeConstraints({ make in
            make.top.equalToSuperview().offset(Constants.Size.defaulVerticalOffsetForPositiveSide)
            make.leading.equalToSuperview().offset(Constants.Size.defaulHorizontalOffsetForPositiveSide)
        })
        
        checkBoxImage.snp.makeConstraints({ make in
            make.top.equalTo(alertTitle.snp.bottom).offset(Constants.Size.defaulVerticalOffsetForPositiveSide)
            make.leading.equalToSuperview().offset(Constants.Size.defaulHorizontalOffsetForPositiveSide)
            make.trailing.equalTo(checkBoxLabel.snp.leading).offset(Constants.Size.customtHorizontalOffsetForNegativeSide)
            make.height.width.equalTo(Constants.Size.checkBoxImageSize.width)
        })
        
        checkBoxLabel.snp.makeConstraints({ make in
            make.top.equalTo(alertTitle.snp.bottom).offset(Constants.Size.defaulVerticalOffsetForPositiveSide)
        })
        
        alertOkButton.snp.makeConstraints({ make in
            make.top.equalTo(checkBoxLabel.snp.bottom).offset(Constants.Size.defaulVerticalOffsetForPositiveSide)
            make.bottom.equalToSuperview().offset(Constants.Size.defaultVerticalOffsetForNegativeSide)
            make.leading.equalToSuperview().offset(Constants.Size.customHorizontalOffsetForPositiveSide)
            make.trailing.equalToSuperview().offset(Constants.Size.customtHorizontalOffsetForNegativeSide)
            make.height.equalTo(Constants.Size.okButtonSize.height)
        })
        
        bImageView.snp.makeConstraints({ make in
            make.width.equalTo(Constants.Size.coinImageSize.width)
            make.height.equalTo(Constants.Size.coinImageSize.height)
            make.leading.equalTo(alertTitle.snp.trailing)
            make.leading.equalTo(checkBoxLabel.snp.trailing)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(Constants.Size.topFromSuperviewForCoin)
        })
        
    }
    
    private func setupHierarchy() {
        alertView.addSubview(alertTitle)
        alertView.addSubview(checkBoxImage)
        alertView.addSubview(checkBoxLabel)
        alertView.addSubview(alertOkButton)
        alertView.addSubview(bImageView)
        self.view.addSubview(alertView)
    }
    
    //MARK: Views functional
    @objc private func boxTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        alertOkButton.isEnabled = !isChecked
        checkBoxImage.image = isChecked ? Constants.Image.rectImageWith(backgroundColor: Constants.Color.checkBoxImageBackGroundColor) : Constants.Image.checkedImage()
        alertOkButton.backgroundColor = isChecked ? Constants.Color.alertOkButtonDisabledBackgroundColor : Constants.Color.alertOkButtonEnabledBackgroundColor
        isChecked = !isChecked
    }
    
    @objc private func tapOnLink(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let label = tapGestureRecognizer.view as? UILabel else {
            return
        }
        let text = label.attributedText?.string ?? ""
        guard let linkRange = text.range(of: Constants.Text.highlightedLink) else {return}
        let convertedRange = NSRange(linkRange, in: text)
        label.attributedText?.enumerateAttribute(.link, in: convertedRange, options: []) { value, range, _ in
            if  let urlText = value as? String,
                let fileUrl = URL(string: urlText) {
                UIApplication.shared.open(fileUrl)
            }
        }
    }
}


extension PersonalDataAlertViewController {
    private struct Constants {

        struct Text {
            static let alertTitle = "Чтобы получать и передавать монетки, необходимо принять соглашение"
            static let okButton = "Подтвердить"
            static let agreevmentTitle = "Я согласен с правилами пользовательского соглашения"
            static let highlightedLink = "правилами пользовательского соглашения"
            static let agreevmentAttributed = createAttributedLinkString(text: agreevmentTitle, linkStr: highlightedLink)
            static let googleLink = "https://www.google.com"
            
            static private func createAttributedLinkString(text: String, linkStr: String) -> NSAttributedString {
                let attributedString = NSMutableAttributedString(string: text)
                
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .left
                attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: .init(location: 0, length: text.count))
                attributedString.addAttribute(.foregroundColor, value: Constants.Color.checkBoxLabelTextColor, range: .init(location: 0, length: text.count))
                
                guard let linkRange = text.range(of: linkStr) else {return attributedString}
                let convertedRange = NSRange(linkRange, in: text)
                
                let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
                
                attributedString.addAttributes(underlineAttribute, range: convertedRange)
                attributedString.addAttribute(.link, value: googleLink, range: convertedRange)
                
                return attributedString
            }
        }
        
        struct Image {
            static let checkedImageName = "checkImage"
            static func checkedImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
                return UIKit.UIImage(named: checkedImageName)?.withBackground(color: Constants.Color.checkBoxImageBackGroundColor)
            }
            
            static let uncheckedImageName = "uncheckImage"
            static func uncheckedImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
                return UIKit.UIImage(named: uncheckedImageName)
            }
            
            static let coinImageName = "coin"
            static func coinImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
                return UIKit.UIImage(named: coinImageName)
            }
            
            static func rectImageWith(backgroundColor: UIColor) -> UIImage {
                let size = CGSize(width: 100, height: 100)
                let view = UIView(frame: CGRect(origin: .zero, size: size))
                view.backgroundColor = backgroundColor
                
                let renderer = UIGraphicsImageRenderer(size: size)
                let image = renderer.image { ctx in
                    view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
                }
                return image
            }
        }
        struct Size {
            static let coinImageSize = CGSize(width: 60, height: 80)
            static let okButtonSize = CGSize(width: .zero, height: 50)
            static let checkBoxImageSize = CGSize(width: 30, height: 30)
            static let topFromSuperviewForCoin = 30.0
            
            static let defaulHorizontalOffsetForPositiveSide = 30.0
            static let defaultHorizontalOffsetForNegativeSide = -30.0
            static let defaulVerticalOffsetForPositiveSide = 20.0
            static let defaultVerticalOffsetForNegativeSide = -20.0
            
            static let customHorizontalOffsetForPositiveSide = 12.0
            static let customtHorizontalOffsetForNegativeSide = -12.0
            static let customVerticalOffsetForPositiveSide = 16.0
            static let customVerticalOffsetForNegativeSide = -16.0
            
            static let checkBoxBorderRadius = 5.0
            static let checkBoxBorderWidth = 3.0
            
            static let alertViewCornerRadius = 10.0
            
            static let okButtonCornerRadius = 15.0
        }
        
        struct Color {
            static let alertViewBackgroundColor = UIColor(red: 0xEC, green: 0xEC, blue: 0xF6)
            
            static let alertTitleTextColor = UIColor.black
            static let alertTitleBackgroundColor = UIColor.clear
            
            static let checkBoxImageBackGroundColor = alertViewBackgroundColor
            
            static let checkBoxLabelTextColor = UIColor.black
            static let checkBoxLabelBackgroundColor = UIColor.clear
            
            static let alertOkButtonEnabledBackgroundColor = UIColor(red: 0x12, green: 0x92, blue: 0xE7)
            static let alertOkButtonEnabledTextColor = UIColor(red: 0xDF, green: 0xFF, blue: 0xFF)
            
            static let alertOkButtonDisabledBackgroundColor = UIColor(red: 0xDE, green: 0xE0, blue: 0xE3)
            static let alertOkButtonDisabledTextColor = UIColor(red: 0x8B, green: 0x9C, blue: 0x9D)
        }
        
        struct Font {
            static let okButtonFont = UIFont.systemFont(ofSize: 20)
            static let checkboxLabelFont = UIFont.systemFont(ofSize: 14)
            static let titleLabelFont = UIFont.boldSystemFont(ofSize: 19)
        }
        
    }
}

