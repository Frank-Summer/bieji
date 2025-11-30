import UIKit
import PhotosUI

final class FeedbackController: UIViewController {

    // MARK: UI
    private let typeTitle = UILabel()
    private let inputBox = FeedbackTextView()

    // MARK: 图片数据
    private var images: [UIImage] = []
    private let maxCount = 9

    // MARK: 九宫格容器
    private let imageContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let itemSize: CGFloat = 108
    private let spacing: CGFloat = 12

    private var containerHeightConstraint: NSLayoutConstraint?

    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black

        setupTopBar()
        setupTypeTitle()
        setupTags()
        setupTextBox()
        setupImagePickerLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // 这个覆盖方法只有一个，不会再冲突
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        reloadImagesGrid()
        updateDashedBorders()
    }

    // MARK: - 顶部栏
    private func setupTopBar() {

        let topBar = TopBarView()
        topBar.title = "意见反馈"
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

    // MARK: - 标题
    private func setupTypeTitle() {

        typeTitle.text = "反馈类型"
        typeTitle.font = .systemFont(ofSize: 16)
        typeTitle.textColor = UIColor.white.withAlphaComponent(0.6)
        typeTitle.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(typeTitle)

        NSLayoutConstraint.activate([
            typeTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            typeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }

    // MARK: - 标签
    private func setupTags() {

        let viewModel = FeedbackTypeViewModel(items: [
            "产品bug", "会员订阅", "产品建议", "内容建议", "其他"
        ])

        let tagList = FeedbackTagListView(viewModel: viewModel)
        tagList.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tagList)

        NSLayoutConstraint.activate([
            tagList.topAnchor.constraint(equalTo: typeTitle.bottomAnchor, constant: 16),
            tagList.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tagList.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - 输入框
    private func setupTextBox() {

        inputBox.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputBox)

        NSLayoutConstraint.activate([
            inputBox.topAnchor.constraint(equalTo: typeTitle.bottomAnchor, constant: 110),
            inputBox.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputBox.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputBox.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    // MARK: - 九宫格容器
    private func setupImagePickerLayout() {

        view.addSubview(imageContainer)

        containerHeightConstraint = imageContainer.heightAnchor.constraint(equalToConstant: 110)
        containerHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            imageContainer.topAnchor.constraint(equalTo: inputBox.bottomAnchor, constant: 20),
            imageContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    // MARK: - 刷新九宫格布局
    private func reloadImagesGrid() {

        imageContainer.subviews.forEach { $0.removeFromSuperview() }

        let width = imageContainer.bounds.width
        if width <= 0 { return }

        var x: CGFloat = 0
        var y: CGFloat = 0

        // 图片
        for (i, img) in images.enumerated() {

            if x + itemSize > width {  // 换行
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

            // 删除按钮（置顶）
            let del = UIButton(type: .custom)
            del.frame = CGRect(x: itemSize - 30, y: 4, width: 26, height: 26)
            del.setImage(UIImage(named: "delete_icon"), for: .normal)
            del.tag = i
            del.addTarget(self, action: #selector(deleteImage(_:)), for: .touchUpInside)
            box.addSubview(del)
            box.bringSubviewToFront(del)

            imageContainer.addSubview(box)
            x += itemSize + spacing
        }

        // 加号按钮
        if images.count < maxCount {

            if x + itemSize > width {
                x = 0
                y += itemSize + spacing
            }

            let add = buildAddButton()
            add.frame = CGRect(x: x, y: y, width: itemSize, height: itemSize)
            imageContainer.addSubview(add)
        }

        containerHeightConstraint?.constant = y + itemSize
    }

    // MARK: - 创建加号按钮
    private func buildAddButton() -> UIButton {

        let btn = UIButton(type: .custom)
        btn.layer.cornerRadius = 16
        btn.clipsToBounds = true

        // 虚线框
        let dash = CAShapeLayer()
        dash.strokeColor = UIColor.white.withAlphaComponent(0.35).cgColor
        dash.lineDashPattern = [4, 4]
        dash.fillColor = UIColor.clear.cgColor
        dash.lineWidth = 1
        btn.layer.addSublayer(dash)
        btn.layer.setValue(dash, forKey: "dashLayer")

        // 加号图标
        let img = UIImageView(image: UIImage(named: "add_icon"))
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        btn.addSubview(img)

        NSLayoutConstraint.activate([
            img.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
            img.centerYAnchor.constraint(equalTo: btn.centerYAnchor),
            img.widthAnchor.constraint(equalToConstant: 40),
            img.heightAnchor.constraint(equalToConstant: 40)
        ])

        btn.addTarget(self, action: #selector(addImageTap), for: .touchUpInside)
        return btn
    }

    // MARK: - 修复虚线框
    private func updateDashedBorders() {

        for v in imageContainer.subviews {
            if let dash = v.layer.value(forKey: "dashLayer") as? CAShapeLayer {
                dash.frame = v.bounds
                dash.path = UIBezierPath(roundedRect: v.bounds, cornerRadius: 16).cgPath
            }
        }
    }

    // MARK: 删除图片
    @objc private func deleteImage(_ sender: UIButton) {
        images.remove(at: sender.tag)
        reloadImagesGrid()
        updateDashedBorders()
    }

    // MARK: 添加图片
    @objc private func addImageTap() {

        var config = PHPickerConfiguration()
        config.selectionLimit = maxCount - images.count
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - 相册选择
extension FeedbackController: PHPickerViewControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

        picker.dismiss(animated: true)

        let group = DispatchGroup()
        var selectedImgs: [UIImage] = []

        for r in results {
            let provider = r.itemProvider

            if provider.canLoadObject(ofClass: UIImage.self) {
                group.enter()
                provider.loadObject(ofClass: UIImage.self) { obj, _ in
                    if let img = obj as? UIImage { selectedImgs.append(img) }
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            self.images += selectedImgs
            self.reloadImagesGrid()
            self.updateDashedBorders()
        }
    }
}
