
import Foundation
import UIKit

struct TUOKOUXIUIndexSection: Equatable {
    var index: Int
    var section: Int
}

func TUOKOUXIUEqualIndexSection(_ lhs: TUOKOUXIUIndexSection, _ rhs: TUOKOUXIUIndexSection) -> Bool {
    return lhs.index == rhs.index && lhs.section == rhs.section
}

func TUOKOUXIUMakeIndexSection(_ index: Int, _ section: Int) -> TUOKOUXIUIndexSection {
    return TUOKOUXIUIndexSection(index: index, section: section)
}

enum TUOKOUXIUPagScrDire {
    case left
    case right
}

protocol TUOKOUXIUSwiftCycPagVDataSource: AnyObject {
    func numberOfItemsInPagerView(_ pageView: TUOKOUXIUSwiftCycPagV) -> Int
    func pagerView(_ pagerView: TUOKOUXIUSwiftCycPagV, cellForItemAtIndex index: Int) -> UICollectionViewCell
    func layoutForPagerView(_ pageView: TUOKOUXIUSwiftCycPagV) -> TUOKOUXIUSwiftCycPagVLayout
}

protocol TUOKOUXIUSwiftCycPagVDeleg: AnyObject {
    func pagerView(_ pageView: TUOKOUXIUSwiftCycPagV, didScrollFromIndex fromIndex: Int, toIndex: Int)
    func pagerView(_ pageView: TUOKOUXIUSwiftCycPagV, didSelectedItemCell cell: UICollectionViewCell, atIndex: Int)
}

