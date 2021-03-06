//
//  ViewController.swift
//  Tags
//
//  Created by pikachu987 on 02/10/2018.
//  Copyright (c) 2018 pikachu987. All rights reserved.
//

import UIKit
import Tags

class ViewController: UIViewController {
    @IBOutlet private weak var tagsView: TagsView!
    @IBOutlet private weak var widthSlider: UISlider!
    @IBOutlet private weak var leadingConstraint: NSLayoutConstraint!
    @IBOutlet private weak var heightLabel: UILabel!
    @IBOutlet private weak var tagsLabel: UILabel!
    
    private var alertController: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Tags"
        
        self.tagsView.delegate = self
        
        self.heightLabel.text = "height: \(self.tagsView.height)"
        self.widthSlider.minimumValue = 0
        self.widthSlider.value = 0
        self.widthSlider.maximumValue = Float(UIScreen.main.bounds.width/2 - 60)
        self.widthSlider.addTarget(self, action: #selector(self.sliderAction(_:)), for: .valueChanged)
        self.tagsLabel.numberOfLines = 0
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "CustomAdd", style: .plain, target: self, action: #selector(self.tagCustomAction(_:)))
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "LastButton", style: .plain, target: self, action: #selector(self.lastBarButtonAction(_:)))
        
        self.makeTagsString()
        
        
        
//
//        self.tagsView.lastTag = nil
//        self.tagsView.removeAll()
//        self.tagsLabel.text = self.tagsView.tagTextArray
//            .reduce("tags:\n", { (result, str) -> String in
//                return "\(result)\(str),"
//            })
//
//        /// Append
//        let button = TagButton()
//        button.setTitle("HI", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.setImage(UIImage(named: "icTagRemove")?.withRenderingMode(.alwaysOriginal), for: .normal)
//        let options = ButtonOptions(
//            layerColor: UIColor.brown,
//            layerRadius: 10,
//            layerWidth: 2,
//            tagTitleColor: UIColor(white: 89/255, alpha: 1),
//            tagFont: UIFont.boldSystemFont(ofSize: 15),
//            tagBackgroundColor: UIColor.black)
//        button.setEntity(options)
//        self.tagsView.append(button)
//        self.makeTagsString()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    private func makeTagsString(){
        self.tagsLabel.text = self.tagsView.tagTextArray
            .reduce("tags:\n", { (result, str) -> String in
                return "\(result)\(str),"
            })
    }
    
    
    
    @objc private func tagCustomAction(_ sender: UIBarButtonItem){
        let alertController = UIAlertController(title: nil, message: "Custom Tag", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: { (textField) in })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Append", style: .default, handler: { (_) in
            guard let text = alertController.textFields?.first?.text, text.count != 0 else{
                return
            }
            /// Append
            let button = TagButton()
            button.setTitle(text, for: .normal)
            let options = ButtonOptions(
                layerColor: UIColor.brown,
                layerRadius: 10,
                layerWidth: 2,
                tagTitleColor: UIColor(white: 89/255, alpha: 1),
                tagFont: UIFont.boldSystemFont(ofSize: 15),
                tagBackgroundColor: UIColor.white)
            button.setEntity(options)
            self.tagsView.append(button)
            self.makeTagsString()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func lastBarButtonAction(_ sender: UIBarButtonItem){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Custom", style: .default, handler: { (_) in
            let button = TagButton()
            button.setTitle("Add Tags", for: .normal)
            let options = ButtonOptions(
                layerColor: UIColor.orange,
                layerRadius: 10,
                layerWidth: 2,
                tagTitleColor: UIColor.orange,
                tagFont: UIFont.boldSystemFont(ofSize: 15),
                tagBackgroundColor: UIColor.white)
            
            
            button.setEntity(options)
            self.tagsView.lastTagButton(button)
        }))
        
        alertController.addAction(UIAlertAction(title: "Default", style: .default, handler: { (_) in
            self.tagsView.lastTag = "Add"
        }))
        
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            self.tagsView.lastTag = nil
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    @objc private func sliderAction(_ sender: UISlider){
        self.leadingConstraint.constant = CGFloat(sender.value)
        self.tagsView.width = UIScreen.main.bounds.width - (self.leadingConstraint.constant*2)
        
        /// redraw
        self.tagsView.redraw()
    }
    
    @IBAction private func paddingLeftRightAction(_ sender: UIStepper) {
        self.tagsView.paddingLeftRight = CGFloat(sender.value)
    }
    
    @IBAction private func paddingTopBottomAction(_ sender: UIStepper) {
        self.tagsView.paddingTopBottom = CGFloat(sender.value)
    }
    
    @IBAction private func marginLeftRightAction(_ sender: UIStepper) {
        self.tagsView.marginLeftRight = CGFloat(sender.value)
    }
    
    @IBAction private func marginTopBottomAction(_ sender: UIStepper) {
        self.tagsView.marginTopBottom = CGFloat(sender.value)
    }
    
    @IBAction private func fgBlackAction(_ sender: UIButton) {
        self.tagsView.tagTitleColor = UIColor.black
        self.tagsView.tagLayerColor = UIColor.black
    }
    
    @IBAction private func fgGrayAction(_ sender: UIButton) {
        self.tagsView.tagTitleColor = UIColor.gray
        self.tagsView.tagLayerColor = UIColor.gray
    }
    
    @IBAction private func bgWhiteAction(_ sender: UIButton) {
        self.tagsView.tagBackgroundColor = UIColor.white
    }
    
    @IBAction private func bgGrayAction(_ sender: UIButton) {
        self.tagsView.tagBackgroundColor = UIColor.gray
    }
    
    
    @IBAction private func lastFgBlackAction(_ sender: UIButton) {
        self.tagsView.lastTagTitleColor = UIColor.black
        self.tagsView.lastTagLayerColor = UIColor.black
    }
    
    @IBAction private func lastFgGrayAction(_ sender: UIButton) {
        self.tagsView.lastTagTitleColor = UIColor.gray
        self.tagsView.lastTagLayerColor = UIColor.gray
    }
    
    @IBAction private func lastBgWhiteAction(_ sender: UIButton) {
        self.tagsView.lastTagBackgroundColor = UIColor.white
    }
    
    @IBAction private func lastBgGrayAction(_ sender: UIButton) {
        self.tagsView.lastTagBackgroundColor = UIColor.gray
    }
    
    
    
    
    
    
}




