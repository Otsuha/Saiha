//
//  SHUIImageView.swift
//  Saiha
//
//  Created by 河瀬雫 on 2021/12/23.
//

import Foundation
import SDWebImage
import UIKit

public extension UIImageView {
    
    func saiha_loadImage(with url: String) {
        guard let url = URL.init(string: url) else {
            return
        }
        self.sd_setImage(with: url, completed: nil)
    }
    
}

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
