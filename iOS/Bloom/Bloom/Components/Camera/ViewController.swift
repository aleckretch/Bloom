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

    override func viewDidLoad() {
        super.viewDidLoad()
        openCamera()
        let firstName = "Alec"
        let lastName = "Kretch"
        let phoneNumber = "216-789-5293"
        let emailAddress = "aleckretch@gmail.com"
        let addressLine1 = "35175 Miles Rd."
        let addressCity = "Moreland Hills"
        let addressState = "OH"
        let addressZip = "44022"
        let cardNumber = "5466 3081 3578 2590"
        let cardExpiration = "03/2020"
        AddCardManager.shared.createCustomerInBackground(firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, emailAddress: emailAddress, addressLine1: addressLine1, addressCity: addressCity, addressState: addressState, addressZip: addressZip) { (success, customerId) in
            if success, let userId = customerId {
                AddCardManager.shared.createPaymentAccountInBackground(customerId: userId, cardNumber: cardNumber, cardExpiration: cardExpiration, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, addressLine1: addressLine1, addressCity: addressCity, addressState: addressState, addressZip: addressZip, completion: { (success) in
                    if success {
                        print("CARD ADDED")
                    } else {
                        print("ERROR ADDING CARD")
                    }
                })
            }
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
    
    @objc func onTapAddCardButton() {
        print("Add card")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: AVCaptureMetadataOutputObjectsDelegate {
    
}
