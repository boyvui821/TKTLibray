//
//  CameraViewController.swift
//  TKTLibrary
//
//  Created by Nguyen Hieu Trung on 9/9/20.
//  Copyright © 2020 NHTSOFT. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class CameraViewController: UIViewController {
    @IBOutlet weak var firstHeader: BaseHeaderView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var cameraButtonContainer: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraView: UIView!
    
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var photoOutput: AVCapturePhotoOutput?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupFirstHeader()
        setupFirstHeaderAction()
        setupUI()
        setupVideoPreviewLayer()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidenDefaultNavigation()
        
        self.startScanQRcode()
        //        NotificationCenter.default.addObserver(self, selector:#selector(self.didChangeCaptureInputPortFormatDescription(notification:)), name: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // remove notificationCenter
        //        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVCaptureInputPortFormatDescriptionDidChange, object: nil)
    }
    
    func setupUI(){
        cameraButtonContainer.layer.cornerRadius = 12
        //           scrollView.bounces = false
    }
    
    func setupFirstHeader(){
        firstHeader.setupHeader(title: "Camera",
                                rightIcon: UIImage(named: "iconRotate", in: Bundle(for: CameraViewController.self), compatibleWith: nil),
                                backgroundColor: UIColor.applicationColor,
                                heightConstraint: headerViewHeightConstraint)
        firstHeader.setIconTintColor(color: UIColor.white)
    }
    
    func setupFirstHeaderAction(){
        firstHeader.onHandleLeft {
            self.dismiss(animated: true, completion: nil)
        }
        
        firstHeader.onHandleRight {
            self.switchCamera()
        }
    }
    
    func hidenDefaultNavigation(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func setupVideoPreviewLayer(){
        self.view.layoutIfNeeded()
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            
            
            captureSession = AVCaptureSession()
            // set input cho session
            captureSession?.addInput(input)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.isHighResolutionCaptureEnabled = true
            captureSession?.addOutput(photoOutput!)
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.cameraView.layer.addSublayer(videoPreviewLayer!)
            
            // layer
            let layerRect = self.cameraView.layer.bounds
            self.videoPreviewLayer?.frame = layerRect
             self.videoPreviewLayer?.position = CGPoint(x: layerRect.midX, y: layerRect.midY)
            // Start video capture.
            if self.captureSession?.isRunning == false {
                self.captureSession?.startRunning()
            }
        } catch {
            return
        }
    }
    
    func startScanQRcode() {
        if self.captureSession?.isRunning == false {
            self.captureSession?.startRunning()
        }
    }
    
    func stopScanQRcode() {
        if self.captureSession?.isRunning == true {
            self.captureSession?.stopRunning()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
    
    func switchCamera() {
        if let session = captureSession {
            guard let currentCameraInput: AVCaptureInput = session.inputs.first else {
                return
            }
            //Indicate that some changes will be made to the session
            session.beginConfiguration()
            session.removeInput(currentCameraInput)
            
            //Get new input
            var newCamera: AVCaptureDevice! = nil
            if let input = currentCameraInput as? AVCaptureDeviceInput {
                if (input.device.position == .back) {
                    newCamera = cameraWithPosition(position: .front)
                } else {
                    newCamera = cameraWithPosition(position: .back)
                }
            }
            
            //Add input to session
            var err: NSError?
            var newVideoInput: AVCaptureDeviceInput!
            do {
                newVideoInput = try AVCaptureDeviceInput(device: newCamera)
            } catch let err1 as NSError {
                err = err1
                newVideoInput = nil
            }
            
            if newVideoInput == nil || err != nil {
                print("Error creating capture device input: \(err?.localizedDescription)")
            } else {
                session.addInput(newVideoInput)
            }
            
            //Commit all the configuration changes at once
            session.commitConfiguration()
        }
    }
    
    // Find a camera with the specified AVCaptureDevicePosition, returning nil if one is not found
    func cameraWithPosition(position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        for device in discoverySession.devices {
            if device.position == position {
                return device
            }
        }
        
        return nil
    }
    
    @IBAction func onPressTakePhoto(_ sender: UIButton) {
        // self: AVCapturePhotoCaptureDelegate
        // photoOutput: AVCapturePhotoOutput
        let settings = AVCapturePhotoSettings()
//        let pbpf = settings.availablePreviewPhotoPixelFormatTypes[0]
//        settings.previewPhotoFormat = [
//            kCVPixelBufferPixelFormatTypeKey as String : pbpf,
//            kCVPixelBufferWidthKey as String : 640,
//            kCVPixelBufferHeightKey as String : 480]
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    private func cropToPreviewLayer(originalImage: UIImage) -> UIImage {
        guard let previewLayer = videoPreviewLayer else {return originalImage}
        let outputRect = previewLayer.metadataOutputRectConverted(fromLayerRect: previewLayer.bounds)
        var cgImage = originalImage.cgImage!
        let width = CGFloat(cgImage.width)
        let height = CGFloat(cgImage.height)
        let cropRect = CGRect(x: outputRect.origin.x * width, y: outputRect.origin.y * height, width: outputRect.size.width * width, height: outputRect.size.height * height)
        
        cgImage = cgImage.cropping(to: cropRect)!
        let croppedUIImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: originalImage.imageOrientation)
        return croppedUIImage
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate{
    func sendImageToAnalysis(image: UIImage){
        let imageDataDict:[String: UIImage] = ["image": image]
        NotificationCenter.default.post(name: .loadImageFromCamera,
                                        object: nil,
                                        userInfo: imageDataDict)
        self.dismiss(animated: true, completion: nil)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation() else {return}
        guard let image = UIImage(data: imageData) else {return}
        let cropImage = self.cropToPreviewLayer(originalImage: image)
        let resizeImage = image.resizeImage(image: cropImage, targetSize: CGSize(width: DEFAULT_IMAGE_SIZE,
                                                                             height: DEFAULT_IMAGE_SIZE))
        self.sendImageToAnalysis(image: resizeImage)
    }
    
    func saveToPhotos(image: UIImage){
        PHPhotoLibrary.requestAuthorization { (status) in
            if (status == .authorized){
                do{
                    try PHPhotoLibrary.shared().performChangesAndWait({
                        PHAssetChangeRequest.creationRequestForAsset(from: image)
                    })
                }catch(let error){
                    print("Save photo fail ...")
                }
            }else{
                print("Some thing went wrong with permission ...")
            }
        }
    }
    
}
