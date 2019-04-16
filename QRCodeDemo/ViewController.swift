//
//  ViewController.swift
//  QRCodeDemo
//
//  Created by Hiren Patel on 16/04/19.
//  Copyright © 2019 Hiren Patel. All rights reserved.
//

import UIKit
import SnapKit
import LZViewPager

class ViewController: UIViewController, LZViewPagerDelegate, LZViewPagerDataSource {
    
    @IBOutlet weak var viewPager: LZViewPager!
    private var subControllers:[UIViewController] = []
    
    func numberOfItems() -> Int {
        return self.subControllers.count
    }
    
    func controller(at index: Int) -> UIViewController {
        return subControllers[index]
    }
    
    func button(at index: Int) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(UIColor.black, for: .selected)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .normal)
        return button
    }
    
    func colorForIndicator(at index: Int) -> UIColor {
        //        return UIColor.blue.withAlphaComponent(CGFloat(index) / 4.0)
        return UIColor.blue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let qrCodeGeneratorVC = UIViewController.createFromNib(storyBoardId: "QRCodeGeneratorVC")!
        qrCodeGeneratorVC.title = "Generate QR Code"
        
        let qrCodeReaderVC = UIViewController.createFromNib(storyBoardId: "QRCodeReaderVC")!
        qrCodeReaderVC.title = "Read QR Code"

        subControllers = [qrCodeGeneratorVC, qrCodeReaderVC]
        viewPager.hostController = self
        viewPager.reload()
    }
    
    func willTransition(to index: Int) {
        print("Current index before transition: \(viewPager.currentIndex ?? -1)")
    }
    
    func didTransition(to index: Int) {
        print("Current index after transition: \(viewPager.currentIndex ?? -1)")
    }
    
    func didSelectButton(at index: Int) {
        print("Current index before transition: \(viewPager.currentIndex ?? -1)")
        print("Current index after transition: \(index)")
    }
    
    @IBAction func nextPageAction(_ sender: UIBarButtonItem) {
        guard let currentIndex = viewPager.currentIndex else { return }
        let nextIndex = currentIndex + 1 > self.numberOfItems() - 1 ? 0 : currentIndex + 1
        viewPager.select(index: nextIndex, animated: true)
    }
    
}
extension UIViewController {
    static func createFromNib<T: UIViewController>(storyBoardId: String) -> T?{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyBoardId) as? T
    }
}
