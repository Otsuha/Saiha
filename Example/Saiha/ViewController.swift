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
        
//        SHMessageAlertView.show(title: "提示", message: "dfadafsafads") { messageAlertView in
//            messageAlertView.cancelButton.setTitleColor(.gray, for: .normal)
//            messageAlertView.cancelButton.setTitle("dsfsdf", for: .normal)
//        } cancelAction: {
//
//        } confirmAction: {
//            saiha_print("dfsfasfadf")
//        }

//        SHSingleButtonMessageAlertView.show(title: "提示", message: "dfadafsafads") { singleButtonMessageAlertView in
//            singleButtonMessageAlertView.confirmButton.setTitleColor(.gray, for: .normal)
//            singleButtonMessageAlertView.confirmButton.setTitle("dsfsdf", for: .normal)
//        } confirmAction: {
//
//        }
        
//        SHInputAlertView.show(title: nil, placeholder: "dddddd") { inputAlertView in
//
//        } cancelAction: {
//
//        } confirmAction: { inputAlertView in
//            print(inputAlertView.textField.text!)
//        }
        
        SHInputAlertView.show(title: "请输入手机号", placeholder: "请输入手机号", regular: "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$", warnTip: "手机号不正确", viewConfiguration: nil) {
            
        } confirmAction: { inputAlertView in
            saiha_print("点击了确认")
        }


//        SHSingleButtonMessageAlertView.show(title: "nil", message: "1、注释：当共配中心的快件包含了多家快递品牌，且部分需发往下一站（做发件），部分快件本站直接派送（做派件）时，适用于发派混扫功能；\n2、使用：未选择的快递品牌运单扫描类型为派件，选择的快递品牌及其下一站，运单扫描类型则为发件。") { messageAlertView in
//            messageAlertView.confirmButton.setTitle("我知道了", for: .normal)
//            messageAlertView.confirmButton.setTitleColor(.red, for: .normal)
//            messageAlertView.label.textAlignment = .left
//            messageAlertView.touchBackgroundToCancel = true
//        } confirmAction: {
//            saiha_print("点击了确认")
//        }


    }
    
}
