//
//  SHAddPhotoView.swift
//  Saiha
//
//  Created by 御前崎悠羽 on 2021/11/6.
//

import UIKit
import SnapKit

// MARK: - SHAddPhotoCollectionCell.

class SHAddPhotoCollectionCell: UICollectionViewCell {
    
    // 默认设置 cell 的大小为 100，所有的约束以 100 为基准做比例缩放。
    private let defaultSize: CGFloat = CGFloat.saiha.levelSize(num: 100)
    var aCellSize: CGFloat = CGFloat.saiha.levelSize(num: 100) {
        didSet {
            self.setNeedsLayout()
        }
    }
    private var ratio: CGFloat {
        return self.aCellSize / self.defaultSize
    }
    
    private var addImageView: UIImageView!
    private var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addImageView = UIImageView()
        self.addImageView.image = UIImage(named: "camera_add")
        self.addImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.addImageView)
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "添加照片"
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = UIColor.saiha.colorWithHexString("#858B9C")
        self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 12))
        self.contentView.addSubview(self.titleLabel)
        
        self.contentView.layer.cornerRadius = 2
        self.contentView.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.contentView.layer.shadowColor = UIColor(red: 197.0 / 255.0, green: 202.0 / 255.0, blue: 213.0 / 255.0, alpha: 0.25).cgColor
        self.contentView.layer.shadowOpacity = 1
        self.contentView.layer.shadowRadius = 10
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor(red: 235.0 / 255.0, green: 235.0 / 255.0, blue: 235.0 / 255.0, alpha: 1.0).cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        if self.addImageView != nil {
            self.addImageView.snp.remakeConstraints { make in
                make.left.equalToSuperview().offset(CGFloat.saiha.levelSize(num: 38) * self.ratio)
                make.right.equalToSuperview().offset(CGFloat.saiha.levelSize(num: -38) * self.ratio)
                make.top.equalToSuperview().offset(CGFloat.saiha.verticalSize(num: 26) * self.ratio)
                make.centerX.equalToSuperview()
            }
        }
        if self.titleLabel != nil {
            self.titleLabel.snp.remakeConstraints { make in
                make.left.lessThanOrEqualToSuperview()
                make.right.greaterThanOrEqualToSuperview()
                make.centerX.equalToSuperview()
                make.top.equalTo(self.addImageView.snp.bottom).offset(CGFloat.saiha.verticalSize(num: 12))
            }
        }
    }
}

// MARK: - SHAddPhotoView.

open class SHAddPhotoView: SHUIView {
    
    private var photoCollectionView: SHUICollectionView!
    
    open var photos: [String] = [""]
    
    private func initialize() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CGFloat.saiha.levelSize(num: 100), height: CGFloat.saiha.verticalSize(num: 100))
        layout.sectionInset.left = CGFloat.saiha.levelSize(num: 10)
        layout.sectionInset.right = CGFloat.saiha.levelSize(num: 10)
        layout.sectionInset.top = CGFloat.saiha.verticalSize(num: 10)
        layout.sectionInset.bottom = CGFloat.saiha.verticalSize(num: 10)
        layout.minimumInteritemSpacing = CGFloat.saiha.levelSize(num: 10)
        layout.minimumLineSpacing = CGFloat.saiha.verticalSize(num: 10)
        self.photoCollectionView = SHUICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.photoCollectionView.register(SHAddPhotoCollectionCell.self, forCellWithReuseIdentifier: "PhotoCell")
        self.photoCollectionView.dataSource = self
        self.photoCollectionView.delegate = self
        self.addSubview(self.photoCollectionView)
        self.photoCollectionView.snp.remakeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
}

// MARK: - UICollectionViewDataSource.

extension SHAddPhotoView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SHAddPhotoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! SHAddPhotoCollectionCell
        return cell
    }
}

// MARK: - UICollectionViewDelegate.

extension SHAddPhotoView: UICollectionViewDelegate {
    
}
