//
//  ScanTicketVC.swift
//  MoTiv
//
//  Created by IOS on 30/11/18.
//  Copyright © 2018 MoTiv. All rights reserved.
//

import AVFoundation
import UIKit

class ScanTicketVC: BaseVC {
    
    //MARK: Variables
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrameView:UIView?
    var selectedIndex = Int()
    var ticketCode = String()
    var previousScreen : PreviousScreen = .main
    
    //MARk: Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        handleQRScanning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customiseUI()
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    //MARK: Private Functions
    
    func setDataForScan() -> JSONDictionary {
        var dict = JSONDictionary()
        dict[APIKeys.kEventID] = previousScreen == .checkin ? EventVM.shared.checkInEventDetailArray?[selectedIndex].eventID : EventVM.shared.eventDetailArray?[selectedIndex].eventID
        dict[APIKeys.kTicketCode] = ticketCode
        return dict
    }
    
    func handleQRScanning() {
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
        
        //Add frame on QRCode
        qrCodeFrameView = UIView()
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.black.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
    }
    
    func failed() {
        showAlert(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", cancelTitle: nil, cancelAction: nil, okayTitle: kOkay) {
            self.captureSession = nil
        }
    }
    
    func found(code: String) {
        self.ticketCode = code
        print(code)
        callApiToScanTicket()
    }
    
    private func customiseUI() {
        setTitle(title: kScanTicket)
    }
}

extension ScanTicketVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        self.captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            self.found(code: stringValue)
        }
        self.dismiss(animated: true)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

//API Methods
extension ScanTicketVC {
    func callApiToScanTicket(){
        EventVM.shared.scanTicket(dict: setDataForScan()){ (message, error) in
            if error != nil{
                self.showErrorMessage(error: error)
                self.viewDidLoad()
            } else{
                self.showAlert(title: nil, message: "Ticket scanned successfully.", cancelTitle: nil, cancelAction: nil, okayTitle: kOkay, {
                    self.showAlert(title: nil, message: "SCAN ANOTHER TICKET", cancelTitle: kYes, cancelAction: {
                        self.viewDidLoad()
                    }, okayTitle: kNo, {
                        self.navigationController?.popViewController(animated: true)
                    })
                })
            }
        }
    }
}
