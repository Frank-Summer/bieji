import UIKit
import PhotosUI

final class FeedbackController: UIViewController {

    // MARK: - UI（顶部 & 滚动）
    private let typeTitle = UILabel()
    private let inputBox = FeedbackTextView()
    private var tagList: FeedbackTagListView!

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    // MARK: - 图片数据
    private var images: [UIImage] = []
    private let maxCount = 9

    // MARK: - 九宫格
    private let imageContainer = UIView()
    private let itemSize: CGFloat = 108
    private let spacing: CGFloat = 12
    private var imageContainerHeight: NSLayoutConstraint!

    // MARK: - 联系方式
    private let contactLabel = UILabel()

    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupTopBar()
        setupScrollView()
        setupTypeTitle()
        setupTags()
        setupTextBox()
        setupImageGrid()
        setupContact()
        setupInputField()
        setupBottomButton()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reloadImagesGrid()
        updateDashedBorders()
    }

    // MARK: - 顶部栏（不滚动）
    private func setupTopBar() {
        let topBar = TopBarView()
        topBar.title = LocalizedText.text("feedback.title")
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.onLeftTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        view.addSubview(topBar)

        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: - ScrollView + ContentView
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    // MARK: - 标题
    private func setupTypeTitle() {
        typeTitle.text = LocalizedText.text("feedback.type")
        typeTitle.font = .systemFont(ofSize: 16)
        typeTitle.textColor = .white.withAlphaComponent(0.6)
        typeTitle.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(typeTitle)
        NSLayoutConstraint.activate([
            typeTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            typeTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }

    // MARK: - 标签
    private func setupTags() {
        let vm = FeedbackTypeViewModel(items: [
            LocalizedText.text("feedback.type.productBug"),
            LocalizedText.text("feedback.type.subscription"),
            LocalizedText.text("feedback.type.productSuggestion"),
            LocalizedText.text("feedback.type.contentSuggestion"),
            LocalizedText.text("feedback.type.other")
        ])

        tagList = FeedbackTagListView(viewModel: vm)
        tagList.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tagList)

        NSLayoutConstraint.activate([
            tagList.topAnchor.constraint(equalTo: typeTitle.bottomAnchor, constant: 16),
            tagList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tagList.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - 反馈内容
    private func setupTextBox() {
        inputBox.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(inputBox)

        NSLayoutConstraint.activate([
            inputBox.topAnchor.constraint(equalTo: tagList.bottomAnchor, constant: 24),
            inputBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            inputBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            inputBox.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    // MARK: - 九宫格容器
    private func setupImageGrid() {
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageContainer)

        imageContainerHeight = imageContainer.heightAnchor.constraint(equalToConstant: 110)

        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: inputBox.bottomAnchor, constant: 20),
            imageContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            imageContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            imageContainerHeight
        ])
    }

    // MARK: - 九宫格刷新（含添加 / 删除）
    private func reloadImagesGrid() {
        imageContainer.subviews.forEach { $0.removeFromSuperview() }

        let width = imageContainer.bounds.width
        guard width > 0 else { return }

        var x: CGFloat = 0
        var y: CGFloat = 0

        for (i, img) in images.enumerated() {
            if x + itemSize > width {
                x = 0
                y += itemSize + spacing
            }

            let box = UIView(frame: CGRect(x: x, y: y, width: itemSize, height: itemSize))
            box.layer.cornerRadius = 16
            box.clipsToBounds = true

            let iv = UIImageView(image: img)
            iv.frame = box.bounds
            iv.contentMode = .scaleAspectFill
            box.addSubview(iv)

            box.addSubview(buildDeleteButton(index: i))
            imageContainer.addSubview(box)

            x += itemSize + spacing
        }

        if images.count < maxCount {
            if x + itemSize > width {
                x = 0
                y += itemSize + spacing
            }
            let add = buildAddButton()
            add.frame = CGRect(x: x, y: y, width: itemSize, height: itemSize)
            imageContainer.addSubview(add)
        }

        imageContainerHeight.constant = y + itemSize
    }

    // MARK: - 删除按钮
    private func buildDeleteButton(index: Int) -> UIButton {
        let size: CGFloat = 22
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: itemSize - size - 4, y: 4, width: size, height: size)
        btn.tag = index
        btn.backgroundColor = .systemRed
        btn.layer.cornerRadius = size / 2
        btn.addTarget(self, action: #selector(deleteImage(_:)), for: .touchUpInside)

        let path = UIBezierPath()
        let p: CGFloat = 6
        path.move(to: CGPoint(x: p, y: p))
        path.addLine(to: CGPoint(x: size - p, y: size - p))
        path.move(to: CGPoint(x: size - p, y: p))
        path.addLine(to: CGPoint(x: p, y: size - p))

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 1.6
        shape.lineCap = .round
        btn.layer.addSublayer(shape)

        return btn
    }

    // MARK: - 添加按钮
    private func buildAddButton() -> UIButton {
        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true

        let dash = CAShapeLayer()
        dash.strokeColor = UIColor.white.withAlphaComponent(0.35).cgColor
        dash.lineDashPattern = [4, 4]
        dash.fillColor = UIColor.clear.cgColor
        dash.lineWidth = 1
        btn.layer.addSublayer(dash)
        btn.layer.setValue(dash, forKey: "dashLayer")

        let img = UIImageView(image: UIImage(named: "add_icon"))
        img.translatesAutoresizingMaskIntoConstraints = false
        btn.addSubview(img)

        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            img.widthAnchor.constraint(equalToConstant: 60),
            img.heightAnchor.constraint(equalToConstant: 60)
        ])

        btn.addTarget(self, action: #selector(addImageTap), for: .touchUpInside)
        return btn
    }

    private func updateDashedBorders() {
        for v in imageContainer.subviews {
            if let dash = v.layer.value(forKey: "dashLayer") as? CAShapeLayer {
                dash.frame = v.bounds
                dash.path = UIBezierPath(roundedRect: v.bounds, cornerRadius: 16).cgPath
            }
        }
    }

    // MARK: - 图片事件
    @objc private func deleteImage(_ sender: UIButton) {
        images.remove(at: sender.tag)
        reloadImagesGrid()
    }

    @objc private func addImageTap() {
        var config = PHPickerConfiguration()
        config.selectionLimit = maxCount - images.count
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    // MARK: - 联系方式
    private func setupContact() {
        contactLabel.text = LocalizedText.text("feedback.placeholder.contact")
        contactLabel.font = .systemFont(ofSize: 16)
        contactLabel.textColor = .white.withAlphaComponent(0.6)
        contactLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(contactLabel)

        NSLayoutConstraint.activate([
            contactLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 20),
            contactLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }

    // MARK: - 输入框
    private func setupInputField() {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        tf.layer.cornerRadius = 12
        tf.textColor = .white
        tf.font = .systemFont(ofSize: 16)
        tf.tintColor = .white
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 1))
        tf.leftViewMode = .always
        tf.attributedPlaceholder = NSAttributedString(
            string: LocalizedText.text("feedback.placeholder.phoneOrWeChat"),
            attributes: [.font: UIFont.systemFont(ofSize: 14),
                         .foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )

        contentView.addSubview(tf)
        NSLayoutConstraint.activate([
            tf.topAnchor.constraint(equalTo: contactLabel.bottomAnchor, constant: 12),
            tf.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tf.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            tf.heightAnchor.constraint(equalToConstant: 56),
            tf.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -120) // ⭐关键
        ])
    }

    // MARK: - 底部提交按钮（不随滚动）
    private func setupBottomButton() {
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(submitButton)

        NSLayoutConstraint.activate([
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12)
        ])
    }

    private let submitButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle(LocalizedText.text("feedback.button.submit"), for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 16)
        b.layer.cornerRadius = 16
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.white.cgColor
        b.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        return b
    }()
}

// MARK: - 相册选择
extension FeedbackController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        let group = DispatchGroup()
        var imgs: [UIImage] = []

        for r in results {
            if r.itemProvider.canLoadObject(ofClass: UIImage.self) {
                group.enter()
                r.itemProvider.loadObject(ofClass: UIImage.self) { obj, _ in
                    if let img = obj as? UIImage { imgs.append(img) }
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            self.images += imgs
            self.reloadImagesGrid()
        }
    }
}
