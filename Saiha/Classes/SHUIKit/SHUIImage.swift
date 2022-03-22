//
//  SHUIImage.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2022/3/22.
//

import Foundation
import UIKit
import Photos

public extension UIImage {
    
    static func saiha_image(name: String, in bundle: Bundle) -> UIImage? {
        let image: UIImage? = UIImage(named: name, in: bundle, compatibleWith: nil)
        image?.withRenderingMode(.alwaysOriginal)
        return image
    }
    
    static func saiha_image(name: String, in bundle: Bundle, compatibleWith: UITraitCollection? = nil, with renderingMode: UIImage.RenderingMode = .alwaysOriginal) -> UIImage? {
        let image: UIImage? = UIImage(named: name, in: bundle, compatibleWith: compatibleWith)
        image?.withRenderingMode(renderingMode)
        return image
    }
}

extension UIImage {
    
    static func saiha_imageInSaihaBundle(name: String) -> UIImage? {
        let image: UIImage? = UIImage.saiha_image(name: name, in: Bundle.saihaBundle())
        return image
    }
}

extension UIImage {
    
    public func saiha_writeToSavedPhotosAlbum(completionHandler: @escaping ((_ success: Bool, _ error: Error?) -> Void)) {
        PHPhotoLibrary.shared().performChanges {
            PHAssetChangeRequest.creationRequestForAsset(from: self)
        } completionHandler: { success, error in
            if success {
                completionHandler(true, nil)
            } else {
                completionHandler(false, error)
            }
        }
    }
}
