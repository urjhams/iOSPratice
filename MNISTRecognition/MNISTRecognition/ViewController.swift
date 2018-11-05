//
//  ViewController.swift
//  MNISTRecognition
//
//  Created by Quân Đinh on 04.11.18.
//  Copyright © 2018 urjhams. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var canvasView: CanvasView!
    
    var requests = [VNRequest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpVision()
    }
    
    private func setUpVision() {
        guard let visionModel = try? VNCoreMLModel(for: MNIST().model)
        else {
            fatalError("Cannot load vision ML model")
        }
        let classificationRequest = VNCoreMLRequest(model: visionModel, completionHandler: self.handleClassification)
        self.requests = [classificationRequest]
    }
    
    private func handleClassification(request: VNRequest, error: Error?) {
        guard let observations = request.results
        else {
            print("no result")
            return
        }
        let classifications = observations
            .compactMap {$0 as? VNClassificationObservation}
            .filter {$0.confidence > 0.0}
            .map {$0.identifier}
        
        DispatchQueue.main.async {
            self.resultLabel.text = classifications.first
        }
    }

    @IBAction func clearCanvas(_ sender: UIButton) {
        canvasView.clearCanvas()
    }
    
    @IBAction func ewcogDigit(_ sender: UIButton) {
        let image = UIImage(view: canvasView)
        let scaleImg = scaleImage(image: image, toSize: CGSize(width: 28, height: 28))
        
        let imageRequestHandler = VNImageRequestHandler(cgImage: scaleImg.cgImage!, options: [:])
        
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
    }
    
    private func scaleImage(image: UIImage, toSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        return newImg!
    }
}

