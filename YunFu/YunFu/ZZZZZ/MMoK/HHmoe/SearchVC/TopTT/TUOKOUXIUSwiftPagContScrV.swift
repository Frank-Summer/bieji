
import Foundation
import UIKit

protocol TUOKOUXIUSwiftPagContScrVDelegate: AnyObject {
    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV,
                                          progress: CGFloat,
                                          originalIndex: Int,
                                          targetIndex: Int)
    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV,
                                          index: Int)
}

class TUOKOUXIUSwiftPagContScrV: UIView, UIScrollViewDelegate {
    weak var tufuh_pageContScrVDele: TUOKOUXIUSwiftPagContScrVDelegate?

    private weak var tufuh_pareVC: UIViewController?
    private var tufuh_childVCArr: [UIViewController] = []
    private lazy var tufuh_scrV: UIScrollView = {
        let s = UIScrollView()
        s.bounces = false
        s.isPagingEnabled = true
        s.showsHorizontalScrollIndicator = false
        s.showsVerticalScrollIndicator = false
        s.delegate = self
        return s
    }()

    private var tufuh_staOffsetX: CGFloat = 0
    private weak var tufuh_prevVC: UIViewController?
    private var tufuh_prevVCInd: Int = -1
    private var tufuh_isScroll: Bool = false
    var tufuh_isScrolEna: Bool = true {
        didSet { tufuh_scrV.isScrollEnabled = tufuh_isScrolEna }
    }
    var tufuh_isAnimed: Bool = false

    init(frame: CGRect, parentVC: UIViewController, childVCs: [UIViewController]) {
        super.init(frame: frame)
        self.tufuh_pareVC = parentVC
        self.tufuh_childVCArr = childVCs
        initialization()
        tukou_setuSubVs()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialization()
        tukou_setuSubVs()
    }

    private func initialization() {
        tufuh_staOffsetX = 0
        tufuh_prevVCInd = -1
    }

    private func tukou_setuSubVs() {
        let tempView = UIView(frame: .zero)
        addSubview(tempView)
        addSubview(tufuh_scrV)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        tukou_laySubVs()
    }

    private func tukou_laySubVs() {
        tufuh_scrV.frame = bounds
        let contentWidth = CGFloat(tufuh_childVCArr.count) * bounds.width
        tufuh_scrV.contentSize = CGSize(width: contentWidth, height: 0)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        tufuh_staOffsetX = scrollView.contentOffset.x
        tufuh_isScroll = true
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tufuh_isScroll = false
        let offsetX = scrollView.contentOffset.x
        if tufuh_staOffsetX != offsetX {
            tufuh_prevVC?.beginAppearanceTransition(false, animated: false)
        }
        let index = Int(offsetX / scrollView.frame.size.width)
        guard index >= 0 && index < tufuh_childVCArr.count else { return }
        let childVC = tufuh_childVCArr[index]

        var firstAdd = false
        if let parent = tufuh_pareVC, !parent.children.contains(childVC) {
            parent.addChild(childVC)
            firstAdd = true
        }
        childVC.beginAppearanceTransition(true, animated: false)
        if firstAdd {
            tufuh_scrV.addSubview(childVC.view)
            childVC.view.frame = CGRect(x: offsetX, y: 0, width: bounds.width, height: bounds.height)
        }
        if tufuh_staOffsetX != offsetX {
            tufuh_prevVC?.endAppearanceTransition()
        }
        childVC.endAppearanceTransition()
        if firstAdd {
            childVC.didMove(toParent: tufuh_pareVC)
        }
        tufuh_prevVC = childVC
        tufuh_prevVCInd = index

        tufuh_pageContScrVDele?.tukou_pageContScrV(self, index: index)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tufuh_isAnimed && !tufuh_isScroll { return }

        var progress: CGFloat = 0
        var originalIndex = 0
        var targetIndex = 0
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width

        if currentOffsetX > tufuh_staOffsetX {
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            originalIndex = Int(currentOffsetX / scrollViewW)
            targetIndex = originalIndex + 1
            if targetIndex >= tufuh_childVCArr.count {
                progress = 1
                targetIndex = tufuh_childVCArr.count - 1
            }
            if currentOffsetX - tufuh_staOffsetX == scrollViewW {
                progress = 1
                targetIndex = originalIndex
                originalIndex = targetIndex - 1
            }
        } else {
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            targetIndex = Int(currentOffsetX / scrollViewW)
            originalIndex = targetIndex + 1
            if originalIndex >= tufuh_childVCArr.count {
                originalIndex = tufuh_childVCArr.count - 1
            }
        }

        tufuh_pageContScrVDele?.tukou_pageContScrV(self, progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }

    func tukou_pageContScrVCurrInd(_ currentIndex: Int) {
        guard currentIndex >= 0 && currentIndex < tufuh_childVCArr.count else { return }
        let offsetX = CGFloat(currentIndex) * bounds.width

        if tufuh_prevVC != nil && tufuh_prevVCInd != currentIndex {
            tufuh_prevVC?.beginAppearanceTransition(false, animated: false)
        }

        if tufuh_prevVCInd != currentIndex {
            let childVC = tufuh_childVCArr[currentIndex]
            var firstAdd = false
            if let parent = tufuh_pareVC, !parent.children.contains(childVC) {
                parent.addChild(childVC)
                firstAdd = true
            }
            childVC.beginAppearanceTransition(true, animated: false)
            if firstAdd {
                tufuh_scrV.addSubview(childVC.view)
                childVC.view.frame = CGRect(x: offsetX, y: 0, width: bounds.width, height: bounds.height)
            }
            if tufuh_prevVC != nil && tufuh_prevVCInd != currentIndex {
                tufuh_prevVC?.endAppearanceTransition()
            }
            childVC.endAppearanceTransition()
            if firstAdd {
                childVC.didMove(toParent: tufuh_pareVC)
            }
            tufuh_prevVC = childVC
            tufuh_scrV.setContentOffset(CGPoint(x: offsetX, y: 0), animated: tufuh_isAnimed)
        }

        tufuh_prevVCInd = currentIndex
        tufuh_staOffsetX = offsetX
        tufuh_pageContScrVDele?.tukou_pageContScrV(self, index: currentIndex)
    }
}
