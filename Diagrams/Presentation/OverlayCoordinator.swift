import UIKit

class OverlayCoordinator {
    
    static var shared = OverlayCoordinator()
    
    var mainWindow: UIWindow?
    var overlayWindow: UIWindow?
    
    private init() {}
    
    func toggleOverlay() {
        if let win2 = overlayWindow {
            if win2.isKeyWindow {
                mainWindow?.makeKeyAndVisible()
                win2.isHidden = true
            } else {
                win2.isHidden = false
                win2.makeKeyAndVisible()
            }
        }
    }
}
