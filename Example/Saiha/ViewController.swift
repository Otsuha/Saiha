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
        
//        DispatchQueue.main.async {
//            SHProgressView.show()
//            SHProgressView.showWithSignal()
//            SHProgressView.showWithSignal()
//        }
//        DispatchQueue.global().async {
//            Thread.sleep(forTimeInterval: 3)
//            DispatchQueue.main.async {
//                SHProgressView.dismiss()
////                SHProgressView.dismiss()
////                SHProgressView.dismiss()
////                SHProgressView.dismiss()
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapAction(_ sender: Any) {
//        let multipleSelectionDataSource: [(String, String?, Bool)] = [
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, true),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, true),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, true),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false)
//        ]
//        let contentSwitchDataSource: [(String, String?, Bool)] = [
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, true),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, true),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, true),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false),
//            ("dsfadasfd", nil, false)
//        ]
//        SHContentSheetTableView.setActionTitle("保存")
//        SHContentSheetTableView.setDefaultShowCount(count: 6)
//        SHContentSheetTableView.showSeparator(show: false)
//        SHContentSheetSwitchTableView.show(title: "ddd", dataSource: contentSwitchDataSource, delegate: nil, completionHandler: { dataSource in
//            print(dataSource)
//        }, cancelHandler: nil)

//        SHContentSheetMultipleSelectionTableView.show(title: nil, dataSource: multipleSelectionDataSource, completionHandler: { indexSet in
//            print(indexSet)
//        }, cancelHandler: nil)
//        SHContentSheetDefaultTableView.show(title: "功能标题", dataSource: dataSource, selectedIndex: nil, completionHandler: { index in
//            print(index)
//        }, cancelHandler: nil)
        
        SHAlertView.show(title: "ddddddd") { alertView in
            alertView.addLabel(text: "ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd") { label in
            }
            
            alertView.addTextField(placeholder: "sfsfsdfsdf") { textField in
                textField.placeholder = "sfsfsdfsdf"
            }
            
            alertView.addAction(title: "取消") { button in
                button.setTitleColor(UIColor.gray, for: .normal)
            } completionHandler: {
                print("点击了取消")
            }
            alertView.addAction(title: "确定") { button in

            } completionHandler: {
                print("点击了确定")
                print(alertView.textFieldSave.first?.text)
            }
//            alertView.addAction(title: "dddd") { button in
//
//            } completionHandler: {
//
//            }

        }
    }
    
}


