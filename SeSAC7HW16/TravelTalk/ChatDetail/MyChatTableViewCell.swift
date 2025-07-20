//
//  MyChatTableViewCell.swift
//  SeSAC7HW16
//
//  Created by hyunMac on 7/20/25.
//

import UIKit

class MyChatTableViewCell: UITableViewCell {

    @IBOutlet var chatLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var chatBubble: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    private func configureUI() {
        chatBubble.layer.cornerRadius = 10
        chatBubble.layer.borderWidth = 1
        chatBubble.layer.borderColor = UIColor.lightGray.cgColor
        chatBubble.backgroundColor = UIColor.systemGray6
    }

    func configureData(chat: Chat) {
        chatLabel.text = chat.message

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm"
        let date = df.date(from: chat.date)
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "HH:MM a"
        dateLabel.text = df.string(from: date ?? Date())
    }
}
