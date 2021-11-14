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
        
//        let photoView: SHAddPhotoView = SHAddPhotoView()
//        photoView.itemEdge = CGFloat.saiha.verticalSize(num: 100)
//        self.view.addSubview(photoView)
//        photoView.snp.makeConstraints { make in
//            make.left.right.top.bottom.equalTo(self.view.snp.margins)
//        }
        
//        let sidebarView: SHSideBarTableView = SHSideBarTableView()
//        sidebarView.models = [
//            SHSideBarTableView.SHSideBarDataModel(header: "111", contents: [
//                SHSideBarTableView.SHSideBarDataCellModel(title: "aaa", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "bbb", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "ccc", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "ddd", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "eee", detail: nil, image: nil)
//            ]),
//            SHSideBarTableView.SHSideBarDataModel(header: "222", contents: [
//                SHSideBarTableView.SHSideBarDataCellModel(title: "fff", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "ggg", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "hhh", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "iii", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "jjj", detail: nil, image: nil)
//            ]),
//            SHSideBarTableView.SHSideBarDataModel(header: "333", contents: [
//                SHSideBarTableView.SHSideBarDataCellModel(title: "kkk", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "lll", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "mmm", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "nnn", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "ooo", detail: nil, image: nil)
//            ]),
//            SHSideBarTableView.SHSideBarDataModel(header: "444", contents: [
//                SHSideBarTableView.SHSideBarDataCellModel(title: "ppp", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "qqq", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "rrr", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "sss", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "ttt", detail: nil, image: nil)
//            ]),
//            SHSideBarTableView.SHSideBarDataModel(header: "555", contents: [
//                SHSideBarTableView.SHSideBarDataCellModel(title: "uuu", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "vvv", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "www", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "xxx", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "yyy", detail: nil, image: nil),
//                SHSideBarTableView.SHSideBarDataCellModel(title: "zzz", detail: nil, image: nil)
//            ])
//        ]
//        sidebarView.dataSourceHandle = { cell, indexPath in
//            cell.textLabel?.text = sidebarView.models[indexPath.section].contents[indexPath.row].title
//        }
//        sidebarView.layer.cornerRadius = 20
//        sidebarView.clipsToBounds = true
//        self.view.addSubview(sidebarView)
//        sidebarView.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(20)
//            make.right.equalToSuperview().offset(-20)
//            make.top.equalToSuperview().offset(90)
//            make.bottom.equalToSuperview().offset(-90)
//        }
        
        SHContentSwitchSheetView.show(title: "标题实例", dataSource: [(nil, "111", true), (nil, "222", false), (nil, "333", true)], contentHeight: nil) {
            print("点击了取消")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

