//
//  ViewController.swift
//  ImageOverlay
//
//  Created by Lakshmi Narayanan N on 12/12/17.
//  Copyright © 2017 Lakshmi Narayanan N. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var imageView: UIImageView!
    let imagePicker = UIImagePickerController()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        dateFormatter.dateFormat = "dd/MM/YYYY, hh:mm s"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func galleryButtonAction(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            var dateString = dateFormatter.string(from: Date())
            if info[UIImagePickerControllerMediaMetadata] != nil {
                dateString = dateFormatter.string(from: Date())
            }
            
            let image = addTimeStampForImage(pickedImage, timeStamp: dateString as NSString)
            imageView.image = image
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func addTimeStampForImage(_ image: UIImage, timeStamp: NSString) -> UIImage {
        let scale = UIScreen.main.scale
        
        let textFontAttributes = [
            NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 30 * scale)!,
            NSAttributedStringKey.foregroundColor: UIColor.white,
            ]
        
        UIGraphicsBeginImageContext(image.size)
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))
        
        let dateWidth: CGFloat = timeStamp.size(withAttributes: textFontAttributes).width
        let dateHeight: CGFloat = timeStamp.size(withAttributes: textFontAttributes).height
        let datePadding: CGFloat = 15 * scale;
        timeStamp.draw(at: CGPoint(x: image.size.width - dateWidth - datePadding, y: image.size.height - dateHeight - datePadding), withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

