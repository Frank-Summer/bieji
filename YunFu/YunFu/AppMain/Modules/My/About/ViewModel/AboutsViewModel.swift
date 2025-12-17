import UIKit

final class AboutsViewModel {

    let router: AboutsRouter
    private(set) var sections: [AboutSection] = []

    init(router: AboutsRouter) {
        self.router = router
        load()
    }

    func load() {
        sections = [
            AboutSection(
            header: "抖音",
            items: [
                AboutItem(
                    icon: "about_dy",
                    title: "抖音",
                    rightIcon: "chevron_right",
                    action: {
                        
                    }
                )
            ]
        ),

            AboutSection(
            header: "小红书",
            items: [
                AboutItem(
                    icon: "about_xhs",
                    title: "小红书",
                    rightIcon: "chevron_right",
                    action: {
                        print("打开账号与安全")
                    }
                )
            ]
        ),

            AboutSection(
            header: "b站",
            items: [
                AboutItem(
                    icon: "about_bilibili",
                    title: "b站",
                    rightIcon: "chevron_right",
                    action: {
                        print("打开会员开通")
                    }
                )
            ]
        ),

//            AboutSection(
//            header: "公众号",
//            items: [
//                AboutItem(
//                    icon: "about_wx",
//                    title: "公众号",
//                    rightIcon: "chevron_right",
//                    action: {
//                        print("打开通知")
//                    }
//                )
//            ]
//        ),

            AboutSection(
            header: "微博",
            items: [
                AboutItem(
                    icon: "about_wb",
                    title: "微博",
                    rightIcon: "chevron_right",
                    action: {
                        print("打开语言")
                    }
                )
            ]
        ),

        ]
    }
}
