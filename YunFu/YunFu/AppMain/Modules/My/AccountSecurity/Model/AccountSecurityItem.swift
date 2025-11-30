import Foundation


struct AccountSecurityItem {
    let id = UUID() 
    let title: String
    let value: String?
    let state: String?
    let icon: String
    let action: (() -> Void)
}
