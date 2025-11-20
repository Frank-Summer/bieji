
import Foundation
import UIKit
import CoreGraphics
import ESPullToRefresh
import SnapKit
import Combine

class TUOKOUXIUSwiftSSSVC: TUOKOUXIUSwiftBaseVC,
                      UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,
                      UITableViewDelegate, UITableViewDataSource,
                      UITextFieldDelegate, TUOKOUXIUSwiftPagTitVDelegate, TUOKOUXIUSwiftPagContScrVDelegate {
    
    var tufuh_source: String = ""
    var tufuh_isHHH: Bool = false
    var tufuh_isTS: Bool = false
    var tufuh_gotoSS: Bool = false
    var tufuh_searchStr: String = ""
    
    private var tufuh_banW: CGFloat = 0
    private var tufuh_banH: CGFloat = 0
    
    private var tufuh_topV: UIView!
    private var tufuh_tNavV: UIView!
    private var tufuh_noNetV: UIView!
    private var tufuh_searV: UIView!
    private var tufuh_searTF: UITextField!
    private var tufuh_searchBtn: UIButton!
    private var tufuh_clearBtn: UIButton!
    private var tufuh_isSKeyboard: Bool = false
    private var tufuh_addStr: String = ""
    private var tufuh_searStr: String = ""
    private var tufuh_currentPage: Int = 1
    private var tufuh_pageSize: Int = 24
    private var tufuh_dataArr: [Any] = []
    private var tufuh_dataTreArr: [[String: Any]] = []
    private var tufuh_toTopBtn: UIButton!
    private var tufuh_hisV: UIView!
    private var tufuh_searTJV: UIView!
    private var tufuh_clearV: UIView!
    
    private var tufuh_natiAdPlV: UIView!
    private var tufuh_footV: TUOKOUXIUSSSSwiftCoReuFooV!
    private var tufuh_headV: TUOKOUXIUSSSSwiftCoReuHeaV!
    private var tufuh_adPlIV: UIImageView!
    private var tufuh_isRecover: Bool = false
    private var tufuh_searTJVH: CGFloat = 0
    private var cancellables = Set<AnyCancellable>()

    lazy var tufuh_tabV: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.backgroundColor = TUOKOUXIUSwiftheiseC
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 0.01))
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            if tableView.contentOffset.y == 0 {
                tableView.contentInset = UIEdgeInsets(top: -34, left: 0, bottom: 0, right: 0)
            }
        }
        tableView.tableHeaderView?.frame.size.height = 0.01
        
        return tableView
    }()
    var tufuh_collcV: UICollectionView?
    
    lazy var tufuh_tagsV: TUOKOUSwiftXIUTagsV = {
        let tagsV = TUOKOUSwiftXIUTagsV()
        tagsV.tufuh_layout.scrollDirection = .vertical
        return tagsV
    }()
    
    lazy var tufuh_pageTitV: TUOKOUXIUSwiftPagTitV = {
        var tufuh_nameArr: [String] = []
        if let arr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_phArr as? [[String: Any]] {
            for tufuh_d in arr {
                if let name = tufuh_d["name"] as? String {
                    tufuh_nameArr.append(name)
                }
            }
        }
        let tufuh_titArr = tufuh_nameArr
        
        let tufuh_conf = TUOKOUXIUSwiftPagTitVConf.tukou_pageTitVCon()
//        tufuh_conf.tufuh_titGradiEffe = true
        tufuh_conf.tufuh_titClr = TUOKOUXIUSwiftZTClr3A
        tufuh_conf.tufuh_titFont = TUOKOUXIUSwiftFont.semibold(15)
        tufuh_conf.tufuh_titSeleClr = TUOKOUXIUSwiftbaiseC
        tufuh_conf.tufuh_titSeleFon = TUOKOUXIUSwiftFont.semibold(15)
        tufuh_conf.tufuh_indicClr = TUOKOUXIUSwiftZTClr
        tufuh_conf.tufuh_indicHei = 3
        tufuh_conf.tufuh_indicToBotDist = 3
        tufuh_conf.tufuh_indiCorRadi = 3
        tufuh_conf.tufuh_indiFixW = 40.0
        tufuh_conf.tufuh_indicaSty = .dyn
        tufuh_conf.tufuh_titTexZoo = true
        tufuh_conf.tufuh_shoBotSeparator = true
        tufuh_conf.tufuh_botSeparClr = UIColor.TUOKOUXIUSSRGB(r: 63, g: 63, b: 92)
        
        let pageTitV = TUOKOUXIUSwiftPagTitV.tukou_pageTitVWithFra(frame:
            CGRect(x: 10, y: 40, width: TUOKOUXIUSwiftSCRE_W-20, height: 44),
            delegate: self,
            titleNames: tufuh_titArr,
            configure: tufuh_conf
        )
        pageTitV.backgroundColor = TUOKOUXIUSwiftheiseC
        return pageTitV
    }()

    lazy var tufuh_pageContScrV: TUOKOUXIUSwiftPagContScrV = {
        var tufuh_vcArr: [TUOKOUXIUSwiftPageVC] = []
        for (i, tufuh_d) in TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_phArr.enumerated() {
            let tufuh_pVC = TUOKOUXIUSwiftPageVC()
            tufuh_pVC.tufuh_source = self.tufuh_source
            tufuh_pVC.tufuh_num = i + 1
            if let dict = tufuh_d as? [String: Any] {
                tufuh_pVC.tufuh_dataTreArr = (dict["data"] as? [[String: Any]]) ?? []
            }
            tufuh_vcArr.append(tufuh_pVC)
        }
        let pageContScrV = TUOKOUXIUSwiftPagContScrV(
            frame: CGRect(x: 0, y: tufuh_pageTitV.frame.maxY, width: TUOKOUXIUSwiftSCRE_W, height: self.tufuh_searTJVH - tufuh_pageTitV.frame.maxY),
            parentVC: self,
            childVCs: tufuh_vcArr
        )
        pageContScrV.tufuh_pageContScrVDele = self
        return pageContScrV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if TUOKOUXIUSSApp.tukou_isPad() {
            tufuh_banW = 728
            tufuh_banH = 90
        } else {
            tufuh_banW = 320
            tufuh_banH = 50
        }
        
        view.backgroundColor = TUOKOUXIUSwiftheiseC
        
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in self?.tukou_entForegr() }
            .store(in: &cancellables)

        tukou_topVi()
        
        tufuh_dataArr = []
        tufuh_dataTreArr = []
        tufuh_currentPage = 1
        
        tufuh_pageSize = TUOKOUXIUSSApp.tukou_isPad() ? 30 : 24
        
        tukou_hisV()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            guard let self = self else { return }
            if self.tufuh_gotoSS && !self.tufuh_searchStr.isEmpty {
                self.tufuh_searTF.text = self.tufuh_searchStr
                self.tukou_testNet()
            }
        }
    }
    
    deinit {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tufuh_isSKeyboard {
            tufuh_isSKeyboard = false
            tufuh_searTF.resignFirstResponder()
        }

        if scrollView == tufuh_collcV {
            let tufuh_yy = tufuh_collcV?.contentOffset.y ?? 0
            if tufuh_yy >= (TUOKOUXIUSwiftSCRE_H / 2), !tufuh_dataTreArr.isEmpty {
                if tufuh_toTopBtn == nil {
                    tukou_showTopBtn()
                }
            } else {
                if tufuh_toTopBtn != nil {
                    tukou_hideTopBtn()
                }
            }
        }
    }

    func tukou_showTopBtn() {
        let yPosition: CGFloat

            yPosition = TUOKOUXIUSwiftSCRE_H - 90
        
        let buttonFrame = CGRect(x: TUOKOUXIUSwiftSCRE_W - 60, y: yPosition, width: 40, height: 40)
        tufuh_toTopBtn = UIButton.tukou_bjBtn(
            buttonFrame,
            target: self,
            image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_totop", andIsOne: false),
            superView: view,
            action: #selector(tukou_toTop)
        )
    }

    @objc func tukou_toTop() {
        tufuh_collcV!.setContentOffset(.zero, animated: true)
    }

    func tukou_hideTopBtn() {
        if (tufuh_toTopBtn != nil) {
            tufuh_toTopBtn!.removeFromSuperview()
            tufuh_toTopBtn = nil
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        tufuh_isSKeyboard = false

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        if !tufuh_dataTreArr.isEmpty {
            tufuh_isRecover = true
            let tufuh_aniEna = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            tufuh_collcV?.reloadData()
            UIView.setAnimationsEnabled(tufuh_aniEna)
        }
    }

    private func tukou_entForegr() {
        if !tufuh_dataTreArr.isEmpty {
            tufuh_isRecover = true
            let tufuh_aniEna = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            tufuh_collcV?.reloadData()
            UIView.setAnimationsEnabled(tufuh_aniEna)
        }
    }
    
    @objc func fuhanad_closeVp() {
        fuhan_deallocRefV()
        
        UIView.animate(withDuration: 0.2) {
            self.tufuh_collcV?.reloadData()
        }
    }

    func fuhan_deallocRefV() {
        if (tufuh_natiAdPlV != nil) {
            tufuh_natiAdPlV!.removeFromSuperview()
            tufuh_natiAdPlV = nil
        }

        if (tufuh_footV != nil) {
            tufuh_footV!.removeFromSuperview()
            tufuh_footV = nil
        }

        if (tufuh_headV != nil) {
            tufuh_headV!.removeFromSuperview()
            tufuh_headV = nil
        }

    }
    func fuhanad_refreshV() {
        fuhan_deallocRefV()

        let collY = tufuh_tNavV.frame.maxY + 10
        
        tufuh_collcV!.frame = CGRect(
            x: 10,
            y: collY,
            width: TUOKOUXIUSwiftSCRE_W - 20,
            height: TUOKOUXIUSwiftSCRE_H - collY
        )
        
        UIView.animate(withDuration: 0.2) {
            self.tufuh_collcV?.reloadData()
        }
    }
    @objc func tukou_clickClear() {
        guard tufuh_clearV == nil else { return }
        
        view.endEditing(true)
        tufuh_clearV = UIView.tukou_bjView(
            CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUSwiftSCRE_H),
            superView: view,
            bgColor: TUOKOUXIUSwiftwuseC
        )
        
        let tufuh_hitV = UIView.tukou_bjView(
            CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 135.5, y: TUOKOUXIUSwiftSCRE_H/2 - 81.5, width: 271, height: 163),
            superView: tufuh_clearV!,
            bgColor: UIColor.TUOKOUXIUSSRGB(r: 35, g: 37, b: 42)
        )
        tufuh_hitV.layer.cornerRadius = 10
        tufuh_hitV.clipsToBounds = true
        
        UILabel.tukou_bjLabel(
            CGRect(x: 0, y: 25, width: 271, height: 22),
            text: "Clear",
            superView: tufuh_hitV,
            textAlignment: .center,
            font: TUOKOUXIUSwiftFont.regular(16),
            textColor: TUOKOUXIUSwiftZTClr3
        )
        
        let tufuh_contL = UILabel.tukou_bjLabel(
            CGRect(x: 0, y: 50, width: 271, height: 40),
            text: "Please confirm whether to clear the\nsearch history.",
            superView: tufuh_hitV,
            textAlignment: .center,
            font: TUOKOUXIUSwiftFont.regular(12),
            textColor: TUOKOUXIUSwiftZTClr3
        )
        tufuh_contL.numberOfLines = 0
        
        UIView.tukou_bjView(
            CGRect(x: 0, y: 112, width: 271, height: 1),
            superView: tufuh_hitV,
            bgColor: UIColor.TUOKOUXIUSSRGB(r: 55, g: 56, b: 60)
        )
        
        let tufuh_lefBtn = UIButton.tukou_bjBtn(
            CGRect(x: 0, y: 113, width: 135, height: 50),
            target: self,
            title: "Cancel",
            superView: tufuh_hitV,
            action: #selector(tukou_cancel)
        )
        tufuh_lefBtn.setTitleColor(TUOKOUXIUSwiftbaiseC, for: .normal)
        
        UIView.tukou_bjView(
            CGRect(x: 135, y: 113, width: 1, height: 50),
            superView: tufuh_hitV,
            bgColor: UIColor.TUOKOUXIUSSRGB(r: 55, g: 56, b: 60)
        )
        
        let tufuh_rigBtn = UIButton.tukou_bjBtn(
            CGRect(x: 136, y: 113, width: 135, height: 50),
            target: self,
            title: "Clear",
            superView: tufuh_hitV,
            action: #selector(tukou_clear)
        )
        tufuh_rigBtn.setTitleColor(TUOKOUXIUSwiftbaiseC, for: .normal)
    }

    @objc func tukou_cancel() {
        if (tufuh_clearV != nil) {
            tufuh_clearV!.removeFromSuperview()
            tufuh_clearV = nil
        }

    }
    @objc func tukou_clear() {
        tukou_cancel()
        
        TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_delArrK(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisSearArr)
        if (tufuh_hisV != nil) {
            tufuh_hisV!.removeFromSuperview()
            tufuh_hisV = nil
        }

        TUOKOUXIUSwiftKeyWindow()!.makeToast("Search records cleared successfully!", duration: 2.0, position: .center)
        var tufuh_h: CGFloat = 0

            tufuh_h = TUOKOUXIUSwiftSCRE_H - (tufuh_tNavV.frame.maxY + 10)
        
        
        tufuh_searTJVH = tufuh_h + 170
        tufuh_searTJV.frame = CGRect(
            x: 0,
            y: tufuh_tNavV.frame.maxY + 10,
            width: TUOKOUXIUSwiftSCRE_W,
            height: tufuh_h + 170
        )
        
        tufuh_pageContScrV.frame = CGRect(
            x: 0,
            y: tufuh_pageTitV.frame.maxY,
            width: TUOKOUXIUSwiftSCRE_W,
            height: tufuh_searTJVH - tufuh_pageTitV.frame.maxY
        )
        
        NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUSouSuoHeight"), object: nil)
    }
    func tukou_hisV() {
        guard tufuh_hisV == nil else { return }
        
        if let tufuh_hisArr = TUOKOUXIUSwiftShuJCC
            .tukou_shuJuDL
            .tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisSearArr) as? [String],
           !tufuh_hisArr.isEmpty {
            
            var tufuh_hV: CGFloat = 80
            var numH = 1
            var numN = 0
            let tufuh_w: CGFloat = TUOKOUXIUSwiftSCRE_W - 40
            var tufuh_w2: CGFloat = 0
            let maxSize = CGSize(width: TUOKOUXIUSwiftSCRE_W - 40, height: 30)
            
            for (i, st1) in tufuh_hisArr.enumerated() {
                let frame = (st1 as NSString).boundingRect(
                    with: maxSize,
                    options: [.usesFontLeading, .usesLineFragmentOrigin],
                    attributes: [.font: TUOKOUXIUSwiftFont.regular(14)],
                    context: nil
                )
                numN = i > 0 ? 10 : 0
                tufuh_w2 += frame.width + 20 + CGFloat(numN)
                if tufuh_w2 + 10 > tufuh_w {
                    tufuh_w2 = frame.width + 20
                    numH += 1
                    tufuh_hV = 130
                    if numH == 3 {
                        tufuh_hV = 170
                        break
                    }
                }
            }
            
            tufuh_hisV = UIView.tukou_bjView(
                CGRect(x: 0, y: tufuh_tNavV.frame.maxY + 10, width: TUOKOUXIUSwiftSCRE_W, height: tufuh_hV),
                superView: view,
                bgColor: TUOKOUXIUSwiftheiseC
            )
            
            UILabel.tukou_bjLabel(
                CGRect(x: 10, y: 10, width: 100, height: 30),
                text: "History",
                superView: tufuh_hisV!,
                textAlignment: .left,
                font: TUOKOUXIUSwiftFont.semibold(18),
                textColor: TUOKOUXIUSwiftbaiseC
            )
            
            let tufuh_clearB = UIButton.tukou_bjBtn(
                CGRect(x: TUOKOUXIUSwiftSCRE_W - 20 - 16.5, y: 13, width: 16.5, height: 18),
                target: self,
                image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_his_clear", andIsOne: false),
                superView: tufuh_hisV!,
                action: #selector(tukou_clickClear)
            )
            tufuh_clearB.tukou_setEnlargeEdge(10)
            
            tufuh_hisV?.addSubview(tufuh_tagsV)
            
            tufuh_tagsV.snp.makeConstraints { make in
                make.top.equalTo(50)
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.bottom.equalToSuperview()
            }
            
            tufuh_tagsV.tufuh_tagArr = tufuh_hisArr
            tufuh_tagsV.tukou_reloData()
            
            tufuh_tagsV.tufuh_clkItemBlk = { [weak self] selectTags, currentIndex in
                guard let self else { return }
                self.tufuh_searTF.text = "\(selectTags[currentIndex])"
                self.tukou_testNet()
            }
            
            let tufuh_h: CGFloat
            if tufuh_searTJV != nil {
                let topY = tufuh_tNavV.frame.maxY

                    tufuh_h = TUOKOUXIUSwiftSCRE_H - (topY + 10 + tufuh_hV)
                
                tufuh_searTJVH = tufuh_h
                tufuh_searTJV?.frame = CGRect(x: 0, y: topY + 10 + tufuh_hV, width: TUOKOUXIUSwiftSCRE_W, height: tufuh_h)
                
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUSouSuoHeight"), object: nil)
                return
            } else {
                let topY = tufuh_tNavV.frame.maxY

                    tufuh_h = TUOKOUXIUSwiftSCRE_H - (topY + 10 + tufuh_hV)
                
                tufuh_searTJV = UIView.tukou_bjView(
                    CGRect(x: 0, y: topY + 10 + tufuh_hV, width: TUOKOUXIUSwiftSCRE_W, height: tufuh_h),
                    superView: view,
                    bgColor: TUOKOUXIUSwiftheiseC
                )
                UILabel.tukou_bjLabel(
                    CGRect(x: 10, y: 10, width: 120, height: 30),
                    text: "Top Search",
                    superView: tufuh_searTJV!,
                    textAlignment: .left,
                    font: TUOKOUXIUSwiftFont.semibold(18),
                    textColor: TUOKOUXIUSwiftbaiseC
                )
                tufuh_searTJVH = tufuh_h
                
                if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_phArr.count > 0 {
                    tufuh_searTJV?.addSubview(tufuh_pageTitV)
                    tufuh_searTJV?.addSubview(tufuh_pageContScrV)
                }
                
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUSouSuoHeight"), object: nil)
            }
            
        } else {

            let tufuh_h: CGFloat
            if tufuh_searTJV != nil {

                    tufuh_h = TUOKOUXIUSwiftSCRE_H - (tufuh_tNavV.frame.maxY + 10)
                
                tufuh_searTJVH = tufuh_h
                tufuh_searTJV?.frame = CGRect(x: 0, y: tufuh_tNavV.frame.maxY + 10, width: TUOKOUXIUSwiftSCRE_W, height: tufuh_h)
                
                NotificationCenter.default.post(name: Notification.Name("TUOKOUXIUSouSuoHeight"), object: nil)
                return
            } else {

                    tufuh_h = TUOKOUXIUSwiftSCRE_H - (tufuh_tNavV.frame.maxY + 10)
                
                tufuh_searTJV = UIView.tukou_bjView(
                    CGRect(x: 0, y: tufuh_tNavV.frame.maxY + 10, width: TUOKOUXIUSwiftSCRE_W, height: tufuh_h),
                    superView: view,
                    bgColor: TUOKOUXIUSwiftheiseC
                )
                UILabel.tukou_bjLabel(
                    CGRect(x: 10, y: 10, width: 120, height: 30),
                    text: "Top Search",
                    superView: tufuh_searTJV!,
                    textAlignment: .left,
                    font: TUOKOUXIUSwiftFont.semibold(18),
                    textColor: TUOKOUXIUSwiftbaiseC
                )
                tufuh_searTJVH = tufuh_h
                if TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_phArr.count > 0 {
                    tufuh_searTJV?.addSubview(tufuh_pageTitV)
                    tufuh_searTJV?.addSubview(tufuh_pageContScrV)
                }
            }
        }
    }

    func tukou_pageTitV(_ pageTitleView: TUOKOUXIUSwiftPagTitV, selectedIndex: Int) {
        tufuh_pageContScrV.tukou_pageContScrVCurrInd(selectedIndex)
    }

    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        tufuh_pageTitV.tukou_pageTitVWithPro(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }

    func tukou_pageContScrV(_ pageContentScrollView: TUOKOUXIUSwiftPagContScrV, index: Int) {
        
        if tufuh_isSKeyboard {
            tufuh_searTF.resignFirstResponder()
        }
    }

    func tukou_topVi() {
        tufuh_topV = UIView.tukou_bjView(CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight), superView: view, bgColor: TUOKOUXIUSwiftheiseC)
        
        tufuh_tNavV = UIView.tukou_bjView(CGRect(x: 0, y: tufuh_topV.frame.maxY, width: TUOKOUXIUSwiftSCRE_W, height: 56), superView: view, bgColor: TUOKOUXIUSwiftheiseC)
        
        let tufuh_iV = UIImageView.tukou_bjImageV(CGRect(x: 10, y: 16, width: 24, height: 24), superView: tufuh_tNavV, image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_nav_top_left", andIsOne: false))
        tufuh_iV.isUserInteractionEnabled = true
        
        tufuh_iV.tukou_addTapGesture(target: self, action: #selector(tukou_goBack))
        
        tufuh_searV = UIView.tukou_bjView(CGRect(x: 44, y: 8, width: TUOKOUXIUSwiftSCRE_W - 54, height: 40), superView: tufuh_tNavV, bgColor: TUOKOUXIUSwiftZTClr5A, cornerRadius: 20, borderWidth: 1, borderColor: TUOKOUXIUSwiftZTClr)
        
        tufuh_searTF = UITextField(frame: CGRect(x: 20, y: 0, width: TUOKOUXIUSwiftSCRE_W - 54 - 20 - 36, height: 40))
        tufuh_searV.addSubview(tufuh_searTF)
        tufuh_searTF.delegate = self
        tufuh_searTF.autocorrectionType = .no
        tufuh_searTF.textColor = UIColor.TUOKOUXIUSSRGB(r: 174, g: 175, b: 177)
        tufuh_searTF.tintColor = TUOKOUXIUSwiftZTClr
        tufuh_searTF.font = TUOKOUXIUSwiftFont.regular(15)
        tufuh_searTF.returnKeyType = .search
        tufuh_searTF.attributedPlaceholder = NSAttributedString(
            string: "Search \(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[36]) & \(TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_tttArr[37])",
            attributes: [
                .foregroundColor: UIColor.TUOKOUXIUSSRGB(r: 174, g: 175, b: 177),
                .font: TUOKOUXIUSwiftFont.regular(15)
            ]
        )
        
        tufuh_searchBtn = UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W - 90, y: 10, width: 16, height: 16), target: self, image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_hh_search2", andIsOne: false), superView: tufuh_searV, action: #selector(tukou_searchBtn))
        
        tufuh_clearBtn = UIButton.tukou_bjBtn(CGRect(x: TUOKOUXIUSwiftSCRE_W - 90, y: 10, width: 16, height: 16), target: self, image: TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jiaZIcon("TUOKOUXIU_ic_ss_clear", andIsOne: false), superView: tufuh_searV, action: #selector(tukou_clearBtn))
        tufuh_clearBtn.isHidden = true
    }
    func tukou_creTabV() {
        tufuh_tabV.removeFromSuperview()
        tufuh_tabV.delegate = nil
        tufuh_tabV.dataSource = nil
        
        let tabHeight: CGFloat

            tabHeight = TUOKOUXIUSwiftSCRE_H - tufuh_tNavV.frame.maxY
        
        tufuh_tabV.frame = CGRect(x: 0, y: tufuh_tNavV.frame.maxY, width: TUOKOUXIUSwiftSCRE_W, height: tabHeight)
        
        view.addSubview(tufuh_tabV)
        tufuh_tabV.delegate = self
        tufuh_tabV.dataSource = self
        tufuh_tabV.register(TUOKOUXIUSwiftSSSReCell.self, forCellReuseIdentifier: "TUOKOUXIUSSSReCellId")
        tufuh_tabV.register(UITableViewCell.self, forCellReuseIdentifier: "TUOKOUXIUSeRecDefCelId")
    }

    func tukou_deallTabV() {
        tufuh_tabV.removeFromSuperview()
        tufuh_tabV.delegate = nil
        tufuh_tabV.dataSource = nil
        
        if !tufuh_dataArr.isEmpty {
            tufuh_dataArr.removeAll()
        }
    }
    
    func tukou_deallCollV() {
        if let headV = tufuh_headV {
            headV.removeFromSuperview()
            tufuh_headV = nil
        }
        if let footV = tufuh_footV {
            footV.removeFromSuperview()
            tufuh_footV = nil
        }
        if (tufuh_collcV != nil) {
            tufuh_collcV!.removeFromSuperview()
            tufuh_collcV = nil
        }
        
        
        tufuh_currentPage = 1
        tufuh_pageSize = TUOKOUXIUSSApp.tukou_isPad() ? 30 : 24
        if !tufuh_dataTreArr.isEmpty {
            tufuh_dataTreArr.removeAll()
        }

    }
    func tukou_creCollV() {
        tukou_deaNoNetV()
        if (tufuh_collcV != nil) {
            tufuh_collcV!.removeFromSuperview()
            tufuh_collcV!.delegate = nil
            tufuh_collcV!.dataSource = nil
            tufuh_collcV = nil
        }
        
        if let footV = tufuh_footV {
            footV.removeFromSuperview()
            tufuh_footV = nil
        }
        if let headV = tufuh_headV {
            headV.removeFromSuperview()
            tufuh_headV = nil
        }

        if let natiAdPlV = tufuh_natiAdPlV {
            natiAdPlV.removeFromSuperview()
            tufuh_natiAdPlV = nil
        }
        
        let collY = tufuh_tNavV.frame.maxY + 10
        let collHeight: CGFloat

            collHeight = TUOKOUXIUSwiftSCRE_H - collY
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        tufuh_collcV = UICollectionView(frame: CGRect(x: 10, y: collY, width: TUOKOUXIUSwiftSCRE_W - 20, height: collHeight), collectionViewLayout: layout)
        tufuh_collcV!.delegate = self
        tufuh_collcV!.dataSource = self
        tufuh_collcV!.backgroundColor = TUOKOUXIUSwiftheiseC
        tufuh_collcV!.showsVerticalScrollIndicator = false
        tufuh_collcV!.keyboardDismissMode = .onDrag

        tufuh_collcV!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUSeColVDefCelId")
        tufuh_collcV!.register(TUOKOUXIUSwiftHHHCollVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUSeColVCelId")
        tufuh_collcV!.register(TUOKOUXIUSSSSwiftCoReuFooV.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "TUOKOUXIUSSSCoReuFooVId")
        tufuh_collcV!.register(TUOKOUXIUSSSSwiftCoReuHeaV.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "TUOKOUXIUSSSCoReuHeaVId")

        tufuh_collcV!.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: "TUOKOUXIUSeColVDefSupVId")
        tufuh_collcV!.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "TUOKOUXIUSeColVDefSupVId")
        
        view.addSubview(tufuh_collcV!)
        
        tufuh_collcV!.es.addInfiniteScrolling { [weak self] in
            guard let self = self else { return }
            self.tukou_reqSouSuo()
        }
    
    }

    func tukou_noNetwV() {
        tukou_deallCollV()
        tukou_deallTabV()
        tukou_deaNoNetV()
        
        let height = TUOKOUXIUSwiftSCRE_H - TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight - 56 - TUOKOUXIUDeviceInfo.tukou_tabBarHeight
        tufuh_noNetV = UIView.tukou_bjView(
            CGRect(x: 0, y: TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 56, width: TUOKOUXIUSwiftSCRE_W, height: height),
            superView: view,
            bgColor: TUOKOUXIUSwiftheiseC
        )
        
        let label1 = UILabel.tukou_bjLabel(
            CGRect(x: 0, y: height/2 - 12, width: TUOKOUXIUSwiftSCRE_W, height: 20),
            text: "The current network status is abnormal,",
            superView: tufuh_noNetV!,
            textAlignment: .center,
            font: TUOKOUXIUSwiftFont.medium(16),
            textColor: TUOKOUXIUSwiftbaiseC
        )
        
        let label2 = UILabel.tukou_bjLabel(
            CGRect(x: 0, y: label1.frame.maxY + 6, width: TUOKOUXIUSwiftSCRE_W, height: 20),
            text: "please try again later.",
            superView: tufuh_noNetV!,
            textAlignment: .center,
            font: TUOKOUXIUSwiftFont.medium(16),
            textColor: TUOKOUXIUSwiftbaiseC
        )
        
        UIButton.tukou_bjBtn(
            CGRect(x: TUOKOUXIUSwiftSCRE_W/2 - 45, y: label2.frame.maxY + 24, width: 90, height: 36),
            target: self,
            imageName: "",
            superView: tufuh_noNetV!,
            action: #selector(tukou_testNet),
            font: TUOKOUXIUSwiftFont.semibold(14),
            title: "Retry",
            color: TUOKOUXIUSwiftbaiseC,
            bgColor: TUOKOUXIUSwiftZTClr,
            cornerRadius: 5
        )
    }

    func tukou_deaNoNetV() {
        if let noNetV = tufuh_noNetV {
            noNetV.removeFromSuperview()
            tufuh_noNetV = nil
        }
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        tufuh_isSKeyboard = true
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            tufuh_clearBtn.isHidden = false
            tufuh_searchBtn.isHidden = true
        }
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        tufuh_isSKeyboard = false
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.isEmpty {
            tufuh_addStr = string
            tufuh_clearBtn.isHidden = false
            tufuh_searchBtn.isHidden = true
            tukou_deallCollV()
            tukou_creTabV()
            tukou_reqGG(location: range.location, length: range.length)
        } else {
            tufuh_addStr = ""
            guard let text = textField.text else { return true }
            if text.isEmpty { return true }
            
            if text.count == range.length {
 
                tukou_deallTabV()
                tukou_deallCollV()
                tufuh_clearBtn.isHidden = true
                tufuh_searchBtn.isHidden = false
                tukou_hisV()
                return true
            }
            
            if text.count == 1 {

                tukou_deallTabV()
                tukou_deallCollV()
                tufuh_clearBtn.isHidden = true
                tufuh_searchBtn.isHidden = false
                tukou_hisV()
            } else {
                tukou_deallCollV()
                tukou_creTabV()
                tukou_reqGG(location: range.location, length: range.length)
            }
        }
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tufuh_currentPage = 1
        tufuh_pageSize = TUOKOUXIUSSApp.tukou_isPad() ? 30 : 24

        if !tufuh_dataTreArr.isEmpty {
            tufuh_dataTreArr.removeAll()
        }
        tukou_gotoSearResu(string: "")
        tufuh_isSKeyboard = false
        textField.resignFirstResponder()
        return true
    }

    func tukou_reqGG(location: Int, length: Int) {
        if TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() == 0 {
            tukou_noNetwV()
            return
        }

        tufuh_searStr = ""
        if !tufuh_addStr.isEmpty {
            tufuh_searStr = (tufuh_searTF.text as NSString?)?.replacingCharacters(in: NSRange(location: location, length: length), with: tufuh_addStr) ?? ""
        } else {
            if let text = tufuh_searTF.text, !text.isEmpty {
                tufuh_searStr = (text as NSString).replacingCharacters(in: NSRange(location: location, length: length), with: "")
            }
        }

        let routesArr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_routesArr
        guard !routesArr.isEmpty else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }

        let urlStr = (routesArr[0] as? [String: Any])?["cd"] as? String ?? ""
        let ba64Str = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJJM(["cd": urlStr, "ps": [["kv": tufuh_searStr]]])
        guard !TUOKOUXISSUUtils.tukou_isStringEmpty(ba64Str) else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }

        TUOKOUXIUSwiftWWWL.tukou_shared.tukou_requWithURL(TUOKOUXIUSwiftConst.TUOKOUXIUjkzx,
                                                       pars: [ba64Str]) { dataDict, isSuccess in
            guard isSuccess else { return }
            if let arr = dataDict as? [Any] {
                self.tufuh_dataArr.removeAll()
                for item in arr {
                    let ss = "\(item)"
                    if !self.tukou_doesChi(str: ss) {
                        self.tufuh_dataArr.append(ss)
                    }
                }
                self.tufuh_tabV.reloadData()
            }
        }
    }

    func tukou_doesChi(str: String) -> Bool {
        for scalar in str.unicodeScalars {
            if scalar.value > 0x4e00 && scalar.value < 0x9fff {
                return true
            }
        }
        return false
    }

    func tukou_gotoSearResu(string: String) {
        tufuh_clearBtn.isHidden = true
        tufuh_searchBtn.isHidden = false
        tukou_deallTabV()

        if !string.isEmpty {
            tufuh_currentPage = 1
            tufuh_pageSize = TUOKOUXIUSSApp.tukou_isPad() ? 30 : 24
            if !tufuh_dataTreArr.isEmpty { tufuh_dataTreArr.removeAll() }
            tufuh_searTF.text = string
        }

        if let text = tufuh_searTF.text, !text.isEmpty {
            tukou_creCollV()
            tukou_reqSouSuo()
        }
    }

    @objc func tukou_searchBtn() {
        if tufuh_isSKeyboard { return }
        tufuh_isSKeyboard = true
        tufuh_searTF.becomeFirstResponder()
    }
    
    @objc func tukou_clearBtn() {

        tufuh_searTF.text = ""
        tufuh_clearBtn.isHidden = true
        tufuh_searchBtn.isHidden = false
        tufuh_searStr = ""
        tukou_deallTabV()
        tukou_deallCollV()
        tukou_deaNoNetV()

        if !tufuh_dataArr.isEmpty { tufuh_dataArr.removeAll() }
        if !tufuh_dataTreArr.isEmpty { tufuh_dataTreArr.removeAll() }

        tukou_hisV()

        if tufuh_isSKeyboard { return }
        tufuh_isSKeyboard = true
        tufuh_searTF.becomeFirstResponder()
    }

    func tukou_reqSouSuo() {
        guard TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0 else {
            tukou_noNetwV()
            return
        }

        TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_jzGFV(TUOKOUXIUSwiftKeyWinRoV)

        let routesArr = TUOKOUXIUSwiftComSJ.tukou_sLcom.tufuh_routesArr
        guard routesArr.count >= 3 else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }

        let urlStr = (routesArr[2] as? [String: Any])?["cd"] as? String ?? ""
        let requestDict: [String: Any] = [
            "cd": urlStr,
            "ps": [["bid": TUOKOUXIUSSApp.tukou_idfi(),
                    "kv": tufuh_searTF.text ?? "",
                    "lt": tufuh_pageSize,
                    "pg": tufuh_currentPage]]
        ]

        let ba64Str = TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_shuJJM(requestDict)
        guard !TUOKOUXISSUUtils.tukou_isStringEmpty(ba64Str) else {
            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_tipsV()
            return
        }

        TUOKOUXIUSwiftWWWL.tukou_shared.tukou_requWithURL(TUOKOUXIUSwiftConst.TUOKOUXIUjkzx, pars: [ba64Str]) { dataDict, isSuccess in

            TUOKOUXIUSwiftComSJ.tukou_sLcom.tukou_gbGFV()

            if isSuccess {
                if let str = dataDict as? String {
                    self.tukou_checkCode(str) { isSuccess2 in
                        if isSuccess2 {
                            self.tukou_reqSouSuo()
                        }
                    }
                    return
                }

                if let resArr = dataDict as? [Any], !resArr.isEmpty {
                    self.tufuh_collcV!.es.stopLoadingMore()
                    self.tufuh_collcV!.es.resetNoMoreData()
                    self.tufuh_hisV?.removeFromSuperview()
                    self.tufuh_hisV = nil
                    self.tufuh_searTJV?.removeFromSuperview()
                    self.tufuh_searTJV = nil

                    var hisArr = (TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_getArrKey(TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisSearArr) as? [String]) ?? []
                    if let text = self.tufuh_searTF.text, !text.isEmpty {
                        hisArr.removeAll { $0 == text }
                        hisArr.insert(text, at: 0)
                        TUOKOUXIUSwiftShuJCC.tukou_shuJuDL.tukou_setArrV(hisArr, forKey: TUOKOUXIUSwiftConst.TUOKOUXIUSwiftCURHisSearArr)
                    }

                    self.tufuh_currentPage += 1
                    if let arr = resArr as? [[String: Any]] {
                        self.tufuh_dataTreArr.append(contentsOf: arr)
                    }
                    self.tufuh_collcV!.reloadData()
                } else {
                    self.tufuh_collcV!.es.noticeNoMoreData()
                }
            } else {

                self.tufuh_collcV!.es.noticeNoMoreData()

                if self.tufuh_dataTreArr.isEmpty {
                    self.tufuh_hisV?.removeFromSuperview()
                    self.tufuh_hisV = nil
                    self.tufuh_searTJV?.removeFromSuperview()
                    self.tufuh_searTJV = nil
                    self.tukou_noResultsV()
                }
            }
        }
    }

    @objc func tukou_goBack() {
        navigationController?.popToRootViewController(animated: true)
    }

    func tukou_noResultsV() {
        tukou_deallTabV()
        tukou_deallCollV()
        tukou_deaNoNetV()
        tukou_hisV()

        let text = "There are no result for: \"\(tufuh_searTF.text ?? "")\". You can try different keywords or get more content recommended."
        TUOKOUXIUSwiftKeyWindow()!.makeToast(text, duration: 2.0, position: .center)
    }

    @objc func tukou_testNet() {
        if (TUOKOUXIUSwiftNetUt.tukou_getCurrNetSta() != 0) {

            tukou_creCollV()
            tufuh_currentPage = 1

            if TUOKOUXIUSSApp.tukou_isPad() {
                tufuh_pageSize = 30
            } else {
                tufuh_pageSize = 24
            }

            if !tufuh_dataTreArr.isEmpty {
                tufuh_dataTreArr.removeAll()
            }
            tukou_reqSouSuo()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if TUOKOUXIUSSApp.tukou_isPad() {
            return tufuh_dataTreArr.count <= 10 ? 1 : 2
        } else {
            return tufuh_dataTreArr.count <= 9 ? 1 : 2
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if TUOKOUXIUSSApp.tukou_isPad() {
            if tufuh_dataTreArr.count <= 10 { return tufuh_dataTreArr.count }
            return section == 0 ? 10 : tufuh_dataTreArr.count - 10
        } else {
            if tufuh_dataTreArr.count <= 9 { return tufuh_dataTreArr.count }
            return section == 0 ? 9 : tufuh_dataTreArr.count - 9
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if tufuh_dataTreArr.isEmpty {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUSeColVDefCelId", for: indexPath)
        }

        let num: Int
        if indexPath.section == 0 {
            num = 0
        } else {
            num = TUOKOUXIUSSApp.tukou_isPad() ? 10 : 9
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUSeColVCelId", for: indexPath) as! TUOKOUXIUSwiftHHHCollVCell
        cell.tukou_resModel(tufuh_dataTreArr[indexPath.row + num])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if tufuh_dataTreArr.isEmpty { return .zero }
        return CGSize(width: 112 * TUOKOUXIUDeviceInfo.scaleX, height: 160 * TUOKOUXIUDeviceInfo.scaleX + 34)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {

        guard !tufuh_dataTreArr.isEmpty else { return .zero }

        let countThreshold = TUOKOUXIUSSApp.tukou_isPad() ? 10 : 9

        if tufuh_dataTreArr.count <= countThreshold {
            return .zero
        }

        return .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {

        guard !tufuh_dataTreArr.isEmpty else { return .zero }

        let countThreshold = TUOKOUXIUSSApp.tukou_isPad() ? 10 : 9

        if tufuh_dataTreArr.count > countThreshold {
            if section == 0 { return .zero }
            return .zero
        }

        return .zero
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

            return collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "TUOKOUXIUSeColVDefSupVId",
                for: indexPath
            )

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tufuh_dataArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tufuh_dataArr.isEmpty || tufuh_dataArr.count <= indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSeRecDefCelId", for: indexPath)
            cell.backgroundColor = TUOKOUXIUSwiftheiseC
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "TUOKOUXIUSSSReCellId", for: indexPath) as! TUOKOUXIUSwiftSSSReCell
        cell.tukou_contStr((tufuh_dataArr[indexPath.row] as! String))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tufuh_dataArr.isEmpty ? 0 : 45
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 22))
        headerView.backgroundColor = TUOKOUXIUSwiftheiseC

        let label = UILabel(frame: CGRect(x: 10, y: 20, width: TUOKOUXIUSwiftSCRE_W-10, height: 20))
        label.text = "Search \"\(tufuh_searStr)\""
        label.textAlignment = .left
        label.font = TUOKOUXIUSwiftFont.semibold(14)
        label.textColor = TUOKOUXIUSwiftZTClr
        headerView.addSubview(label)

        headerView.tukou_addTapGesture(target: self, action: #selector(tukou_goToSearch))

        return headerView
    }

    @objc func tukou_goToSearch() {
        view.endEditing(true)
        tufuh_currentPage = 1
        tufuh_pageSize = TUOKOUXIUSSApp.tukou_isPad() ? 30 : 24

        if !tufuh_dataTreArr.isEmpty {
            tufuh_dataTreArr.removeAll()
        }

        tukou_gotoSearResu(string: "")
        tufuh_isSKeyboard = false
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 20))
        footerView.backgroundColor = TUOKOUXIUSwiftheiseC
        return footerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tufuh_searTF.resignFirstResponder()
        guard indexPath.row < tufuh_dataArr.count else { return }
        tukou_gotoSearResu(string: tufuh_dataArr[indexPath.row] as! String)
    }
}
