
import Foundation
import UIKit

class TUOKOUXIUSwiftCycPagVLayout: NSObject {
    var itemSize: CGSize = .zero
    var tufuh_itemSpac: CGFloat = 0
    var tufuh_sectIns: UIEdgeInsets = .zero

    var tufuh_minimSca: CGFloat = 0.8
    var tufuh_minimAlp: CGFloat = 1.0
    var tufuh_maximAng: CGFloat = 0.2
    var tufuh_ratOfChan: CGFloat = 0.4
    var tufuh_adjSpaWhenScr: Bool = true

    var tufuh_itemVertCen: Bool = true
    var tufuh_itemHorCen: Bool = false

    weak var tufuh_pageV: UIView?
    override init() {
        self.tufuh_itemVertCen = true
        self.tufuh_minimSca = 0.8
        self.tufuh_minimAlp = 1.0
        self.tufuh_maximAng = 0.2
        self.tufuh_ratOfChan = 0.4
        self.tufuh_adjSpaWhenScr = true
    }
    var onlyOneSectionInset: UIEdgeInsets {
        let leftSpace = tufuh_sectIns.left
        let rightSpace = tufuh_sectIns.right
        if tufuh_itemVertCen, let pageV = tufuh_pageV {
            let verticalSpace = (pageV.frame.height - itemSize.height) / 2
            return UIEdgeInsets(top: verticalSpace, left: leftSpace, bottom: verticalSpace, right: rightSpace)
        }
        return UIEdgeInsets(top: tufuh_sectIns.top, left: leftSpace, bottom: tufuh_sectIns.bottom, right: rightSpace)
    }
    var firstSectionInset: UIEdgeInsets {
        if tufuh_itemVertCen, let pageV = tufuh_pageV {
            let verticalSpace = (pageV.frame.height - itemSize.height) / 2
            return UIEdgeInsets(top: verticalSpace, left: tufuh_sectIns.left, bottom: verticalSpace, right: tufuh_itemSpac)
        }
        return UIEdgeInsets(top: tufuh_sectIns.top, left: tufuh_sectIns.left, bottom: tufuh_sectIns.bottom, right: tufuh_itemSpac)
    }
    var lastSectionInset: UIEdgeInsets {
        if tufuh_itemVertCen, let pageV = tufuh_pageV {
            let verticalSpace = (pageV.frame.height - itemSize.height) / 2
            return UIEdgeInsets(top: verticalSpace, left: 0, bottom: verticalSpace, right: tufuh_sectIns.right)
        }
        return UIEdgeInsets(top: tufuh_sectIns.top, left: 0, bottom: tufuh_sectIns.bottom, right: tufuh_sectIns.right)
    }
    var middleSectionInset: UIEdgeInsets {
        if tufuh_itemVertCen, let pageV = tufuh_pageV {
            let verticalSpace = (pageV.frame.height - itemSize.height) / 2
            return UIEdgeInsets(top: verticalSpace, left: 0, bottom: verticalSpace, right: tufuh_itemSpac)
        }
        return tufuh_sectIns
    }
}

class TUOKOUXIUSwiftCycPagTransLay: UICollectionViewFlowLayout {
    var layoutConfig: TUOKOUXIUSwiftCycPagVLayout? {
        didSet {
            if let config = layoutConfig {
                config.tufuh_pageV = collectionView
                self.itemSize = config.itemSize
                self.minimumInteritemSpacing = config.tufuh_itemSpac
                self.minimumLineSpacing = config.tufuh_itemSpac
            }
        }
    }
    override init() {
        super.init()
        self.scrollDirection = .horizontal
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.scrollDirection = .horizontal
    }
    override var itemSize: CGSize {
        get {
            if let config = layoutConfig {
                return config.itemSize
            }
            return super.itemSize
        }
        set {
            super.itemSize = newValue
        }
    }
    override var minimumLineSpacing: CGFloat {
        get {
            if let config = layoutConfig {
                return config.tufuh_itemSpac
            }
            return super.minimumLineSpacing
        }
        set {
            super.minimumLineSpacing = newValue
        }
    }
    override var minimumInteritemSpacing: CGFloat {
        get {
            if let config = layoutConfig {
                return config.tufuh_itemSpac
            }
            return super.minimumInteritemSpacing
        }
        set {
            super.minimumInteritemSpacing = newValue
        }
    }
}
