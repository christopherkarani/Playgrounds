import UIKit

var count = 0
var str = "Hello, playground"

var action = {
    print("count:", count)
    count += 1
}

for _ in 0...10 {
    action()
}

protocol AutoLayoutDSL {
    typealias Constraint = (_ child: UIView, _ parent: UIView) -> NSLayoutConstraint
}

extension AutoLayoutDSL {
    func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, _ to: KeyPath<UIView, Anchor>, constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
        return { view, parent in
            view[keyPath: keyPath].constraint(equalTo: parent[keyPath: to], constant: constant)
        }
    }
    
    func equal<Axis, Anchor>(_ keyPath: KeyPath<UIView, Anchor>, constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
        return equal(keyPath, keyPath, constant: constant)
    }
}

extension UIView: AutoLayoutDSL {
    func addSubview(_ child: UIView, constraints: [Constraint]) {
        addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints.map { $0(child, self) })
    }
}
