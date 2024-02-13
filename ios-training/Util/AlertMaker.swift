//
//  AlertMaker.swift
//  ios-training
//
//  Created by 垣本 桃弥 on 2024/02/13.
//

import UIKit

/// `UIAlertController`の生成を行う
struct AlertMaker {
    /// 再試行/キャンセルの選択肢を持つアラートを作成する
    static func retryOrCancelAlert(
        title: String,
        message: String?,
        didTapRetry: ((UIAlertAction) -> Void)?,
        didTapCancel: ((UIAlertAction) -> Void)?
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: "再試行", style: .default, handler: didTapRetry)
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: didTapCancel)
        alert.addAction(retry)
        alert.addAction(cancel)
        return alert
    }
}
