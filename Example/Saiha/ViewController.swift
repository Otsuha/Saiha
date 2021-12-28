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
    
    private var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapAction(_ sender: Any) {
        let dataSource: [(String, String?)] = [
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil),
            ("dsfadasfd", nil)
        ]
        SHContentSheetTableView.setActionTitle("保存")
        SHContentSheetTableView.setDefaultShowCount(count: 6)
        SHContentSheetTableView.showSeparator(show: false)
//        SHContentSheetTableView.show(title: "dddddd", dataSource: dataSource, style: .default(completionHandler: { index in
//
//        }, cancelHandler: nil))
        SHContentSheetTableView.show(title: "功能标题", dataSource: dataSource, style: .multipleSelection(completionHandler: { indexSet in
            print(indexSet)
        }, cancelHandler: nil))
    }
}

