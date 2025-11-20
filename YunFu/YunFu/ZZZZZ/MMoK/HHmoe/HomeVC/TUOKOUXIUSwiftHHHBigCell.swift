
import UIKit

class TUOKOUXIUSwiftHHHBigCell: UITableViewCell {

    var tufuh_clkItemBlk: (([String: Any]) -> Void)?

    private var tufuh_dataArr: [[String: Any]] = []

    private lazy var tufuh_collcV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = TUOKOUXIUSwiftheiseC
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHBigDefCellId")
        collectionView.register(TUOKOUXIUSwiftHHHBigCollVCell.self, forCellWithReuseIdentifier: "TUOKOUXIUHHHBigCollVCellId")
        collectionView.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHHHBigTbCoHeaReuVId")
        collectionView.register(TUOKOUXIUSwiftHHHCollReuV.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHBigTbColFoReuVId")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "TUOKOUXIUHHHBigTabVHisDefSuppVId")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TUOKOUXIUHHHBigTabVHisDefSuppVId")

        return collectionView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        tukou_initV()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func tukou_initV() {
        contentView.backgroundColor = TUOKOUXIUSwiftheiseC
        contentView.isUserInteractionEnabled = true
        tufuh_collcV.frame = CGRect(x: 0, y: 0, width: TUOKOUXIUSwiftSCRE_W, height: 3 * (50.0 / 9.0) * 16 * TUOKOUXIUDeviceInfo.scaleX + 79 + 6)
        contentView.addSubview(tufuh_collcV)
    }

    func tukou_resData(_ dataArray: [[String: Any]]) {
        self.tufuh_dataArr = dataArray
        tufuh_collcV.reloadData()
    }
}

extension TUOKOUXIUSwiftHHHBigCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(tufuh_dataArr.count, 10)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !tufuh_dataArr.isEmpty else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHBigDefCellId", for: indexPath)
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TUOKOUXIUHHHBigCollVCellId", for: indexPath) as! TUOKOUXIUSwiftHHHBigCollVCell
        cell.tukou_resModel(tufuh_dataArr[indexPath.row])

        cell.tufuh_ClkItemBlk = { [weak self] dict, num in
            guard let self = self,
                  let tufuh_arr = dict["value"] as? [[String: Any]],
                  num < tufuh_arr.count else { return }
            let tufuh_d = tufuh_arr[num]
            self.tufuh_clkItemBlk?(tufuh_d)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard !tufuh_dataArr.isEmpty else { return .zero }
        return CGSize(width: 244, height: 3 * (50.0 / 9.0) * 16 * TUOKOUXIUDeviceInfo.scaleX + 79)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 3 * (50.0 / 9.0) * 16 * TUOKOUXIUDeviceInfo.scaleX + 79)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 3 * (50.0 / 9.0) * 16 * TUOKOUXIUDeviceInfo.scaleX + 79)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUHHHBigTbColFoReuVId", for: indexPath)
        } else if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUHHHBigTbCoHeaReuVId", for: indexPath)
        } else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TUOKOUXIUHHHBigTabVHisDefSuppVId", for: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
