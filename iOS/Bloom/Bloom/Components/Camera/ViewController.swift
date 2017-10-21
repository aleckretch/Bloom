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
        // Do any additional setup after loading the view, typically from a nib.
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
