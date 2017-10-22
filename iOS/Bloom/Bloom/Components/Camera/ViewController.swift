//
//  ViewController.swift
//  Bloom
//
//  Created by Alec Kretch on 10/21/17.
//  Copyright © 2017 Alec Kretch. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet weak var addCardButton: UIButton! {
        didSet {
            addCardButton.isExclusiveTouch = true
            addCardButton.setTitle("Add Card", for: .normal)
            addCardButton.addTarget(self, action: #selector(onTapAddCardButton), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var needsCardAlertView: UIView! {
        didSet {
            needsCardAlertView.isUserInteractionEnabled = false
            needsCardAlertView.backgroundColor = UIColor.red
            needsCardAlertView.clipsToBounds = true
            needsCardAlertView.layer.cornerRadius = 7.0
        }
    }
    
    @IBOutlet weak var exclamationLabel: UILabel! {
        didSet {
            exclamationLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
            exclamationLabel.textColor = UIColor.white
            exclamationLabel.text = "!"
            exclamationLabel.textAlignment = .center
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openCamera()
        self.view.bringSubview(toFront: self.addCardButton)
        self.view.bringSubview(toFront: self.needsCardAlertView)
        if UserDefaults.standard.string(forKey: "customerId") != nil {
            self.needsCardAlertView.isHidden = true
        }
    }
    
    func openCamera() {
        if let captureDevice = AVCaptureDevice.default(for: .video) {
            do {
                let input: AVCaptureInput! = try AVCaptureDeviceInput(device: captureDevice)
                captureSession = AVCaptureSession()
                captureSession?.addInput(input)
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession?.addOutput(captureMetadataOutput)
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                captureMetadataOutput.metadataObjectTypes = [.qr]
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                videoPreviewLayer?.videoGravity = .resizeAspectFill
                videoPreviewLayer?.frame = view.layer.bounds
                view.layer.addSublayer(videoPreviewLayer!)
                captureSession?.startRunning()
            } catch {
                //TODO handle error
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "AddCardSegue", let addCardViewController = segue.destination as? AddCardViewController {
            addCardViewController.delegate = self
        }
    }
    
    @objc func onTapAddCardButton() {
        performSegue(withIdentifier: "AddCardSegue", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: AVCaptureMetadataOutputObjectsDelegate {
    
}

extension ViewController: AddCardViewControllerDelegate {
    
    func addCardViewControllerAddedCardSuccessfully(_ addCardViewController: AddCardViewController) {
        needsCardAlertView.isHidden = true
    }
    
}