extension ViewController: TagsDelegate{
    // MARK: TagsDelegate
    
    
    
    
    /// Last Tag Touch Action
    func tagsLastTagAction(_ tagsView: TagsView, tagButton: TagButton) {
        let alertController = UIAlertController(title: nil, message: "Append Tag", preferredStyle: .alert)
        self.alertController = alertController
        alertController.addTextField(configurationHandler: { (textField) in
            textField.returnKeyType = .next
            textField.delegate = self
            textField.becomeFirstResponder()
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Append", style: .default, handler: { (_) in
            if let textArray = alertController.textFields?.flatMap({ $0.text }).filter({ $0 != ""}){
                /// append
                self.tagsView.append(contentsOf: textArray)
                self.makeTagsString()
            }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    /// Tag Touch Action
    func tagsTouchAction(_ tagsView: TagsView, tagButton: TagButton) {
        /// Update & Delete ActionSheet UIAlertController
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "Update", style: .default, handler: { (_) in
            
            /// Update UIAlertController
            let alertController = UIAlertController(title: nil, message: "Update Tag", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in
                textField.text = tagButton.currentTitle
            })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Update", style: .default, handler: { (_) in
                guard let text = alertController.textFields?.first?.text, text.count != 0 else{
                    return
                }
                /// Update
                tagsView.update(text, at: tagButton.index)
                self.makeTagsString()
            }))
            self.present(alertController, animated: true, completion: nil)
            
        }))
        
        
        alertController.addAction(UIAlertAction(title: "PrevInsert", style: .default, handler: { (_) in
            /// Prev Insert UIAlertController
            let alertController = UIAlertController(title: nil, message: "Prev Insert Tag", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Insert", style: .default, handler: { (_) in
                guard let text = alertController.textFields?.first?.text, text.count != 0 else{
                    return
                }
                /// Insert
                tagsView.insert(text, at: tagButton.index)
                self.makeTagsString()
            }))
            self.present(alertController, animated: true, completion: nil)
        }))
        
        
        alertController.addAction(UIAlertAction(title: "NextInsert", style: .default, handler: { (_) in
            /// Next Insert UIAlertController
            let alertController = UIAlertController(title: nil, message: "Next Insert Tag", preferredStyle: .alert)
            alertController.addTextField(configurationHandler: { (textField) in })
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Insert", style: .default, handler: { (_) in
                guard let text = alertController.textFields?.first?.text, text.count != 0 else{
                    return
                }
                /// Insert
                tagsView.insert(text, at: tagButton.index + 1)
                self.makeTagsString()
            }))
            self.present(alertController, animated: true, completion: nil)
        }))
        
        
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            /// Remove
            tagsView.remove(tagButton)
            self.makeTagsString()
        }))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    /// TagsView Change Height
    func tagsChangeHeight(_ tagsView: TagsView, height: CGFloat) {
        self.heightLabel.text = "height: \(height)"
    }
}






extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let alertController = self.alertController{
            alertController.addTextField(configurationHandler: { (textField) in
                textField.returnKeyType = .next
                textField.delegate = self
                textField.becomeFirstResponder()
            })
        }
        return false
    }
}
