

import Foundation
import UIKit

class TUOKOUXIUSwiftTagCollVFlowLay: UICollectionViewFlowLayout {
    
    private weak var tufuh_delegate: UICollectionViewDelegateFlowLayout?
    private var tufuh_itemArr: [UICollectionViewLayoutAttributes] = []
    private var tufuh_contW: CGFloat = 0
    private var tufuh_contH: CGFloat = 0
    
    override init() {
        super.init()
        self.scrollDirection = .horizontal
        self.itemSize = CGSize(width: 100.0, height: 30.0)
        self.minimumInteritemSpacing = 10.0
        self.minimumLineSpacing = 10.0
        self.sectionInset = .zero
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func prepare() {
        super.prepare()
        tufuh_itemArr.removeAll()
        tufuh_contW = sectionInset.left
        tufuh_contH = sectionInset.top + itemSize.height

        var originX = sectionInset.left
        var originY = sectionInset.top

        guard let collectionView = collectionView else { return }
        let itemCount = collectionView.numberOfItems(inSection: 0)

        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let size = tukou_itemSize(for: indexPath)

            if scrollDirection == .vertical {
                if originX + size.width + sectionInset.right > collectionView.frame.width {
                    originX = sectionInset.left
                    originY += size.height + minimumLineSpacing
                    tufuh_contH += size.height + minimumLineSpacing
                }
            } else {
                tufuh_contW += size.width + minimumInteritemSpacing
            }

            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: originX, y: originY, width: size.width, height: size.height)
            tufuh_itemArr.append(attributes)

            originX += size.width + minimumInteritemSpacing
        }

        tufuh_contH += sectionInset.bottom
    }
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        if scrollDirection == .vertical {
            return CGSize(width: collectionView.frame.width, height: tufuh_contH)
        } else {
            return CGSize(width: tufuh_contW, height: collectionView.frame.height)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return tufuh_itemArr
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let oldBounds = collectionView?.bounds else { return false }
        return newBounds.width != oldBounds.width
    }
    private var delegateFlowLayout: UICollectionViewDelegateFlowLayout? {
        if tufuh_delegate == nil {
            tufuh_delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout
        }
        return tufuh_delegate
    }

    private func tukou_itemSize(for indexPath: IndexPath) -> CGSize {
        if let size = delegateFlowLayout?.collectionView?(collectionView!, layout: self, sizeForItemAt: indexPath) {
            self.itemSize = size
        }
        let width = max(itemSize.width, 40)
        return CGSize(width: width, height: itemSize.height)
    }
}