class TUOKOUXIUSwiftCycPagV: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    weak var dataSource: TUOKOUXIUSwiftCycPagVDataSource?
    weak var delegate: TUOKOUXIUSwiftCycPagVDeleg?
    
    private(set) var indexSection: TUOKOUXIUIndexSection = TUOKOUXIUMakeIndexSection(-1, -1)
    var tracking: Bool { return tufuh_collV?.isTracking ?? false }
    
    private weak var tufuh_collV: UICollectionView?
    private var layoutObj: TUOKOUXIUSwiftCycPagVLayout?
    private var timer: Timer?
    
    private var tufuh_numItems = 0
    private var dequeueSection = 0
    private var beginDragIndexSection = TUOKOUXIUMakeIndexSection(0, 0)
    private var firstScrollIndex = -1
    private var needClearLayout = false
    private var didReloadData = false
    private var didLayout = false
    private var needResetIndex = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureProperty()
        addCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureProperty()
        addCollectionView()
    }
    
    private func configureProperty() {
        needResetIndex = false
        didReloadData = false
        didLayout = false
        beginDragIndexSection = TUOKOUXIUMakeIndexSection(0, 0)
        indexSection = TUOKOUXIUMakeIndexSection(-1, -1)
        firstScrollIndex = -1
    }
    
    private func addCollectionView() {
        let layout = TUOKOUXIUSwiftCycPagTransLay()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .init(rawValue: 1 - 0.0076)
        if #available(iOS 10.0, *) {
            collectionView.isPrefetchingEnabled = false
        }
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        addSubview(collectionView)
        tufuh_collV = collectionView
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview == nil {
            removeTimer()
        } else {
            removeTimer()
            addTimer()
        }
    }
    
    private func addTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerFired(_:)), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    private func removeTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func timerFired(_ timer: Timer) {
        guard superview != nil, window != nil, tufuh_numItems > 0, !tracking else { return }
        scrollToNearlyIndex(at: .right, animate: true)
    }
    
    func reloadData() {
        didReloadData = true
        needResetIndex = true
        setNeedClearLayout()
        clearLayout()
        updateData()
    }
    
    func updateData() {
        updateLayout()
        tufuh_numItems = dataSource?.numberOfItemsInPagerView(self) ?? 0
        tufuh_collV?.reloadData()
        
        if !didLayout, let frame = tufuh_collV?.frame, !frame.isEmpty, indexSection.index < 0 {
            didLayout = true
        }
        needResetIndex = false
        
        let resetIndex = (indexSection.index < 0 && !(tufuh_collV?.frame.isEmpty ?? true)) ? 0 : indexSection.index
        resetPagerView(at: resetIndex)
    }
    
    func registerClass(_ cellClass: AnyClass, forCellWithReuseIdentifier identifier: String) {
        tufuh_collV?.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell(withReuseIdentifier identifier: String, forIndex index: Int) -> UICollectionViewCell {
        return tufuh_collV!.dequeueReusableCell(withReuseIdentifier: identifier, for: IndexPath(item: index, section: dequeueSection))
    }
    
    var layout: TUOKOUXIUSwiftCycPagVLayout? {
        if layoutObj == nil {
            if let l = dataSource?.layoutForPagerView(self), l.itemSize.width > 0, l.itemSize.height > 0 {
                layoutObj = l
            }
        }
        return layoutObj
    }
    
    private func updateLayout() {
        guard let layout = layout, let coll = tufuh_collV else { return }
        if let trans = coll.collectionViewLayout as? TUOKOUXIUSwiftCycPagTransLay {
            trans.layoutConfig = layout
        }
    }
    
    private func clearLayout() {
        if needClearLayout {
            layoutObj = nil
            needClearLayout = false
        }
    }
    
    private func setNeedClearLayout() {
        needClearLayout = true
    }
    
    private func setNeedUpdateLayout() {
        guard layout != nil else { return }
        clearLayout()
        updateLayout()
        tufuh_collV?.collectionViewLayout.invalidateLayout()
        resetPagerView(at: indexSection.index < 0 ? 0 : indexSection.index)
    }
    
    private func scrollToNearlyIndex(at direction: TUOKOUXIUPagScrDire, animate: Bool) {
        let indexSec = nearlyIndexPath(at: direction)
        scrollToItem(at: indexSec, animate: animate)
    }
    
    private func scrollToItem(at indexSec: TUOKOUXIUIndexSection, animate: Bool) {
        guard tufuh_numItems > 0, isValid(indexSec) else { return }
        let offset = caculateOffsetX(at: indexSec)
        tufuh_collV?.setContentOffset(CGPoint(x: offset, y: tufuh_collV?.contentOffset.y ?? 0), animated: animate)
    }
    
    private func isValid(_ indexSec: TUOKOUXIUIndexSection) -> Bool {
        return indexSec.index >= 0 && indexSec.index < tufuh_numItems && indexSec.section >= 0 && indexSec.section < 200
    }
    
    private func nearlyIndexPath(at direction: TUOKOUXIUPagScrDire) -> TUOKOUXIUIndexSection {
        return nearlyIndexPath(for: indexSection, direction: direction)
    }
    
    private func nearlyIndexPath(for indexSec: TUOKOUXIUIndexSection, direction: TUOKOUXIUPagScrDire) -> TUOKOUXIUIndexSection {
        if indexSec.index < 0 || indexSec.index >= tufuh_numItems { return indexSec }
        
        switch direction {
        case .right:
            if indexSec.index < tufuh_numItems - 1 {
                return TUOKOUXIUMakeIndexSection(indexSec.index + 1, indexSec.section)
            }
            if indexSec.section >= 200 - 1 {
                return TUOKOUXIUMakeIndexSection(indexSec.index, 200 - 1)
            }
            return TUOKOUXIUMakeIndexSection(0, indexSec.section + 1)
        case .left:
            if indexSec.index > 0 {
                return TUOKOUXIUMakeIndexSection(indexSec.index - 1, indexSec.section)
            }
            if indexSec.section <= 0 {
                return TUOKOUXIUMakeIndexSection(indexSec.index, 0)
            }
            return TUOKOUXIUMakeIndexSection(tufuh_numItems - 1, indexSec.section - 1)
        }
    }
    
    private func caculateOffsetX(at indexSec: TUOKOUXIUIndexSection) -> CGFloat {
        guard tufuh_numItems > 0, let coll = tufuh_collV, let layout = coll.collectionViewLayout as? UICollectionViewFlowLayout else {
            return 0
        }
        let edge = layoutObj?.tufuh_sectIns ?? .zero
        let leftEdge = edge.left
        let width = coll.frame.width
        let itemWidth = layout.itemSize.width + layout.minimumInteritemSpacing
        let offsetX = leftEdge + itemWidth * CGFloat(indexSec.index + indexSec.section * tufuh_numItems)
            - layout.minimumInteritemSpacing / 2 - (width - itemWidth) / 2
        return max(offsetX, 0)
    }
    
    private func resetPagerView(at index: Int) {
        var idx = index
        if didLayout && firstScrollIndex >= 0 {
            idx = firstScrollIndex
            firstScrollIndex = -1
        }
        if idx < 0 { return }
        if idx >= tufuh_numItems { idx = 0 }
        scrollToItem(at: TUOKOUXIUMakeIndexSection(idx, 200/3), animate: false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let needUpdate = tufuh_collV?.frame != bounds
        tufuh_collV?.frame = bounds
        if (indexSection.section < 0 || needUpdate), (tufuh_numItems > 0 || didReloadData) {
            didLayout = true
            setNeedUpdateLayout()
        }
    }
    
    deinit {
        tufuh_collV?.delegate = nil
        tufuh_collV?.dataSource = nil
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 200 }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tufuh_numItems = dataSource?.numberOfItemsInPagerView(self) ?? 0
        return tufuh_numItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        dequeueSection = indexPath.section
        guard let cell = dataSource?.pagerView(self, cellForItemAtIndex: indexPath.row) else {
            fatalError("pagerView cellForItemAtIndex: is nil!")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return layoutObj?.firstSectionInset ?? .zero
        } else if section == 200 - 1 {
            return layoutObj?.lastSectionInset ?? .zero
        }
        return layoutObj?.middleSectionInset ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        delegate?.pagerView(self, didSelectedItemCell: cell, atIndex: indexPath.item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard didLayout else { return }
        let newIndexSec = caculateIndexSection(offsetX: scrollView.contentOffset.x)
        guard tufuh_numItems > 0, isValid(newIndexSec) else { return }
        let oldIndexSec = indexSection
        indexSection = newIndexSec
        
        if !TUOKOUXIUEqualIndexSection(indexSection, oldIndexSec) {
            delegate?.pagerView(self, didScrollFromIndex: max(oldIndexSec.index, 0), toIndex: indexSection.index)
        }
    }
    
    private func caculateIndexSection(offsetX: CGFloat) -> TUOKOUXIUIndexSection {
        guard tufuh_numItems > 0, let coll = tufuh_collV, let layout = coll.collectionViewLayout as? UICollectionViewFlowLayout else {
            return TUOKOUXIUMakeIndexSection(0, 0)
        }
        let leftEdge = layoutObj?.tufuh_sectIns.left ?? 0
        let width = coll.frame.width
        let middleOffset = offsetX + width / 2
        let itemWidth = layout.itemSize.width + layout.minimumInteritemSpacing
        var curIndex = 0
        var curSection = 0
        if middleOffset - leftEdge >= 0 {
            var itemIndex = Int((middleOffset - leftEdge + layout.minimumInteritemSpacing/2) / itemWidth)
            itemIndex = max(0, min(itemIndex, tufuh_numItems * 200 - 1))
            curIndex = itemIndex % tufuh_numItems
            curSection = itemIndex / tufuh_numItems
        }
        return TUOKOUXIUMakeIndexSection(curIndex, curSection)
    }
    
    private func recyclePagerViewIfNeeded() {
        if indexSection.section > 200 - 18 || indexSection.section < 18 {
            resetPagerView(at: indexSection.index)
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
        beginDragIndexSection = caculateIndexSection(offsetX: scrollView.contentOffset.x)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if abs(velocity.x) < 0.35 || !TUOKOUXIUEqualIndexSection(beginDragIndexSection, indexSection) {
            targetContentOffset.pointee.x = caculateOffsetX(at: indexSection)
            return
        }
        
        var direction: TUOKOUXIUPagScrDire = .right
        let contentOffsetX = scrollView.contentOffset.x
        let targetX = targetContentOffset.pointee.x
        let maxOffsetX = scrollView.contentSize.width - scrollView.frame.width
        
        if (contentOffsetX < 0 && targetX <= 0) || (targetX < contentOffsetX && contentOffsetX < maxOffsetX) {
            direction = .left
        }
        
        let newIndexSection = nearlyIndexPath(for: indexSection, direction: direction)
        targetContentOffset.pointee.x = caculateOffsetX(at: newIndexSection)
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        recyclePagerViewIfNeeded()
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        recyclePagerViewIfNeeded()
    }
}
