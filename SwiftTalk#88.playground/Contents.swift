//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

var str = "Hello, playground"



let diagram = Diagram.combined(
    .triangle(CGRect(x: 20, y: 20, width: 100, height: 100), .red),
    .ellipse(CGRect(x: 60, y: 60, width: 80, height: 100), .green)
)

let triangle = Diagram.triangle(CGRect(x: 0, y: 0, width: 50, height: 100), .blue)


extension NSView {
    
    var backgroundColor: NSColor? {
        
        get {
            if let colorRef = self.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }
}


//class ViewController : NSViewController {
//    override func loadView() {
//        let customView =  NSView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
//        customView.backgroundColor = .blue
//        self.view = customView
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        view.addSubview(diagramView)
//    }
//}


let frame = CGRect(x: 0, y: 0, width: 200, height: 200)
let diagramView = LayerView(frame, diagram.render())

let customView =  NSView(frame: CGRect(x: 0, y: 0, width: 500, height: 700))
customView.backgroundColor = .blue
//midexcustomView.addSubview(customView)


PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = customView














































