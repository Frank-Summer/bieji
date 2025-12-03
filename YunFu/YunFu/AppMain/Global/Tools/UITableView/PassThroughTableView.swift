//
//  PassThroughTableView.swift
//  YunFu
//
//  Created by wanglong on 2025/12/3.
//  Copyright © 2025 DCloud. All rights reserved.
//

import UIKit

class PassThroughTableView: UITableView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

        // 找到当前被点到的 view（可能是 cell 内的子控件）
        let view = super.hitTest(point, with: event)

        // 如果点到的是 cell 内的子视图，则允许响应
        if let view = view, view !== self {
            return view // 正常响应
        }

        // 其它区域让事件往下层传递
        return nil
    }
}
