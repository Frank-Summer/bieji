
import Foundation
import UIKit

class TUOKOUXIUSwiftLBTCell: UITableViewCell, TUOKOUXIUSwiftCycPagVDataSource, TUOKOUXIUSwiftCycPagVDeleg {
    var tufuh_clkItemBlk: (([String: Any]) -> Void)?
    private var tufuh_pagerV: TUOKOUXIUSwiftCycPagV!
    private var tufuh_pageCon: TUOKOUXIUSwiftPageControl!
    
    private var tufuh_dataArr: [Any] = []
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        tukou_addPagV()
        tukou_addPagCon()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tukou_addPagV() {
        let pagerV = TUOKOUXIUSwiftCycPagV()
        pagerV.frame = CGRect(
            x: 0,
            y: 0,
            width: TUOKOUXIUSwiftSCRE_W,
            height: (TUOKOUXIUSwiftSCRE_W / 16) * 9 + TUOKOUXIUDeviceInfo.tukou_statusBarTopHeight + 60
        )

        pagerV.dataSource = self
        pagerV.delegate = self

        pagerV.registerClass(TUOKOUXIUSwiftCycPagVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUPagerViewCellId")
        contentView.addSubview(pagerV)
        tufuh_pagerV = pagerV
    }
    private func tukou_addPagCon() {
        let pageCon = TUOKOUXIUSwiftPageControl()
        pageCon.tufuh_currPagIndSi = CGSize(width: 6, height: 6)
        pageCon.tufuh_pagIndSi = CGSize(width: 12, height: 6)

        pageCon.tufuh_pagIndImg = TUOKOUXIUSwiftComSJ.tukou_sLcom
            .tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_dia_n", andIsOne: false)
        pageCon.tufuh_currPagIndImg = TUOKOUXIUSwiftComSJ.tukou_sLcom
            .tukou_jiaZIcon("TUOKOUXIU_ic_hh_cel_dia_s", andIsOne: false)
        pageCon.tufuh_pagIndSpa = 0

        tufuh_pagerV.addSubview(pageCon)
        tufuh_pageCon = pageCon
        tufuh_pageCon.frame = CGRect(
            x: TUOKOUXIUSwiftSCRE_W - 125,
            y: tufuh_pagerV.frame.height - 20,
            width: 120,
            height: 20
        )
    }
    
    func tukou_resData(_ dataArray: [Any]) {
        tufuh_dataArr = dataArray
        tufuh_pageCon.tufuh_numbOfPag = tufuh_dataArr.count
        tufuh_pagerV.reloadData()
    }
    
    func numberOfItemsInPagerView(_ pageView: TUOKOUXIUSwiftCycPagV) -> Int {
        return tufuh_dataArr.count
    }

    func pagerView(_ pagerView: TUOKOUXIUSwiftCycPagV, cellForItemAtIndex index: Int) -> UICollectionViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUPagerViewCellId",
                forIndex: index) as! TUOKOUXIUSwiftCycPagVCell
        cell.tukou_resData(tufuh_dataArr[index] as! [String : Any])
        return cell
    }
    
    func layoutForPagerView(_ pageView: TUOKOUXIUSwiftCycPagV) -> TUOKOUXIUSwiftCycPagVLayout {
        let layout = TUOKOUXIUSwiftCycPagVLayout()
        layout.itemSize = CGSize(width: pageView.frame.width, height: pageView.frame.height)
        layout.tufuh_itemSpac = 0
        layout.tufuh_itemHorCen = true
        return layout
    }

    func pagerView(_ pageView: TUOKOUXIUSwiftCycPagV, didScrollFromIndex fromIndex: Int, toIndex: Int) {
        tufuh_pageCon.tufuh_currPag = toIndex
    }
    func pagerView(_ pageView: TUOKOUXIUSwiftCycPagV, didSelectedItemCell cell: UICollectionViewCell, atIndex: Int) {
        tufuh_pagerV.reloadData()
        let tufuh_mDict = tufuh_dataArr[atIndex]
        tufuh_clkItemBlk?(tufuh_mDict as! [String : Any])
    }

}

