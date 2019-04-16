//
//  QRCodeGeneratorVC.swift
//  QRCodeDemo
//
//  Created by Hiren Patel on 16/04/19.
//  Copyright © 2019 Hiren Patel. All rights reserved.
//

import UIKit
import EFQRCode

class QRCodeGeneratorVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var qrCodeGeneratorTextView: UITextView!
    @IBOutlet weak var qrCodeImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        qrCodeGeneratorTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func generateQRCode(_ sender: UIButton) {
        if let qrCodeImageCgImage = EFQRCode.generate(content: qrCodeGeneratorTextView.text!) {
            let qrCodeImage = UIImage(cgImage: qrCodeImageCgImage)
            qrCodeImageView.image = qrCodeImage
            UIImageWriteToSavedPhotosAlbum(qrCodeImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
        
    }

    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your Qrcode is generated and It has been saved to your photos.")
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    /* Older versions of Swift */
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
