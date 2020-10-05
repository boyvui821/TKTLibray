//
//  AnalysisViewController.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/8/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit

public class AnalysisViewController: BaseViewController {
    
    @IBOutlet weak var firstHeader: BaseHeaderView!
    
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    
    @IBOutlet weak var scrollContentConstraintHeight: NSLayoutConstraint!
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var selectionView: SelectionView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var imageBase64: String = ""
    var imgPhoto: UIImage?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupFirstHeader()
        setupFirstHeaderAction()
        setupUI()
        addListener()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = uploadButton.frame.origin.y + uploadButton.frame.height + 30
        scrollContentConstraintHeight.constant = height
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidenDefaultNavigation()
    }
    
    func addListener(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.loadImageFromCamera(_:)),
            name: .loadImageFromCamera,
            object: nil
        )
    }
    
    @objc func loadImageFromCamera (_ notification: NSNotification) {
        if let image = notification.userInfo?["image"] as? UIImage {
            self.photoImageView.image = image
            self.imageBase64 = self.convertToBase64(image: image) ?? ""
            self.imgPhoto = image
        }
    }
    
    func setupUI(){
        uploadButton.layer.cornerRadius = uploadButton.bounds.height/2
        scrollView.bounces = false
        
        selectionView.delegate = self
    }
    
    func setupFirstHeader(){
        firstHeader.setupHeader(title: "A.I Skin Analysis",
                                rightIcon: nil,
                                backgroundColor: UIColor.applicationColor,
                                heightConstraint: headerViewHeightConstraint)
    }
    
    func setupFirstHeaderAction(){
        firstHeader.onHandleLeft {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func hidenDefaultNavigation(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func convertToBase64(image: UIImage) ->String?{
        guard let imageData = image.jpegData(compressionQuality: 1) else {return nil}
        let strBase64 = imageData.base64EncodedString(options: [])
        return strBase64
    }
    
    func showAlert(title:String, message:String){
        UIAlertController.show(title: title, message: message) { (index) in }
    }
    
    @IBAction func onPressUpload(_ sender: UIButton) {
        
        if (self.imageBase64.isEmpty){
            self.showAlert(title: "Error",
                           message: "Please take your photo or choose photo from gallery!")
        }else{
            
            if (self.imageBase64.isEmpty == false){
                self.showLoading()
                TKTCLoud.shared.executeUpload(imageBase64: self.imageBase64) { (json, error) in
                    DispatchQueue.main.async {
                        self.hideLoading()
                    }

                    if (error != nil){
                        DispatchQueue.main.async {
                            self.showAlert(title: "Error",
                                           message: error?.localizedDescription ?? "")
                        }

                        return
                    }

                    guard let json = json else {return}
                    let model = UserSkinModel(JSON: json)
                    DispatchQueue.main.async {
                        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController{
                            vc.userSkinModel = model
                            vc.strImageUrl = model?.faceData?.imageInfo?.url
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                }
            }
        }
    }
}

extension AnalysisViewController: SelectionViewDelegate{
    public func onSelect(index: Int) {
        if (index == 0){
            if let vc = storyboard?.instantiateViewController(withIdentifier:  "CameraViewController") as? CameraViewController{
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            ImagePicker.shared.show(sourceView: nil) { [weak self] (image) in
                guard let image = image else {return}
                self?.photoImageView.image = image
                let resizeImage = image.resizeImage(image: image, targetSize: CGSize(width: DEFAULT_IMAGE_SIZE,
                                                                                     height: DEFAULT_IMAGE_SIZE))
                self?.imageBase64 = self?.convertToBase64(image: resizeImage) ?? ""
            }
        }
    }
}
