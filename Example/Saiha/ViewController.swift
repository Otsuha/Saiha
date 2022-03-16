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
//        let defaultDataSource: [(String, String?)] = [
//            ("dsfadasfd", nil),
//            ("dsfadasfd", nil),
//            ("dsfadasfd", nil),
//            ("dsfadasfd", nil),
//            ("dsfadasfd", nil),
//            ("dsfadasfd", nil),
//            ("dsfadasfd", nil)
//        ]
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
//        SHContentSheetTableView.setWidgeAlignment(alignment: .center)
//        SHContentSheetDefaultTableView.show(title: nil, dataSource: defaultDataSource, selectedIndex: nil, completionHandler: { index in
//            saiha_print(index)
//        }, cancelHandler: nil)
//        SHContentSheetSwitchTableView.show(title: "ddd", dataSource: contentSwitchDataSource, delegate: nil, completionHandler: { dataSource in
//            print(dataSource)
//        }, cancelHandler: nil)

//        SHContentSheetMultipleSelectionTableView.show(title: nil, dataSource: multipleSelectionDataSource, completionHandler: { indexSet in
//            print(indexSet)
//        }, cancelHandler: nil)
//        SHContentSheetDefaultTableView.show(title: "功能标题", dataSource: dataSource, selectedIndex: nil, completionHandler: { index in
//            print(index)
//        }, cancelHandler: nil)
        
//        SHMessageAlertView.show(title: "提示", message: "dsfasfasdfasfadfaf的解放军打了发件埃里克森京东方考虑君安收到了咖啡机考虑萨芬结案率肯德基飞洒懒得看 sfdasdfsf", viewConfiguration: nil, cancelAction: nil) { button in
//            saiha_print("qqqqqqqq")
//        }
        
        SHMessageAlertView.show(title: "dfsfsdf", message: "dsfasfasdfasfadfaf的解放军打了发件埃里克森京东方考虑君安收到了咖啡机考虑萨芬结案率肯德基飞洒懒得看 sfdasdfsf") { label in
            label.textColor = .red
            label.font = .systemFont(ofSize: 20)
        } cancelAction: { button in
            
        } confirmAction: { button in
            
        }

    }
    
}


