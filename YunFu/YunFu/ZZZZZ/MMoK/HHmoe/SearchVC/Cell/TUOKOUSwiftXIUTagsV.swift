

import Foundation
import UIKit
import SnapKit

class TUOKOUSwiftXIUTagsV: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tufuh_tagArr: [String] = []
    var tufuh_layout: TUOKOUXIUSwiftTagCollVFlowLay!
    
    var tufuh_clkItemBlk: ((_ selectTags: [String], _ currentIndex: Int) -> Void)?
    
    private var tufuh_tagAttO: TUOKOUXIUSSTagAttri!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        tukou_creatrV()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tukou_creatrV()
    }
    
    lazy var tufuh_collV: UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.tufuh_layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = TUOKOUXIUSwiftwuseC
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUTagCollVDefCellId")
        collectionView.register(TUOKOUXIUSSTagCollVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUTagCollVCellId")
        collectionView.contentInset = .zero
        
        if self.tufuh_layout.scrollDirection == .vertical {
            collectionView.showsVerticalScrollIndicator = true
            collectionView.showsHorizontalScrollIndicator = false
        } else {
            collectionView.showsHorizontalScrollIndicator = true
            collectionView.showsVerticalScrollIndicator = false
        }
        collectionView.indicatorStyle = .white
        return collectionView
    }()
    
    private func tukou_creatrV() {
        tufuh_tagAttO = TUOKOUXIUSSTagAttri()
        tufuh_layout = TUOKOUXIUSwiftTagCollVFlowLay()
        
        addSubview(tufuh_collV)
        tufuh_collV.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets.zero)
        }
    }
    
    func tukou_reloData() {
        tufuh_collV.reloadData()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tufuh_collV.frame = bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tufuh_tagArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tufuh_tagArr.isEmpty {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUTagCollVDefCellId", for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUTagCollVCellId", for: indexPath) as! TUOKOUXIUSSTagCollVCell
        cell.backgroundColor = tufuh_tagAttO.tufuh_norBackgCo
        cell.layer.borderColor = tufuh_tagAttO.tufuh_borderCo.cgColor
        cell.layer.cornerRadius = tufuh_tagAttO.tufuh_corRa
        cell.layer.borderWidth = tufuh_tagAttO.tufuh_borW
        cell.tufuh_titL.textColor = tufuh_tagAttO.tufuh_textCo
        cell.tufuh_titL.font = TUOKOUXIUSwiftFont.regular(tufuh_tagAttO.tufuh_titF)
        cell.tufuh_titL.text = tufuh_tagArr[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard !tufuh_tagArr.isEmpty else { return CGSize(width: 0, height: 0) }
        
        guard let layout = collectionView.collectionViewLayout as? TUOKOUXIUSwiftTagCollVFlowLay else {
            return .zero
        }
        
        let maxSize = CGSize(width: collectionView.frame.width - layout.sectionInset.left - layout.sectionInset.right,
                             height: layout.itemSize.height)
        
        let text = tufuh_tagArr[indexPath.item] as NSString
        let frame = text.boundingRect(
            with: maxSize,
            options: [.usesFontLeading, .usesLineFragmentOrigin],
            attributes: [.font: TUOKOUXIUSwiftFont.regular(tufuh_tagAttO.tufuh_titF)],
            context: nil
        )
        
        return CGSize(width: frame.width + tufuh_tagAttO.tufuh_tagSpa, height: layout.itemSize.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !tufuh_tagArr.isEmpty else { return }
        tufuh_clkItemBlk?(tufuh_tagArr, indexPath.item)
    }
}
