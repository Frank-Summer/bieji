
import Foundation
import UIKit

protocol TUOKOUXIUSSPullDRefVDelegate: AnyObject {
    func tukou_pullDRefDidFin()
}

class TUOKOUXIUSSPullDRefV: UIView {
    
    private var tufuh_isDragging: Bool = false
    private var tufuh_isLoading: Bool = false
    
    weak var delegate: TUOKOUXIUSSPullDRefVDelegate?
    weak var tufuh_scrV: UIScrollView?
    
    var tufuh_refSpinV: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let REFRESHER_HEIGHT: CGFloat = 50.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = TUOKOUXIUSwiftwuseC
        self.isUserInteractionEnabled = false
        self.clipsToBounds = true
        addSubview(tufuh_refSpinV)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fuhan_setup(owner: UIScrollView, delegate: TUOKOUXIUSSPullDRefVDelegate) {
        self.tufuh_scrV = owner
        self.delegate = delegate
        owner.addSubview(self)
    }
    
    func fuhan_layout(offset: CGPoint) {
        let y = offset.y
        let frame = CGRect(x: 0, y: -REFRESHER_HEIGHT, width: self.frame.width, height: y < 0 ? REFRESHER_HEIGHT : 0)
        self.frame = frame

        tufuh_refSpinV.frame = CGRect(
            x: (TUOKOUXIUSwiftSCRE_W - 20) / 2,
            y: (REFRESHER_HEIGHT - 20) / 2,
            width: 20, height: 20
        )
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if tufuh_isLoading { return }
        tufuh_isDragging = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let offset = tufuh_scrV?.contentOffset else { return }
        fuhan_layout(offset: offset)

        if tufuh_isLoading && offset.y > 0 { return }

        if tufuh_isDragging && offset.y <= 0 {
            tufuh_refSpinV.stopAnimating()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tufuh_isLoading { return }
        tufuh_isDragging = false

        if scrollView.contentOffset.y <= -REFRESHER_HEIGHT {
            fuhan_starLoad()
        }
    }
    
    func fuhan_starLoad() {
        if tufuh_isLoading { return }

        tufuh_isLoading = true
        guard let scrollView = tufuh_scrV else { return }

        var inset = scrollView.contentInset
        inset.top = REFRESHER_HEIGHT

        UIView.animate(withDuration: 0.25, animations: {
            scrollView.contentInset = inset
            self.tufuh_refSpinV.startAnimating()
        }) { _ in
            self.delegate?.tukou_pullDRefDidFin()
        }
    }
    
    func fuhan_stoLoadi() {
        tufuh_isLoading = false
        guard let scrollView = tufuh_scrV else { return }

        var inset = scrollView.contentInset
        inset.top = 0

        UIView.animate(withDuration: 0.15, animations: {
            scrollView.contentInset = inset
        }) { _ in
            self.frame = CGRect(x: 0, y: -self.REFRESHER_HEIGHT, width: self.frame.width, height: 0)
            self.tufuh_refSpinV.stopAnimating()
        }
    }
}
