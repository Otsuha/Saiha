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
    private var photoImageView: UIImageView!
    
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
        self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 12) * self.ratio)
        self.contentView.addSubview(self.titleLabel)
        
        self.photoImageView = UIImageView()
        self.photoImageView.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.photoImageView)
        self.photoImageView.isHidden = true
        
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
                make.top.equalToSuperview().offset(CGFloat.saiha.verticalSize(num: 26) * self.ratio)
                make.left.equalToSuperview().offset(CGFloat.saiha.levelSize(num: 38) * self.ratio)
                make.right.equalToSuperview().offset(CGFloat.saiha.levelSize(num: -38) * self.ratio)
                make.bottom.equalToSuperview().offset(CGFloat.saiha.verticalSize(num: -50) * self.ratio)
            }
        }
        if self.titleLabel != nil {
            self.titleLabel.font = .systemFont(ofSize: CGFloat.saiha.verticalSize(num: 12) * self.ratio)
            self.titleLabel.snp.remakeConstraints { make in
                make.left.lessThanOrEqualToSuperview().offset(CGFloat.saiha.levelSize(num: 26) * self.ratio)
                make.centerX.equalToSuperview().priority(.high)
                make.right.greaterThanOrEqualToSuperview().offset(CGFloat.saiha.levelSize(num: -26) * self.ratio)
                make.top.equalTo(self.addImageView.snp.bottom).offset(CGFloat.saiha.verticalSize(num: 12) * self.ratio)
                make.bottom.greaterThanOrEqualToSuperview().offset(CGFloat.saiha.verticalSize(num: -22) * self.ratio)
            }
        }
        if self.photoImageView != nil {
            self.photoImageView.snp.remakeConstraints { make in
                make.left.right.top.bottom.equalToSuperview()
            }
        }
    }
    
    func setImage(image: UIImage?) {
        if image == nil {
            self.photoImageView.image = nil
            self.photoImageView.isHidden = true
        } else {
            self.photoImageView.image = image
            self.photoImageView.isHidden = false
        }
    }
}

// MARK: - SHAddPhotoViewDelegate.

@objc public protocol SHAddPhotoViewDelegate {
    
    /**
     如果未实现此方法，则点击相框默认调出相机拍摄相片，拍摄的相片保存在内存中，可以通过 `getPhoto:from:` 方法获取拍摄的相片。
     并且在拍摄照片后会自动在 `maxPhotos` 范围内动态增加空相框。
     如果实现此方法，则默认为空方法，点击相框将无任何效果。可以通过 `addEmptyPhoto:` 方法手动增加空相框。
     */
    @objc optional func addPhotoView(addPhotoView: SHAddPhotoView, didSelectItemAt index: Int)
    
    @objc optional func addPhotoView(addPhotoView: SHAddPhotoView, didTouchRemoveButtonAt index: Int)
}

// MARK: - SHAddPhotoView.

open class SHAddPhotoView: SHUIView {
    
    private var photoCollectionView: SHUICollectionView!
    
    private var photos: [UIImage?] = [nil]
    
    open var maxPhotos: Int = 10
    
    /// 设置每个相框的边长。
    open var itemEdge: CGFloat = CGFloat.saiha.verticalSize(num: 100) {
        didSet {
            (self.photoCollectionView.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = CGSize(width: self.itemEdge, height: self.itemEdge)
        }
    }
    
    private var currentSelectIndex: Int = 0
    
    weak var delegate: SHAddPhotoViewDelegate?
    
    /// 如果需要动态拓展视图高度，可以用此属性计算视图高度来对视图做约束。
    open var viewHeight: CGFloat {
        get {
            let count: Int = self.photos.count
            let row: Int = (count - 1) / 3 + 1
            return (self.itemEdge + 10) * CGFloat(row) + 10
        }
    }
    
    open var enableScroll: Bool = false {
        didSet {
            self.photoCollectionView.isScrollEnabled = self.enableScroll
        }
    }
    
    private func initialize() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.itemEdge, height: self.itemEdge)
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
    
    /**
     获取指定序号的相片。
     
     - Parameters:
        - from: 序号。
     
     - Returns: 返回存储在内存中的相片原片。若返回 `nil`，则代表指定的是一个空相框或该序号是一个无效的序号。
     */
    open func getPhoto(from index: Int) -> UIImage? {
        return self.photos[index]
    }
    
    /**
     增加一个空相框。
     
     - Important: 若调用该方法时，照片数量 + 空相框数量 = `maxPhotos`，则调用此方法不会有任何效果。
     */
    open func addEmptyPhoto() {
        if self.photos.count <= self.maxPhotos {
            self.photos.append(nil)
            let r1: Int = self.photos.count - 1
            let r2: Int = self.photos.count - 2
            if r1 < self.photos.count {
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadItems(at: [IndexPath(item: r1, section: 0)])
                }
            }
            if r2 < self.photos.count {
                DispatchQueue.main.async {
                    self.photoCollectionView.reloadItems(at: [IndexPath(item: r2, section: 0)])
                }
            }
        }
    }
}

// MARK: - UICollectionViewDataSource.

extension SHAddPhotoView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SHAddPhotoCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! SHAddPhotoCollectionCell
        cell.aCellSize = self.itemEdge
        cell.setImage(image: self.photos[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate.

extension SHAddPhotoView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            self.delegate?.addPhotoView?(addPhotoView: self, didSelectItemAt: indexPath.row)
        } else {
            self.currentSelectIndex = indexPath.row
            let imagePicker: UIImagePickerController = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.isEditing = true
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.modalPresentationStyle = .fullScreen
            imagePicker.cameraCaptureMode = .photo
            UIViewController.saiha.currentActivityViewController()?.present(imagePicker, animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate.

extension SHAddPhotoView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image: UIImage = info[.editedImage] as! UIImage
        self.photos[self.currentSelectIndex] = image
        if self.currentSelectIndex == self.photos.count - 1 {
            self.addEmptyPhoto()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
