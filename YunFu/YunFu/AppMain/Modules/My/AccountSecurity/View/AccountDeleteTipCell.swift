import UIKit

final class AccountDeleteTipCell: UITableViewCell {

    private let indexLabel = UILabel()
    private let contentLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {

        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        indexLabel.textColor = UIColor.white.withAlphaComponent(0.8)
        indexLabel.font = .systemFont(ofSize: 15)

        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.textColor = .white
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.numberOfLines = 0

        // 行距
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 6
        contentLabel.attributedText = NSAttributedString(string: "", attributes: [.paragraphStyle: paragraph])

        contentView.addSubview(indexLabel)
        contentView.addSubview(contentLabel)

        NSLayoutConstraint.activate([
            indexLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            indexLabel.widthAnchor.constraint(equalToConstant: 15), // ⭐ 这里是新增的
            indexLabel.topAnchor.constraint(equalTo: contentView.topAnchor),

            // 内容文字
            contentLabel.leadingAnchor.constraint(equalTo: indexLabel.trailingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    func configure(item: AccountDeleteTipItem) {
        indexLabel.text = "\(item.index)."

        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 6

        contentLabel.attributedText = NSAttributedString(
            string: item.text,
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 15),
                .paragraphStyle: paragraph
            ]
        )
    }
}
