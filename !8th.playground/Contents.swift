//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Stack<T> {
    let item : T
}

protocol Product {
    var name: String { get }
    var price: Int { get }
}

protocol Coupon {
    var discountPercentage: Int { get }
}

struct CocaCola: Product {
    var name: String {
        return "CocaCola" + UUID().uuidString
    }
    var price: Int
}


struct GymMembership: Coupon {
    var discountPercentage: Int {
        return 8
    }
}

struct JustACouppon : Coupon {
    var discountPercentage: Int
}

protocol PriceCalculatable {}
extension Int : PriceCalculatable {}
extension Double : PriceCalculatable {}




// the beuty of this approach is that we can now run tests on our price culculator in isolation
class PriceCalculator {
    static func culculateFinalPrice(for products: [Product],
                                    applying coupon: Coupon?) -> Double {
        
        let x = products.reduce(0) { price, product in
            return price + product.price
        }
        
        var finalPrice = Double(x)
        
        if let coupon = coupon {
            let multiplier = coupon.discountPercentage / 100
            let discount = Double(finalPrice) * Double(multiplier)
            finalPrice -= Double(discount)
        }
        
        return finalPrice
    }
}

struct Router {}
extension Router {
    var rout: String {
        return "We Routing"
    }
    
    func openCheckoutPage(forProducts product: [Product],
                          _ finalPrice: Double) {
        print("Opening Checkout page")
    }
}

class App {
    static var router = Router()
}

protocol CheckoutPageOpener {
    func openCheckoutPage(forProducts product: [Product], _ finalPrice: Double)
}

extension Router : CheckoutPageOpener {}



class ShoppingCart {
    var products = [Product]()
    var coupon: Coupon?
    let checkoutPageOpener: CheckoutPageOpener
    
    init(checkoutPageOpener: CheckoutPageOpener = App.router) {
        self.checkoutPageOpener = checkoutPageOpener
    }
    
    
    func add(_ product: Product) {
        products.append(product)
    }
    
    func applyCoupoon(_ coupon: Coupon) {
        self.coupon = coupon
    }
    
    func startCheckout() {
        let finalPrice = PriceCalculator.culculateFinalPrice(for: products, applying: coupon)
        App.router.openCheckoutPage(forProducts: products, finalPrice)
    }
}





//-----------TEST------------------------------------------------------------------------------

class CheckoutPageMock: CheckoutPageOpener {
    private(set) var products: [Product]?
    private(set) var finalPrice: Double?
    
    func openCheckoutPage(forProducts product: [Product], _ finalPrice: Double) {
        self.products = product
        self.finalPrice = finalPrice
    }
}

import XCTest

class PriceCalculatorTests: XCTestCase {
    func testCulculatingFinalPriceWithoutCoupon() {
        let products = [
            CocaCola(price: 10),
            CocaCola(price: 30),
            CocaCola(price: 12),
        ]
        
        
        let price = PriceCalculator.culculateFinalPrice(for: products, applying: nil)
        
        XCTAssertEqual(price, 52)
    }
    
    func testCulculatingFinalPriceWithCoupon() {
        let products = [
            CocaCola(price: 10),
            CocaCola(price: 30),
            CocaCola(price: 12),
            ]
        
        let gymCoupon = JustACouppon(discountPercentage: 10)
        
        let price = PriceCalculator.culculateFinalPrice(for: products, applying: gymCoupon)
        
        XCTAssertEqual(price, 46.8)
    }
    
    func testStartingCheckoutOpensCheckoutPage() {
        //Given
        let opener = CheckoutPageMock()
        let cart = ShoppingCart(checkoutPageOpener: opener)
        let product = CocaCola(price: 50)
        let coupon = GymMembership()
        
        //When
        cart.add(product)
        cart.applyCoupoon(coupon)
        cart.startCheckout()
        
        //Then
        XCTAssertEqual(opener.finalPrice, 45)
        //XCTAssertEqual(opener.products, [product])
    }
}


class A {
    let name = "Chris"
}



























