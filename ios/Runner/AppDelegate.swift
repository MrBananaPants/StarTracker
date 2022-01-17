@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  var displayLink : CADisplayLink?
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller = self.window.rootViewController as! FlutterViewController
    
    displayLink = CADisplayLink(target: self, selector: #selector(displayLinkCallback))
    displayLink!.add(to: .current, forMode: .default)
    
      if #available(iOS 15.0, *) {
          displayLink!.preferredFrameRateRange = CAFrameRateRange(minimum:120, maximum:120, preferred:120)
      } else {
          // Fallback on earlier versions
      }
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    @objc func displayLinkCallback() {
         // let workingTime = displayLink!.targetTimestamp - CACurrentMediaTime()
        // At this moment in time, there are `workingTime` seconds available to
        // generate content for the next frame, so
        // Core Animation can render it to the display.
    }

}