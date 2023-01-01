//
//  ScannerHandler.swift
//  home
//
//  Created by Scott Courtney on 12/31/22.
//

import AVFoundation
import CoreImage

class ScannerHandler: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    
    @Published var frame: CGImage?
    private var permissionGranted = false
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private let context = CIContext()
    var previewLayer: AVCaptureVideoPreviewLayer!


    
    override init() {
        super.init()
        checkPermission()
        sessionQueue.async { [unowned self] in
            self.setupCaptureSession()
            self.captureSession.startRunning()
        }
    }
    
    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // The user has previously granted access to the camera.
                permissionGranted = true
                
            case .notDetermined: // The user has not yet been asked for camera access.
                requestPermission()
                
        // Combine the two other cases into the default case
        default:
            permissionGranted = false
        }
    }
    
    func requestPermission() {
        // Strong reference not a problem here but might become one in the future.
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            self.permissionGranted = granted
        }
    }
    
    func setupCaptureSession() {
        let videoOutput = AVCaptureVideoDataOutput()
        
        guard permissionGranted else { return }
        guard let videoDevice = AVCaptureDevice.default(.builtInDualWideCamera,for: .video, position: .back) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)
        
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        captureSession.addOutput(videoOutput)
        
        videoOutput.connection(with: .video)?.videoOrientation = .portrait
        
        let metadataOutput = AVCaptureMetadataOutput()

                if (captureSession.canAddOutput(metadataOutput)) {
                    captureSession.addOutput(metadataOutput)

                    metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                    metadataOutput.metadataObjectTypes = [.qr, .code93, .code128, .code39, .ean8, .ean13]
                } else {
//                    failed()
                    return
                }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = frame as! CGRect
        previewLayer.videoGravity = .resizeAspectFill
        
        
        captureSession.startRunning()
//        self.addMetaDataCaptureOutToSession()
        
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
           captureSession.stopRunning()
        
        for metaData in metadataObjects
                {
                    let decodedData:AVMetadataMachineReadableCodeObject = metaData as! AVMetadataMachineReadableCodeObject
                    print(decodedData.stringValue)
                    print(decodedData.type)
                }

//           if let metadataObject = metadataObjects.first {
//               guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
//               guard let stringValue = readableObject.stringValue else { return }
//               AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
//               found(code: stringValue)
//           }

//           dismiss(animated: true)
       }

       func found(code: String) {
           print(code)
       }

}


extension ScannerHandler: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }

        // All UI updates should be/ must be performed on the main queue.
        DispatchQueue.main.async { [unowned self] in
            self.frame = cgImage
        }
    }

    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        return cgImage
    }
    
}
