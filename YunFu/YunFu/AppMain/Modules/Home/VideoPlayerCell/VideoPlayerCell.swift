//
//  VideoPlayerCell.swift
//  YunFu
//
//  Created by wanglong on 2025/12/3.
//  Copyright © 2025 DCloud. All rights reserved.
//

import UIKit

class VideoPlayerCell: UITableViewCell {
    static let identifier = "VideoPlayerCellIdentifier"

    let containerView = UIView()
    let containerIV = UIImageView()
    /// 当 cell 完成 layout 时回调（只会触发一次）
    var onReadyForPlayer: (() -> Void)?

    private var didCallOnReady = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(containerView)
        containerView.frame = contentView.bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.backgroundColor = .black
        containerView.addSubview(containerIV)
        containerIV.frame = containerView.bounds
        containerIV.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerIV.backgroundColor = .black
        containerIV.contentMode = .scaleAspectFill
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 确保 containerView 已有正确 frame 再回调（避免 table 在未 attach 到 window 时提前 layout）
        if !didCallOnReady {
            didCallOnReady = true
            onReadyForPlayer?()
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // 复用时清掉回调，下一次 cell layout 会重新设置
        onReadyForPlayer = nil
        didCallOnReady = false
    }
}
