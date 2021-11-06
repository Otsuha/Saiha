//
//  ViewController.swift
//  Saiha
//
//  Created by sylvia-grass on 11/06/2021.
//  Copyright (c) 2021 sylvia-grass. All rights reserved.
//

import UIKit
import Saiha
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let photoView: SHAddPhotoView = SHAddPhotoView()
        self.view.addSubview(photoView)
        photoView.snp.remakeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

