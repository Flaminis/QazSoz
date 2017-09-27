//
//  ViewController.swift
//  QazSoz
//
//  Created by Yerbol Kopzhassar on 16/06/2017.
//  Copyright © 2017 Yerbol Kopzhassar. All rights reserved.
//

import UIKit
import EasyPeasy
import SCLAlertView
let blueColor = UIColor(red: 0, green: 0.62, blue: 0.83, alpha: 1)
class ViewController: UIViewController, UITextViewDelegate {
    //MARK: - Properties
    private lazy var initialText: QSTextView = {
        let textView = QSTextView()
        textView.textColor = UIColor(red: 0, green: 0.62, blue: 0.83, alpha: 1)
        textView.backgroundColor = .white
        textView.font = UIFont(name: "Avenir-Light", size: 22)
        textView.autocorrectionType = .no
        textView.tag = 0
        textView.returnKeyType = .done
        textView.placeholder = "Енди сиз казакша жаза аласыз!"
        textView.layer.cornerRadius = 8
        textView.autocapitalizationType = .none
        return textView
    }()
    private lazy var kazakhCyrillic: QSTextView = {
        let textView = QSTextView()
        textView.textColor =  UIColor(red: 0, green: 0.62, blue: 0.83, alpha: 1)
        textView.backgroundColor = .white
        textView.font = UIFont(name: "Avenir-Light", size: 22)
        textView.autocorrectionType = .no
        textView.returnKeyType = .done
        textView.placeholder = "Енді сіз қазақша жаза аласыз!"
        textView.tag = 1
        textView.layer.cornerRadius = 8
        return textView
    }()
    private lazy var kazakhLatin: QSTextView = {
        let textView = QSTextView()
        textView.textColor = UIColor(red: 0, green: 0.62, blue: 0.83, alpha: 1)
        textView.backgroundColor = .white
        textView.font = UIFont(name: "Avenir-Light", size: 22)
        textView.isEditable = false
        textView.autocorrectionType = .no
        textView.returnKeyType = .done
        textView.placeholder = "Endi siz qazaqsha zhaza alasiz!"
        textView.tag = 2
        textView.layer.cornerRadius = 8
        return textView
    }()
    private lazy var appTitle: UILabel = {
        let label = UILabel()
        label.text = "QazSöz"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont(name: "AvenirNext-Regular", size: self.view.bounds.height/25)
        label.sizeToFit()
        return label
    }()
    private lazy var shalaKazTitle: UILabel = {
        let label = UILabel()
        label.text = "Шала казакша"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont(name: "Avenir-Light", size: self.view.bounds.height/33)
        label.sizeToFit()
        return label
    }()
    private lazy var kazCyrTitle: UILabel = {
        let label = UILabel()
        label.text = "Қазақша"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont(name: "Avenir-Light", size: self.view.bounds.height/33)
        label.sizeToFit()
        return label
    }()
    private lazy var kazLatTitle: UILabel = {
        let label = UILabel()
        label.text = "Qazaqşa"
        label.textColor = .white
        label.numberOfLines = 1
        label.font = UIFont(name: "Avenir-Light", size: self.view.bounds.height/33)
        label.sizeToFit()
        return label
    }()
    private lazy var suggestButton: UIButton = {
        let button = UIButton()
        let darkBlue = UIColor(red: 0, green: 0.42, blue: 0.63, alpha: 1)
        button.setTitle("Koemek Usinu", for: .normal)
        button.setTitleColor(blueColor, for: .normal)
        button.setTitleColor(darkBlue, for: .highlighted)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(suggest), for: UIControlEvents.touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialText.delegate = self
        self.kazakhCyrillic.delegate = self
        self.kazakhLatin.delegate = self
        
        setupViews()
        setupConstraints()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK: - SetupViews
    private func setupViews(){
        view.backgroundColor = UIColor(red: 0, green: 0.62, blue: 0.83, alpha: 1)
        [initialText, kazakhCyrillic, kazakhLatin, appTitle,shalaKazTitle,kazCyrTitle,kazLatTitle,suggestButton].forEach {
            view.addSubview($0)}

    }
    //MARK: - Constrains
    private func setupConstraints() {
        
        appTitle <- [
            Top(self.view.bounds.height/25).to(view),
            Right(10)
        ]
        initialText <- [
            Top(12).to(appTitle),
            Height(self.view.bounds.height/6.9),
            Left(8),
            Right(8)
        ]
        kazCyrTitle <- [
            Top(4).to(initialText),
            Left(10),
        ]
        kazakhCyrillic <- [
            Top(2).to(kazCyrTitle),
            Height(self.view.bounds.height/6.9),
            CenterX(),
            Left(8),
            Right(8)
            ]
        kazakhLatin <- [
            Top(4).to(kazLatTitle),
            CenterX(),
            Height(self.view.bounds.height/6.9),
            Left(8),
            Right(8)
        ]
        shalaKazTitle <- [
            Bottom(0).to(initialText),
            Left(10),
        ]
       
        kazLatTitle <- [
            Top(0).to(kazakhCyrillic),
            Left(10),
        ]
        suggestButton <- [
            Left(8),
            Right(8),
            Bottom(8),
            Height(self.view.bounds.height/13)
        ]
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        if (textView.tag==0){
            self.kazakhCyrillic.text = easyChange(input: textView.text)
            self.kazakhLatin.text = (translateLatin(self.kazakhCyrillic.text))
        }
        if (textView.tag==1){
            self.kazakhLatin.text = translateLatin(textView.text)
        }
        if let placeholderLabel = textView.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = textView.text.characters.count > 0
        }
        else{
            textView.text = ""
        }
    }
    
    //MARK: - BUTTON
    func suggest(sender:UIButton!) {
        let alertView = SCLAlertView(appearance: AlertHelper.suggestApearance())
        
        let wrongText = alertView.addTextField("Қате сөз")
        let sugText = alertView.addTextField("Дұрыс аудармасы")
        sugText.spellCheckingType = .no
        sugText.autocorrectionType = .no
        wrongText.spellCheckingType = .no
        wrongText.autocorrectionType = .no
        alertView.addButton("Usnu") {
            let suggestion = Suggestion()
            suggestion.sugg = sugText.text!
            suggestion.wrongWord = wrongText.text!
            suggestion.saveInBackground()
            let thanksView = SCLAlertView(appearance: AlertHelper.suggestApearance())
            thanksView.addButton("Zhabu", action: {})
            thanksView.showSuccess("Rahmet",
                                             subTitle: " t.me/feargreed habarlasiñiz",
                                             colorStyle: 0x019ED3, colorTextButton: 0xFFFFFF)
        }
        alertView.addButton("Artqa") {
        
        }
        
        alertView.showSuccess("Koemek Usinu",
                              subTitle: "Kandai söz duris audarilmadi?",
                              colorStyle: 0x019ED3, colorTextButton: 0xFFFFFF)
    }
    //MARK - Design
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
}

